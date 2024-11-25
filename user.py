from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, EmailStr
from enum import Enum
from sqlalchemy.orm import Session
from models import User
from password_utils import hash_password  # Import hàm mã hóa mật khẩu
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from dotenv import load_dotenv
import os

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

SQLALCHEMY_DATABASE_URL = f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

engine = create_engine(SQLALCHEMY_DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

router = APIRouter()

# Enum cho vai trò người dùng
class VaiTroEnum(str, Enum):
    admin = 'admin'
    user = 'khach_hang'

# Schema để nhận dữ liệu từ yêu cầu POST
class UserCreate(BaseModel):
    ten: str
    email: EmailStr
    mat_khau: str
    vai_tro: VaiTroEnum

# Hàm lấy session cơ sở dữ liệu
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/users")
def get_user(db: Session = Depends(get_db)):
    users = db.query(User).all()
    return users

@router.post("/users")
def create_user(user_create: UserCreate, db: Session = Depends(get_db)):
    # Kiểm tra nếu tài khoản đã tồn tại
    existing_user = db.query(User).filter(User.email == user_create.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Tài khoản đã tồn tại")

    # Mã hóa mật khẩu
    hashed_password = hash_password(user_create.mat_khau)

    # Tạo đối tượng người dùng mới
    new_user = User(
        ten=user_create.ten,
        email=user_create.email,
        mat_khau=hashed_password,  # Lưu mật khẩu đã mã hóa
        vai_tro=user_create.vai_tro.value  # Lưu giá trị vai trò
    )

    # Thêm vào cơ sở dữ liệu
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    print("Đã thêm người dùng thành công")
    return {"message": "Tạo người dùng thành công", "user": {"ten": new_user.ten, "email": new_user.email}}
