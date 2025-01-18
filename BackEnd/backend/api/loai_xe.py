import jwt
from fastapi import APIRouter, Depends, HTTPException, Security
from fastapi.security import HTTPBearer
from pydantic import BaseModel
from sqlalchemy.orm import Session

from core.security import verify_role
from models.database import get_db
from models.models import LoaiXe

router = APIRouter()


# Schema loại xe
class LoaixeCreate(BaseModel):
    loai_xe: int

    class Config:
        from_attributes = True


# API: Lấy danh sách loại xe không cần đăng nhập
@router.get("/loaixe")
def get_loaixe(db: Session = Depends(get_db)):
    loaixe = db.query(LoaiXe).all()
    if not loaixe:
        raise HTTPException(status_code=404, detail="Không tìm thấy loại xe")
    return loaixe


# API: Thêm loại xe  (chỉ cho admin)
@router.post("/loaixe", response_model=LoaixeCreate)
def create_loaixe(
    loaixe_create: LoaixeCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    # Kiểm tra nếu sản phẩm đã tồn tại
    existing_loaixe = (
        db.query(LoaiXe).filter(LoaiXe.ma_loai_xe == loaixe_create.ma_loai_xe).first()
    )
    if existing_loaixe:
        raise HTTPException(status_code=400, detail="Trùng loại xe")

    # Tạo đối tượng loại xe mới từ dữ liệu nhận được
    new_loaixe = LoaiXe(loai_xe=loaixe_create.loai_xe)

    # Lưu Loại xe vào cơ sở dữ liệu
    db.add(new_loaixe)
    db.commit()
    db.refresh(new_loaixe)

    # Trả về loại xe mới tạo
    return LoaixeCreate.from_orm(new_loaixe)


# API: Sửa loại xe (chỉ cho admin)
@router.put("/loaixe/{loaixe_id}", response_model=LoaixeCreate)
def update_loaixe(
    loaixe_id: int,
    loaixe_update: LoaixeCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    # Tìm sản phẩm trong cơ sở dữ liệu
    loaixe = db.query(LoaiXe).filter(LoaiXe.ma_loai_xe == loaixe_id).first()

    if not loaixe:
        raise HTTPException(status_code=404, detail="Loai Xe not found")

    # Cập nhật thông tin sản phẩm
    loaixe.loai_xe = loaixe_update.loai_xe

    # Commit thay đổi vào cơ sở dữ liệu
    db.commit()
    db.refresh(loaixe)

    # Trả về Loại xe sau khi cập nhật
    return LoaixeCreate.from_orm(loaixe)


# API: Xóa loại xe (chỉ cho admin)
@router.delete("/loaixe/{loaixe_id}")
def delete_loaixe(
    loaixe_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    loaixe = db.query(LoaiXe).filter(LoaiXe.ma_loai_xe == loaixe_id).first()
    if not loaixe:
        raise HTTPException(status_code=404, detail="Loai Xe not found")

    db.delete(loaixe)
    db.commit()
    return {"message": "Loai Xe deleted successfully"}
