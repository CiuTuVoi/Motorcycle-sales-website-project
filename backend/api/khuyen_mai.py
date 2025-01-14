from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from decimal import Decimal
from datetime import datetime
from sqlalchemy.orm import Session
from models.models import KhuyenMai
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
            # Giải mã token để lấy thông tin người dùng
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            
            # Lấy vai trò từ token
            user_role = payload.get("role")
            
            if user_role is None:
                raise HTTPException(status_code=401, detail="Không có vai trò trong token")
            
            # Kiểm tra vai trò người dùng
            if user_role != required_role:
                raise HTTPException(status_code=403, detail="Access denied: Không đủ quyền truy cập")
        
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")
        
    return role_checker

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
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Kiểm tra nếu khuyến mại đã tồn tại
    existing_khuyenmai = db.query(KhuyenMai).filter(KhuyenMai.ten_khuyen_mai == khuyenmai_create.ten_khuyen_mai).first()
    if existing_khuyenmai:
        raise HTTPException(status_code=400, detail="Trùng khuyến mại")

    # Tạo đối tượng khuyến mại mới từ dữ liệu nhận được
    new_khuyenmai = KhuyenMai(
        ten_khuyen_mai=khuyenmai_create.ten_khuyen_mai,
        mo_ta = khuyenmai_create.mo_ta,
        muc_giam = khuyenmai_create.muc_giam,
        ngay_bat_dau = khuyenmai_create.ngay_bat_dau,
        ngay_ket_thuc = khuyenmai_create.ngay_ket_thuc
    )

    # Lưu khuyến mại vào cơ sở dữ liệu
    db.add(new_khuyenmai)
    db.commit()
    db.refresh(new_khuyenmai)

    # Trả về khuyến mại mới tạo
    return KhuyenmaiCreate.from_orm(new_khuyenmai)


# API: Sửa khuyến mại (chỉ cho admin)
@router.put("/khuyenmai/{khuyenmai_id}", response_model=KhuyenmaiCreate)
def update_khuyenmai(
    khuyenmai_id: int,
    khuyenmai_update: KhuyenmaiCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Tìm khuyến mại trong cơ sở dữ liệu
    khuyenmai = db.query(KhuyenMai).filter(KhuyenMai.ma_khuyen_mai == khuyenmai_id).first()
    
    if not khuyenmai:
        raise HTTPException(status_code=404, detail="Khuyen Mai not found")
    
    # Cập nhật thông tin khuyến mại
    khuyenmai.ten_khuyen_mai = khuyenmai_update.ten_khuyen_mai,
    khuyenmai.mo_ta = khuyenmai_update.mo_ta,
    khuyenmai.muc_giam = khuyenmai_update.muc_giam,
    khuyenmai.ngay_bat_dau = khuyenmai_update.ngay_bat_dau,
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
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    khuyenmai = db.query(KhuyenMai).filter(KhuyenMai.ma_khuyen_mai == khuyenmai_id).first()
    if not khuyenmai:
        raise HTTPException(status_code=404, detail= "Khuyen Mai not found")
    
    db.delete(khuyenmai)
    db.commit()
    return {"message": "Khuyen Mai deleted successfully"}
