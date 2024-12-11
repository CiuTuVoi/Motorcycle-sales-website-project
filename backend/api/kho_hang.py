from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models.models import KhoHang
from fastapi.security import OAuth2PasswordBearer
import jwt
from models.database import get_db


router = APIRouter()

SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Middleware phân quyền
def verify_role(required_role: str):
    def role_checker(token: str = Depends(oauth2_scheme)):
        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            user_role = payload.get("role")
            if user_role != required_role:
                raise HTTPException(status_code=403, detail="Access denied")
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")
    return role_checker

# Schema sản phẩm
class KhohangCreate(BaseModel):
    ma_san_pham: int
    so_luong: int

    class Config:
        from_attributes = True


# API: Lấy danh sách kho hàng (chỉ cho admin)
@router.get("/khohang")
def get_khohang(db: Session = Depends(get_db), _: str = Security(verify_role("Admin"))):  # Kiểm tra role admin
    khohang = db.query(KhoHang).all()
    if not khohang:
        raise HTTPException(status_code=404, detail="Không tìm thấy số lượng kho hàng")
    return khohang


# API: Thêm sản số lượng  (chỉ cho admin)
@router.post("/khohang", response_model=KhohangCreate)
def create_khohang(
    khohang_create: KhohangCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Kiểm tra nếu sản phẩm đã tồn tại
    existing_khohang = db.query(KhoHang).filter(KhoHang.ma_san_pham == khohang_create.ma_san_pham).first()
    if existing_khohang:
        raise HTTPException(status_code=400, detail="Trùng sản phẩm")

    # Tạo đối tượng kho hàng mới từ dữ liệu nhận được
    new_khohang = KhoHang(
        ma_san_pham=khohang_create.ma_san_pham,
        so_luong=khohang_create.so_luong
        
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
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
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
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    khohang = db.query(KhoHang).filter(KhoHang.ma_san_pham == khohang_id).first()
    if not khohang:
        raise HTTPException(status_code=404, detail="Kho Hang not found")
    
    db.delete(khohang)
    db.commit()
    return {"message": "Kho Hang deleted successfully"}
