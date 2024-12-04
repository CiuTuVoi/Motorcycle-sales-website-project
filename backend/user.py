from fastapi import APIRouter, HTTPException, Depends, status
from pydantic import BaseModel, EmailStr
from enum import Enum
from sqlalchemy.orm import Session
from models import NguoiDung
from password_utils import hash_password, verify_password
from fastapi.security import OAuth2PasswordBearer
import jwt
from datetime import datetime, timedelta
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Database configuration
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

SQLALCHEMY_DATABASE_URL = f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

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
    vai_tro: VaiTroEnum
    trang_thai: TrangThaiEnum

# Schema cho đăng nhập
class LoginRequest(BaseModel):
    email: EmailStr
    mat_khau: str

# Database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Tạo token JWT
def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# API: Tạo người dùng mới
@router.post("/users", status_code=status.HTTP_201_CREATED)
def create_user(user_create: UserCreate, db: Session = Depends(get_db)):
    # Kiểm tra nếu tài khoản đã tồn tại
    existing_user = db.query(NguoiDung).filter(NguoiDung.email == user_create.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Tài khoản đã tồn tại")

    # Mã hóa mật khẩu
    hashed_password = hash_password(user_create.mat_khau)

    # Tạo đối tượng người dùng mới
    new_user = NguoiDung(
        ten_dang_nhap=user_create.ten_dang_nhap,
        mat_khau=hashed_password,
        ho_ten=user_create.ho_ten,
        tuoi=user_create.tuoi,
        gioi_tinh=user_create.gioi_tinh,
        email=user_create.email,
        so_dien_thoai=user_create.so_dien_thoai,
        dia_chi=user_create.dia_chi,
        vai_tro=user_create.vai_tro.value,
        trang_thai=user_create.trang_thai.value
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return {"message": "Tạo người dùng thành công", "user": {"ten": new_user.ho_ten, "email": new_user.email, "so_dien_thoai": new_user.so_dien_thoai, "dia_chi": new_user.dia_chi}}

# API: Đăng nhập và lấy token
@router.post("/login", status_code=status.HTTP_200_OK)
def login(request: LoginRequest, db: Session = Depends(get_db)):
    # Kiểm tra người dùng trong cơ sở dữ liệu
    user = db.query(NguoiDung).filter(NguoiDung.email == request.email).first()
    if not user or not verify_password(request.mat_khau, user.mat_khau):  
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tài khoản hoặc mật khẩu không chính xác"
        )

    # Tạo token JWT
    access_token = create_access_token(data={"sub": user.email, "role": user.vai_tro})
    return {"access_token": access_token, "token_type": "bearer", "role": user.vai_tro}


# API: Lấy thông tin người dùng (chỉ dành cho admin)
@router.get("/users/me")
def read_users_me(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("sub")
        role = payload.get("role")
        if not email or not role:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token không hợp lệ"
            )
        user = db.query(NguoiDung).filter(NguoiDung.email == email).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Người dùng không tồn tại"
            )
        return {"email": user.email, "role": user.vai_tro}
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
