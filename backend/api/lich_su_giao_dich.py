from enum import Enum

from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session

from core.security import extract_user_data
from models.database import get_db  # Hàm lấy session DB
from models.models import DonHang, LichSuGiaoDich, NguoiDung

router = APIRouter()


class loaiThanhToan(str, Enum):
    tienMat = "TienMat"
    sTK = "STK"


class trangThaiGiaoHang(str, Enum):
    HoanThanh = "Hoan_thanh"
    DaHuy = "Da_huy"


# Schema: Lịch sử giao dịch
class LichSuGiaoDichCreate(BaseModel):
    ma_don_hang: int
    loai_thanh_toan: loaiThanhToan = loaiThanhToan.tienMat
    trang_thai_giao_hang: trangThaiGiaoHang

    class Config:
        from_attributes = True


# API Lấy danh sách lịch sử giao dịch của người dùng
@router.get("/lichsugiaodich")
def get_lichsugiaodich(
    db: Session = Depends(get_db),
    user_data: dict = Depends(extract_user_data),
    page: int = 1,
    page_size: int = 10,
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(
            status_code=401, detail="Token không chứa thông tin người dùng"
        )

    # Truy vấn lịch sử giao dịch với phân trang
    lichsugiaodich = (
        db.query(LichSuGiaoDich)
        .join(DonHang, LichSuGiaoDich.ma_don_hang == DonHang.ma_don_hang)
        .filter(LichSuGiaoDich.ma_nguoi_dung == ma_nguoi_dung)
        .offset((page - 1) * page_size)
        .limit(page_size)
        .all()
    )

    if not lichsugiaodich:
        raise HTTPException(status_code=404, detail="Không có lịch sử giao dịch")

    # Kiểm tra trạng thái đơn hàng và cập nhật lịch sử giao dịch
    for dg in lichsugiaodich:
        don_hang = (
            db.query(DonHang).filter(DonHang.ma_don_hang == dg.ma_don_hang).first()
        )
        if don_hang:
            # Chỉ cập nhật trạng thái giao hàng khi đơn hàng hoàn thành hoặc bị hủy
            if don_hang.trang_thai == "Hoan_thanh":
                dg.trang_thai_giao_hang = "Hoan_thanh"
            elif don_hang.trang_thai == "Da_huy":
                dg.trang_thai_giao_hang = "Da_huy"
            # Nếu đơn hàng "DangGiao", không cần cập nhật gì, vì trạng thái của đơn hàng này chưa hoàn tất.

    # Trả về kết quả
    return [
        {
            "ma_giao_dich": dg.ma_giao_dich,
            "ma_don_hang": dg.ma_don_hang,
            "loai_thanh_toan": dg.loai_thanh_toan,
            "trang_thai_giao_hang": dg.trang_thai_giao_hang,
        }
        for dg in lichsugiaodich
    ]
