from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from pydantic import EmailStr
from models import User
from email_utils import send_email
from password_utils import hash_password
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
import os
import secrets

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

# APIRouter
router = APIRouter()

# Dependency to get database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# API to request password reset
@router.post("/reset-password-request")
def reset_password_request(email: EmailStr, db: Session = Depends(get_db)):
    """API to request password reset via email."""
    user = db.query(User).filter(User.email == email).first()
    if not user:
        raise HTTPException(status_code=404, detail="Email không tồn tại.")
    
    # Generate reset token
    reset_token = secrets.token_urlsafe(32)
    user.reset_token = reset_token
    user.token_expiry = datetime.utcnow() + timedelta(minutes=30)
    db.commit()

    # Send reset link via email
    reset_link = f"https://yourapp.com/reset-password?token={reset_token}"
    send_email(email, "Reset mật khẩu", f"Click vào liên kết sau để đặt lại mật khẩu: {reset_link}")
    return {"message": "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn."}

# API to reset password
@router.post("/reset-password")
def reset_password(token: str, new_password: str, db: Session = Depends(get_db)):
    """API to reset password using the token."""
    user = db.query(User).filter(User.reset_token == token).first()
    if not user or user.token_expiry < datetime.utcnow():
        raise HTTPException(status_code=400, detail="Token không hợp lệ hoặc đã hết hạn.")
    
    # Hash new password and update user
    hashed_password = hash_password(new_password)
    user.mat_khau = hashed_password
    user.reset_token = None
    user.token_expiry = None
    db.commit()
    return {"message": "Mật khẩu đã được cập nhật thành công."}
