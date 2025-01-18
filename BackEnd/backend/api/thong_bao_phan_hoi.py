from enum import Enum

import jwt
from fastapi import APIRouter, Depends, HTTPException, Request, Security
from fastapi.security import HTTPBearer
from pydantic import BaseModel
from sqlalchemy.orm import Session
from core.security import get_current_user
from core.security import verify_role
from models.database import get_db
from models.models import DanhGia, KhuyenMai, NguoiDung, PhanHoi, ThongBao

router = APIRouter()


# Schema cho tạo phản hồi
class PhanHoiCreate(BaseModel):
    ma_danh_gia: int  # Mã đánh giá mà phản hồi liên quan
    noi_dung: str  # Nội dung phản hồi


class TrangThaiThongBao(str, Enum):
    khuyenMai = "Khuyenmai"
    riengTu = "Riengtu"


class DaDoc(str, Enum):
    daDoc = "đã đọc"
    chuaDoc = "chưa đọc"

# Schema cho thông báo
class ThongBaoRead(BaseModel):
    ma_thong_bao: int
    ma_nguoi_dung: int
    noi_dung: str
    da_doc: DaDoc = DaDoc.chuaDoc
    loai_thong_bao: TrangThaiThongBao = (
        TrangThaiThongBao.riengTu
    )  # mặc định là riêng tư

    class Config:
        from_attributes = True


# API : lấy ra thông báo của người dùng
@router.get("/thongbao")
def get_thongbao(
    db: Session = Depends(get_db), user: NguoiDung = Depends(get_current_user)
):
    """
    API này dùng để lấy toàn bộ thông báo đối với từng người dùng
    """
    if user is None:
        raise HTTPException(status_code=401, detail="Người dùng không hợp lệ")

    ma_nguoi_dung = user.ma_nguoi_dung  # Lấy từ đối tượng người dùng trong cơ sở dữ liệu
    thongbao_list = (
        db.query(ThongBao).filter(ThongBao.ma_nguoi_dung == ma_nguoi_dung).all()
    )

    if not thongbao_list:
        raise HTTPException(status_code=404, detail="Không tìm thấy thông báo")

    return [ThongBaoRead.from_orm(dh) for dh in thongbao_list]


# API: Tạo phản hồi và gửi thông báo
@router.post("/phan-hoi/", response_model=ThongBaoRead)
def create_phan_hoi(
    phan_hoi: PhanHoiCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role),  # Lấy dữ liệu người dùng từ token
):
    """
    API này dùng để tạo phản hồi từ đánh giá đối với người dùng
    """
    # Lấy mã người dùng từ token
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Người dùng không xác thực.")

    # 1. Kiểm tra xem đánh giá có tồn tại không
    danh_gia = (
        db.query(DanhGia).filter(DanhGia.ma_danh_gia == phan_hoi.ma_danh_gia).first()
    )
    if not danh_gia:
        raise HTTPException(status_code=404, detail="Đánh giá không tồn tại.")

    # 2. Tạo phản hồi mới
    new_phan_hoi = PhanHoi(
        ma_danh_gia=phan_hoi.ma_danh_gia,
        ma_nguoi_dung=ma_nguoi_dung,  # Dùng mã người dùng từ token
        noi_dung=phan_hoi.noi_dung,
    )
    db.add(new_phan_hoi)
    db.commit()
    db.refresh(new_phan_hoi)

    # 3. Tạo thông báo cho người tạo đánh giá (Thông báo trả lời bình luận)
    noi_dung_thong_bao = f"Người dùng {ma_nguoi_dung} đã trả lời đánh giá của bạn."
    new_thong_bao = ThongBao(
        ma_nguoi_dung=danh_gia.ma_nguoi_dung,  # Người nhận thông báo là chủ của đánh giá
        noi_dung=noi_dung_thong_bao,
        loai_thong_bao="Riengtu",  # Loại thông báo là trả lời bình luận
    )
    db.add(new_thong_bao)
    db.commit()
    db.refresh(new_thong_bao)

    return new_thong_bao


