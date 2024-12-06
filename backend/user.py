from fastapi import APIRouter, HTTPException, Depends, status
from pydantic import BaseModel, EmailStr
from enum import Enum
from sqlalchemy.orm import Session
from models import NguoiDung
from password_utils import hash_password, verify_password
from fastapi.security import OAuth2PasswordBearer
import jwt
from database import get_db
from datetime import datetime, timedelta
import re

# FastAPI router setup
router = APIRouter()

# JWT configuration
SECRET_KEY = "your_secret_key"  # Replace this with a secure key
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Enum vai trò người dùng
class VaiTroEnum(str, Enum):
    admin = 'Admin'
    user = 'User'

# Enum trạng thái người dùng
class TrangThaiEnum(str, Enum):
    hoatDong = 'HoatDong'
    biKhoa = 'BiKhoa'

# Schema cho tạo người dùng mới
class UserCreate(BaseModel):
    ten_dang_nhap: str
    mat_khau: str
    ho_ten: str
    tuoi: int
    gioi_tinh: str
    email: EmailStr
    so_dien_thoai: str
    dia_chi: str
    vai_tro: VaiTroEnum = VaiTroEnum.user
    trang_thai: TrangThaiEnum

# Schema cho đăng nhập
class LoginRequest(BaseModel):
    ten_dang_nhap: str  # Tên đăng nhập (email hoặc số điện thoại)
    mat_khau: str

# Kiểm tra tên đăng nhập là email hay số điện thoại
def is_email(ten_dang_nhap: str) -> bool:
    # Kiểm tra định dạng email
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return bool(re.match(email_regex, ten_dang_nhap))

def is_phone_number(ten_dang_nhap: str) -> bool:
    # Kiểm tra định dạng số điện thoại
    phone_regex = r'^(0[3-9])([0-9]{8})$'
    return bool(re.match(phone_regex, ten_dang_nhap))


# Tạo token JWT
def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    access_token = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return access_token

# API: Đăng nhập và lấy token
@router.post("/login", status_code=status.HTTP_200_OK)
def login(request: LoginRequest, db: Session = Depends(get_db)):
    # Kiểm tra người dùng trong cơ sở dữ liệu
    user = None
    print(f"Đang kiểm tra tài khoản: {request.ten_dang_nhap}")  # Debug thông tin tài khoản
    if is_email(request.ten_dang_nhap):
        print("Kiểm tra email")
        user = db.query(NguoiDung).filter(NguoiDung.email == request.ten_dang_nhap).first()
    elif is_phone_number(request.ten_dang_nhap):
        print("Kiểm tra số điện thoại")
        user = db.query(NguoiDung).filter(NguoiDung.so_dien_thoai == request.ten_dang_nhap).first()

    if not user:
        print("Không tìm thấy người dùng trong cơ sở dữ liệu")  # Debug
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tài khoản không tồn tại"
        )

    # Kiểm tra mật khẩu
    if not verify_password(request.mat_khau, user.mat_khau):
        print(f"Kiểm tra mật khẩu sai: {request.mat_khau} != {user.mat_khau}")  # Debug
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tài khoản hoặc mật khẩu không chính xác"
        )

    # Tạo token JWT
    access_token = create_access_token(data={
        "sub": user.email,  # email của người dùng
        "role": user.vai_tro,  # vai trò người dùng
        "ma_nguoi_dung": user.ma_nguoi_dung  # thêm ma_nguoi_dung vào token
    })

    return {"access_token": access_token, "token_type": "bearer", "role": user.vai_tro}

# API: Lấy thông tin người dùng (chỉ dành cho admin)
@router.get("/users/me")
def read_users_me(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("sub")
        role = payload.get("role")
        ma_nguoi_dung = payload.get("ma_nguoi_dung")

        if not email or not role:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token không hợp lệ"
            )

        # Kiểm tra nếu người dùng là admin
        if role != 'Admin':
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bạn không có quyền truy cập vào tài nguyên này"
            )

        # Nếu là admin, lấy danh sách tất cả người dùng
        users = db.query(NguoiDung).all()  # Lấy tất cả người dùng

        if not users:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Không tìm thấy người dùng"
            )

        # Trả về thông tin của tất cả người dùng
        return [
            {"email": user.email, "role": user.vai_tro, "ma_nguoi_dung": user.ma_nguoi_dung}
            for user in users
        ]

    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token đã hết hạn"
        )
    except jwt.PyJWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token không hợp lệ"
        )
