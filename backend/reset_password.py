from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel, EmailStr
from datetime import datetime, timedelta
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models import NguoiDung  
import redis
from email_utils import send_email  
from password_utils import hash_password  # Hàm mã hóa mật khẩu
from dotenv import load_dotenv
import os
import secrets

# Load môi trường từ .env
load_dotenv()

# Kết nối Redis
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = os.getenv("REDIS_PORT", 6379)
REDIS_DB = 0  # Redis database index

redis_client = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=REDIS_DB, decode_responses=True)

# Database configuration
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

SQLALCHEMY_DATABASE_URL = f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
# APIRouter
router = APIRouter()

# Dependency to get database session
def get_db():
    # Đảm bảo rằng bạn có cấu hình SessionLocal trong project của mình
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Dữ liệu yêu cầu cho reset password
class ResetPasswordRequest(BaseModel):
    token: str
    new_password: str

# API yêu cầu đặt lại mật khẩu
@router.post("/reset-password-request")
def reset_password_request(email: EmailStr, db: Session = Depends(get_db)):
    """API để yêu cầu đặt lại mật khẩu qua email."""
    user = db.query(NguoiDung).filter(NguoiDung.email == email).first()
    if not user:
        raise HTTPException(status_code=404, detail="Email không tồn tại.")
    
    # Tạo reset token
    reset_token = secrets.token_urlsafe(32)
    token_expiry = datetime.utcnow() + timedelta(minutes=30)

    # Lưu reset_token và token_expiry vào Redis
    redis_client.setex(f"reset_token:{reset_token}", timedelta(minutes=30), email)
    
    # Gửi link reset mật khẩu qua email
    reset_link = f"https://yourapp.com/reset-password?token={reset_token}"
    send_email(email, "Reset mật khẩu", f"Click vào liên kết sau để đặt lại mật khẩu: {reset_link}")
    
    return {"message": "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn."}

# API để đặt lại mật khẩu sử dụng Pydantic model
@router.post("/reset-password")
def reset_password(data: ResetPasswordRequest, db: Session = Depends(get_db)):
    """API để đặt lại mật khẩu bằng token và mật khẩu mới."""
    token = data.token
    new_password = data.new_password
    
    # Kiểm tra token hợp lệ trong Redis
    email = redis_client.get(f"reset_token:{token}")
    
    if not email:
        raise HTTPException(status_code=400, detail="Token không hợp lệ hoặc đã hết hạn.")
    
    # Lấy người dùng từ cơ sở dữ liệu
    user = db.query(NguoiDung).filter(NguoiDung.email == email).first()
    if not user:
        raise HTTPException(status_code=404, detail="Email không tồn tại.")
    
    # Mã hóa mật khẩu mới và cập nhật cho người dùng
    hashed_password = hash_password(new_password)
    user.mat_khau = hashed_password
    db.commit()

    # Xóa token khỏi Redis sau khi sử dụng
    redis_client.delete(f"reset_token:{token}")
    
    return {"message": "Mật khẩu đã được cập nhật thành công."}
