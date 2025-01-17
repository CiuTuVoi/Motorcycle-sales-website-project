from decimal import Decimal
from enum import Enum
from typing import Optional
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, Field
from sqlalchemy.orm import Session
from models.database import get_db
from models.models import DonHang, KhoHang, NguoiDung, ThongBao, SanPham
from core.security import get_current_user, verify_role

router = APIRouter()

# Enum trạng thái đơn hàng
class TrangThaiEnum(str, Enum):
    dangXuLy = "Dang_xu_ly"
    hoanThanh = "Hoan_thanh"
    daHuy = "Da_huy"


class DonHangCreate(BaseModel):
    ma_nguoi_dung: Optional[int] = None
    ma_san_pham: int
    so_luong: int
    don_gia: Optional[Decimal] = None
    tong_tien: Optional[Decimal] = None
    trang_thai: TrangThaiEnum = TrangThaiEnum.dangXuLy

    class Config:
        from_attributes = True

    # Tính toán tổng tiền
    def calculate_total(self, don_gia: Decimal):
        self.tong_tien = don_gia * self.so_luong


# Sửa create_thong_bao để đảm bảo logic
def create_thong_bao(
    ma_nguoi_dung: int, noi_dung: str, loai_thong_bao: str, db: Session
):
    if loai_thong_bao not in ["Khuyenmai", "Riengtu"]:
        raise HTTPException(status_code=400, detail="Loại thông báo không hợp lệ")

    thong_bao = ThongBao(
        ma_nguoi_dung=ma_nguoi_dung,
        noi_dung=noi_dung,
        loai_thong_bao=loai_thong_bao,
        da_doc="chưa đọc",
    )
    try:
        db.add(thong_bao)
        db.commit()
        db.refresh(thong_bao)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi khi tạo thông báo: {str(e)}")


# API: Lấy danh sách đơn hàng của người dùng
@router.get("/donhang")
def get_donhang(
    db: Session = Depends(get_db), user: NguoiDung = Depends(get_current_user)
):
    ma_nguoi_dung = user.ma_nguoi_dung
    donhang_list = (
        db.query(DonHang).filter(DonHang.ma_nguoi_dung == ma_nguoi_dung).all()
    )

    if not donhang_list:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")

    return [DonHangCreate.from_orm(dh) for dh in donhang_list]


# API: Thêm đơn hàng mới
@router.post("/donhang", response_model=DonHangCreate)
def create_donhang(
    donhang_create: DonHangCreate,
    db: Session = Depends(get_db),
    user: NguoiDung = Depends(get_current_user),  # Lấy thông tin người dùng đã đăng nhập
):
    """
    API này dùng để tạo một đơn hàng mới.
    """
    # Lấy ma_nguoi_dung từ đối tượng người dùng đã đăng nhập
    ma_nguoi_dung = user.ma_nguoi_dung

    # Kiểm tra xem người dùng có tồn tại không
    if not db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == ma_nguoi_dung).first():
        raise HTTPException(status_code=404, detail="Người dùng không tồn tại")

    # Kiểm tra số lượng trong kho
    kho_hang = (
        db.query(KhoHang)
        .filter(KhoHang.ma_san_pham == donhang_create.ma_san_pham)
        .first()
    )
    if not kho_hang or kho_hang.so_luong < donhang_create.so_luong:
        raise HTTPException(status_code=400, detail="Số lượng trong kho không đủ")

    # Lấy thông tin sản phẩm từ bảng SanPham
    san_pham = db.query(SanPham).filter(SanPham.ma_san_pham == donhang_create.ma_san_pham).first()
    if not san_pham:
        raise HTTPException(status_code=404, detail="Sản phẩm không tồn tại")

    # Kiểm tra xem có giá khuyến mãi hay không
    don_gia = san_pham.gia_khuyen_mai if san_pham.gia_khuyen_mai is not None else san_pham.gia
    donhang_create.don_gia = don_gia  # Lấy đơn giá (gia hoặc gia_khuyen_mai) của sản phẩm

    # Tính toán tổng tiền
    donhang_create.calculate_total(donhang_create.don_gia)

    # Thiết lập trạng thái mặc định cho đơn hàng
    donhang_create.trang_thai = TrangThaiEnum.dangXuLy

    # Tạo đối tượng DonHang
    donhang_data = donhang_create.dict()
    donhang_data.pop("ma_nguoi_dung", None)  # Không cần truyền "ma_nguoi_dung" từ client
    new_donhang = DonHang(**donhang_data, ma_nguoi_dung=ma_nguoi_dung)

    # Thêm đơn hàng vào cơ sở dữ liệu
    db.add(new_donhang)

    # Cập nhật số lượng sản phẩm trong kho
    kho_hang.so_luong -= donhang_create.so_luong
    db.commit()
    db.refresh(new_donhang)

    # Gửi thông báo khi đơn hàng được tạo
    create_thong_bao(
        ma_nguoi_dung,
        f"Thông báo: Đơn hàng của bạn đã được tạo thành công và đang xử lý.",
        "Riengtu",
        db,
    )

    # Trả về đơn hàng mới
    return DonHangCreate.from_orm(new_donhang)


