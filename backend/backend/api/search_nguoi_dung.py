from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from typing import List
from rapidfuzz import fuzz
import re
from enum import Enum
import jwt
from sqlalchemy.orm import Session
from models.models import NguoiDung as NguoiDungModel
from fastapi.security import OAuth2PasswordBearer
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

class VaiTro(str, Enum):
    admin = 'Admin'
    user = 'User'

class TrangThai(str, Enum):
    hoatDong = 'HoatDong'
    biKhoa = 'BiKhoa'

# Tạo base schema cho người dùng
class NguoiDungBase(BaseModel):
    ho_ten: str
    tuoi: int
    gioi_tinh: str
    email: str
    so_dien_thoai: str
    dia_chi: str
    vai_tro: VaiTro
    trang_thai: TrangThai 


# Schema đọc dữ liệu sản phẩm
class NguoiDungSchema(NguoiDungBase):
    ma_nguoi_dung: int

    class Config:
        from_attributes = True

def normalize_string(s: str) -> str:
    # Loại bỏ khoảng trắng và chuyển về chữ thường
    return re.sub(r"\s+", "", s).lower()


# API Tìm kiếm người dùng cụ thể thông qua tên người dùng chỉ dành cho admin
@router.get("/users/by_name/", response_model=NguoiDungSchema)
def search_user_by_name(ten_nguoi_dung: str, 
                        db: Session = Depends(get_db),
                        _: str = Security(verify_role("Admin"))):
    # Làm sạch chuỗi nhập
    ten_nguoi_dung_clean = normalize_string(ten_nguoi_dung)
    
    # Lấy tất cả người dùng trong cơ sở dữ liệu
    all_users = db.query(NguoiDungModel).all()
    
    # Tìm người dùng khớp nhất bằng fuzzy matching
    best_match = None
    highest_score = 0
    for nguoidung in all_users:
        user_normalized = normalize_string(nguoidung.ho_ten)  # Tìm kiếm theo họ tên người dùng
        score = fuzz.partial_ratio(ten_nguoi_dung_clean, user_normalized)
        if score > highest_score and score > 80:  # Ngưỡng điểm tương đồng 80%
            best_match = nguoidung
            highest_score = score
    
    if not best_match:
        raise HTTPException(status_code=404, detail="Không tìm thấy người dùng phù hợp")
    
    return best_match