# API: Tạo phản hồi khi chủ đánh giá phản hồi lại
@router.post("/phan-hoi/rep/", response_model=ThongBaoRead)
def reply_to_phan_hoi(
    phan_hoi: PhanHoiCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role),  # Lấy dữ liệu người dùng từ token
):
    """
    API này dùng để tạo thông báo phản hồi và trả lời đánh giá
    """
    # Lấy mã người dùng từ token
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Người dùng không xác thực.")

    # 1. Kiểm tra xem đánh giá có tồn tại không
    danh_gia = (
        db.query(DanhGia).filter(DanhGia.ma_danh_gia == phan_hoi.ma_danh_gia).first()
    )
    if not danh_gia:
        raise HTTPException(status_code=404, detail="Đánh giá không tồn tại.")

    # 2. Tạo phản hồi mới
    new_phan_hoi = PhanHoi(
        ma_danh_gia=phan_hoi.ma_danh_gia,
        ma_nguoi_dung=ma_nguoi_dung,  # Dùng mã người dùng từ token
        noi_dung=phan_hoi.noi_dung,
    )
    db.add(new_phan_hoi)
    db.commit()
    db.refresh(new_phan_hoi)

    # 3. Tạo thông báo cho người phản hồi trước đó (Thông báo trả lời phản hồi)
    noi_dung_thong_bao = f"Người dùng {ma_nguoi_dung} đã trả lời phản hồi của bạn."
    new_thong_bao = ThongBao(
        ma_nguoi_dung=danh_gia.ma_nguoi_dung,  # Người nhận thông báo là chủ của phản hồi ban đầu
        noi_dung=noi_dung_thong_bao,
        loai_thong_bao="Riengtu",  # Loại thông báo là trả lời phản hồi
    )
    db.add(new_thong_bao)
    db.commit()
    db.refresh(new_thong_bao)

    return new_thong_bao


@router.post("/tao_thong_bao_khuyen_mai")
async def tao_thong_bao_khuyen_mai(khuyen_mai_id: int, db: Session = Depends(get_db),_: str = Security(verify_role("Admin"))):
    """
    API này dùng để tạo thông báo khuyến mại đến tất cả người dùng
    """
    # Lấy thông tin khuyến mãi từ bảng KhuyenMai
    khuyen_mai = (
        db.query(KhuyenMai).filter(KhuyenMai.ma_khuyen_mai == khuyen_mai_id).first()
    )

    if not khuyen_mai:
        raise HTTPException(status_code=404, detail="Khuyến mãi không tồn tại")

    # Tạo thông báo khuyến mãi cho tất cả người dùng
    nguoi_dung_list = (
        db.query(NguoiDung).filter(NguoiDung.trang_thai == "HoatDong").all()
    )
    for nguoi_dung in nguoi_dung_list:
        thong_bao = ThongBao(
            ma_nguoi_dung=nguoi_dung.ma_nguoi_dung,
            noi_dung=f"Chương trình khuyến mãi: {khuyen_mai.ten_khuyen_mai} - {khuyen_mai.mo_ta}",
            loai_thong_bao="Khuyenmai",  # Thông báo khuyến mãi
        )
        db.add(thong_bao)

    db.commit()
    return {"message": "Thông báo khuyến mãi đã được gửi đến tất cả người dùng."}


@router.patch("/thong_bao/{ma_thong_bao}", response_model=ThongBaoRead)
async def mark_notification_as_read(
    ma_thong_bao: int,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role),
):
    """
    API này dùng để kiểm tra xem người dùng đã đọc thông báo hay chưa
    """
    # Lấy mã người dùng từ token
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Người dùng không xác thực.")

    # Tìm thông báo trong cơ sở dữ liệu
    thong_bao = db.query(ThongBao).filter(ThongBao.ma_thong_bao == ma_thong_bao).first()
    if not thong_bao:
        raise HTTPException(status_code=404, detail="Thông báo không tồn tại.")

    # Kiểm tra nếu người dùng có quyền đánh dấu thông báo là đã đọc (chủ sở hữu thông báo)
    if thong_bao.ma_nguoi_dung != ma_nguoi_dung:
        raise HTTPException(
            status_code=403, detail="Không có quyền đánh dấu thông báo này."
        )

    # Cập nhật trạng thái đã đọc của thông báo
    thong_bao.da_doc = True
    db.commit()
    db.refresh(thong_bao)

    return thong_bao
