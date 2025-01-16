from fastapi import APIRouter, Depends, HTTPException, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session

from core.security import verify_role
from models.database import get_db
from models.models import KhoHang

router = APIRouter()


# Schema sản phẩm
class KhohangCreate(BaseModel):
    ma_san_pham: int
    so_luong: int

    class Config:
        from_attributes = True


# API: Lấy danh sách kho hàng (chỉ cho admin)
@router.get("/khohang")
def get_khohang(
    db: Session = Depends(get_db), _: str = Security(verify_role("Admin"))
):  # Kiểm tra role admin
    khohang = db.query(KhoHang).all()
    if not khohang:
        raise HTTPException(status_code=404, detail="Không tìm thấy số lượng kho hàng")
    return khohang


# API: Thêm sản số lượng  (chỉ cho admin)
@router.post("/khohang", response_model=KhohangCreate)
def create_khohang(
    khohang_create: KhohangCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    # Kiểm tra nếu sản phẩm đã tồn tại
    existing_khohang = (
        db.query(KhoHang)
        .filter(KhoHang.ma_san_pham == khohang_create.ma_san_pham)
        .first()
    )
    if existing_khohang:
        raise HTTPException(status_code=400, detail="Trùng sản phẩm")

    # Tạo đối tượng kho hàng mới từ dữ liệu nhận được
    new_khohang = KhoHang(
        ma_san_pham=khohang_create.ma_san_pham, so_luong=khohang_create.so_luong
    )

    # Lưu số lượng vào cơ sở dữ liệu
    db.add(new_khohang)
    db.commit()
    db.refresh(new_khohang)

    # Trả về số lượng mới tạo
    return KhohangCreate.from_orm(new_khohang)


# API: Sửa số lượng sản phẩm (chỉ cho admin)
@router.put("/khohang/{khohang_id}", response_model=KhohangCreate)
def update_khohang(
    khohang_id: int,
    khohang_update: KhohangCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    # Tìm sản phẩm trong cơ sở dữ liệu
    khohang = db.query(KhoHang).filter(KhoHang.ma_san_pham == khohang_id).first()

    if not khohang:
        raise HTTPException(status_code=404, detail="KhoHang not found")

    # Cập nhật thông tin sản phẩm
    khohang.so_luong = khohang_update.so_luong

    # Commit thay đổi vào cơ sở dữ liệu
    db.commit()
    db.refresh(khohang)

    # Trả về sản phẩm sau khi cập nhật
    return KhohangCreate.from_orm(khohang)


# API: Xóa sản phẩm (chỉ cho admin)
@router.delete("/khohang/{khohang_id}")
def delete_khohang(
    khohang_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Kiểm tra role admin
):
    khohang = db.query(KhoHang).filter(KhoHang.ma_san_pham == khohang_id).first()
    if not khohang:
        raise HTTPException(status_code=404, detail="Kho Hang not found")

    db.delete(khohang)
    db.commit()
    return {"message": "Kho Hang deleted successfully"}