# API: Sửa đơn hàng
@router.put("/donhang/{donhang_id}", response_model=DonHangCreate)
def update_donhang(
    donhang_id: int,
    donhang_update: DonHangCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role("User")),
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")

    # Kiểm tra và lấy đơn hàng
    donhang = (
        db.query(DonHang)
        .filter(
            DonHang.ma_don_hang == donhang_id, DonHang.ma_nguoi_dung == ma_nguoi_dung
        )
        .first()
    )
    if not donhang:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")

    # Lấy thông tin sản phẩm từ kho hàng
    kho_hang = db.query(KhoHang).filter(KhoHang.ma_san_pham == donhang.ma_san_pham).first()
    if not kho_hang:
        raise HTTPException(status_code=404, detail="Sản phẩm không tồn tại trong kho")

    # Kiểm tra giá của sản phẩm trong kho
    san_pham = db.query(SanPham).filter(SanPham.ma_san_pham == donhang.ma_san_pham).first()
    if san_pham:
        don_gia = san_pham.gia_khuyen_mai if san_pham.gia_khuyen_mai is not None else san_pham.gia
        donhang_update.calculate_total(don_gia)

    donhang_update_data = donhang_update.dict()
    donhang_update_data.pop("ma_nguoi_dung", None)
    for key, value in donhang_update_data.items():
        setattr(donhang, key, value)

    db.commit()
    db.refresh(donhang)

    # Gửi thông báo khi trạng thái đơn hàng thay đổi
    if donhang.trang_thai == "Hoan_thanh":
        create_thong_bao(
            ma_nguoi_dung, f"Đơn hàng của bạn đã được giao thành công.", "Riengtu", db
        )
    elif donhang.trang_thai == "Da_huy":
        create_thong_bao(ma_nguoi_dung, f"Đơn hàng của bạn đã bị hủy.", "Riengtu", db)

    return DonHangCreate.from_orm(donhang)

# API: Xóa đơn hàng
@router.delete("/donhang/{donhang_id}")
def delete_donhang(
    donhang_id: int,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role("User")),
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")

    donhang = (
        db.query(DonHang)
        .filter(
            DonHang.ma_don_hang == donhang_id, DonHang.ma_nguoi_dung == ma_nguoi_dung
        )
        .first()
    )
    if not donhang:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")

    if donhang.trang_thai == "Dang_xu_ly":
        kho_hang = (
            db.query(KhoHang).filter(KhoHang.ma_san_pham == donhang.ma_san_pham).first()
        )
        if kho_hang:
            kho_hang.so_luong += donhang.so_luong

    db.delete(donhang)
    db.commit()

    create_thong_bao(ma_nguoi_dung, f"Đơn hàng của bạn đã bị hủy.", "Riengtu", db)

    return {"message": "Đơn hàng đã được hủy thành công"}
