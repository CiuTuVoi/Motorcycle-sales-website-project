from datetime import datetime
from decimal import Decimal

from fastapi import APIRouter, Depends, HTTPException, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session

from core.security import verify_role
from models.database import get_db
from models.models import KhuyenMai

router = APIRouter()


# Schema khuyến mại
class KhuyenmaiCreate(BaseModel):
    ten_khuyen_mai: str
    mo_ta: str
    muc_giam: Decimal
    ngay_bat_dau: datetime
    ngay_ket_thuc: datetime

    class Config:
        from_attributes = True


# API: Lấy danh sách khuyến mại không cần đăng nhập
@router.get("/khuyenmai")
def get_khuyenmai(db: Session = Depends(get_db)):
    khuyenmai = db.query(KhuyenMai).all()
    if not khuyenmai:
        raise HTTPException(status_code=404, detail="Không tìm thấy khuyến mại")
    return khuyenmai


# API: Thêm khuyến mại  (chỉ cho admin)
@router.post("/khuyenmai", response_model=KhuyenmaiCreate)
def create_khuyenmai(
    khuyenmai_create: KhuyenmaiCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    # Kiểm tra nếu khuyến mại đã tồn tại
    existing_khuyenmai = (
        db.query(KhuyenMai)
        .filter(KhuyenMai.ten_khuyen_mai == khuyenmai_create.ten_khuyen_mai)
        .first()
    )
    if existing_khuyenmai:
        raise HTTPException(status_code=400, detail="Trùng khuyến mại")

    # Tạo đối tượng khuyến mại mới từ dữ liệu nhận được
    new_khuyenmai = KhuyenMai(
        ten_khuyen_mai=khuyenmai_create.ten_khuyen_mai,
        mo_ta=khuyenmai_create.mo_ta,
        muc_giam=khuyenmai_create.muc_giam,
        ngay_bat_dau=khuyenmai_create.ngay_bat_dau,
        ngay_ket_thuc=khuyenmai_create.ngay_ket_thuc,
    )

    # Lưu khuyến mại vào cơ sở dữ liệu
    db.add(new_khuyenmai)
    db.commit()
    db.refresh(new_khuyenmai)

    # Trả về khuyến mại mới tạo
    return KhuyenmaiCreate.from_orm(new_khuyenmai)


# API: Sửa khuyến mại (chỉ cho admin)
# API: Sửa khuyến mại (chỉ cho admin)
@router.put("/khuyenmai/{khuyenmai_id}", response_model=KhuyenmaiCreate)
def update_khuyenmai(
    khuyenmai_id: int,
    khuyenmai_update: KhuyenmaiCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    # Tìm khuyến mại trong cơ sở dữ liệu
    khuyenmai = (
        db.query(KhuyenMai).filter(KhuyenMai.ma_khuyen_mai == khuyenmai_id).first()
    )

    if not khuyenmai:
        raise HTTPException(status_code=404, detail="Khuyen Mai not found")

    # Cập nhật thông tin khuyến mại
    khuyenmai.ten_khuyen_mai = khuyenmai_update.ten_khuyen_mai
    khuyenmai.mo_ta = khuyenmai_update.mo_ta
    khuyenmai.muc_giam = khuyenmai_update.muc_giam
    khuyenmai.ngay_bat_dau = khuyenmai_update.ngay_bat_dau
    khuyenmai.ngay_ket_thuc = khuyenmai_update.ngay_ket_thuc

    # Commit thay đổi vào cơ sở dữ liệu
    db.commit()
    db.refresh(khuyenmai)

    # Trả về Khuyến mại sau khi cập nhật
    return KhuyenmaiCreate.from_orm(khuyenmai)


# API: Xóa khuyến mại (chỉ cho admin)
@router.delete("/khuyenmai/{khuyenmai_id}")
def delete_khuyenmai(
    khuyenmai_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    khuyenmai = (
        db.query(KhuyenMai).filter(KhuyenMai.ma_khuyen_mai == khuyenmai_id).first()
    )
    if not khuyenmai:
        raise HTTPException(status_code=404, detail="Khuyen Mai not found")

    db.delete(khuyenmai)
    db.commit()
    return {"message": "Khuyen Mai deleted successfully"}
