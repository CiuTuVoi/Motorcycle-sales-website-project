from decimal import Decimal
from enum import Enum
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, Field
from sqlalchemy import types  # Sửa lại import Decimal
from sqlalchemy.orm import Session
from core.security import get_current_user
from core.security import verify_role
from models.database import get_db  # Hàm lấy session DB
from models.models import DonHang, KhoHang, NguoiDung, ThongBao

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
    don_gia: Decimal = Field(
        ..., gt=0, description="Đơn giá của sản phẩm, phải lớn hơn 0"
    )
    tong_tien: Optional[Decimal] = None
    trang_thai: TrangThaiEnum = TrangThaiEnum.dangXuLy

    class Config:
        from_attributes = True

    # Tính toán tổng tiền
    def calculate_total(self):
        self.tong_tien = self.don_gia * self.so_luong


# Sửa create_thong_bao để đảm bảo logic
def create_thong_bao(
    ma_nguoi_dung: int, noi_dung: str, loai_thong_bao: str, db: Session
):
    # Kiểm tra giá trị của loai_thong_bao có hợp lệ không
    if loai_thong_bao not in ["Khuyenmai", "Riengtu"]:
        raise HTTPException(status_code=400, detail="Loại thông báo không hợp lệ")

    thong_bao = ThongBao(
        ma_nguoi_dung=ma_nguoi_dung,
        noi_dung=noi_dung,
        loai_thong_bao=loai_thong_bao,
        da_doc="chưa đọc",  # Mặc định là chưa đọc
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
    ma_nguoi_dung = user.ma_nguoi_dung  # Lấy từ đối tượng người dùng trong cơ sở dữ liệu
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
    user_data: dict = Depends(verify_role("User")),
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")

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

    # Tính toán tổng tiền
    donhang_create.calculate_total()

    donhang_data = donhang_create.dict()
    donhang_data.pop("ma_nguoi_dung", None)

    # Tạo đối tượng DonHang
    new_donhang = DonHang(**donhang_data, ma_nguoi_dung=ma_nguoi_dung)
    db.add(new_donhang)

    # Trừ số lượng trong kho
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

    donhang_update.calculate_total()

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

    # Nếu trạng thái là Dang_xu_ly, trả lại số lượng vào kho
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
