from datetime import datetime, timedelta
import jwt
from fastapi import Depends, HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy.orm import Session
from models.database import get_db
from models.models import NguoiDung

http_bearer = HTTPBearer()
SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
REFRESH_TOKEN_EXPIRE_DAYS = 7


# Tạo token JWT
def create_token(data: dict, expires_delta: timedelta):
    to_encode = data.copy()
    expire = datetime.utcnow() + expires_delta
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def decode_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token đã hết hạn")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token không hợp lệ")


def create_access_token(data: dict):
    return create_token(data, timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))


def create_refresh_token(data: dict):
    return create_token(data, timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS))


# Middleware phân quyền
def verify_role(required_role: str):
    def role_checker(token: HTTPAuthorizationCredentials = Depends(http_bearer)):
        try:
            # Giải mã token để lấy thông tin người dùng
            payload = jwt.decode(token.credentials, SECRET_KEY, algorithms=[ALGORITHM])

            # Lấy vai trò từ token
            user_role = payload.get("role")

            if user_role is None:
                raise HTTPException(
                    status_code=401, detail="Không có vai trò trong token"
                )

            # Kiểm tra vai trò người dùng
            if user_role != required_role:
                raise HTTPException(
                    status_code=403, detail="Access denied: Không đủ quyền truy cập"
                )

        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")

    return role_checker


# Middleware giải mã token và lấy thông tin người dùng
def extract_user_data(token: HTTPAuthorizationCredentials = Depends(http_bearer)):
    try:
        payload = jwt.decode(token.credentials, SECRET_KEY, algorithms=[ALGORITHM])
        return payload  # Trả về payload chứa thông tin người dùng
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token đã hết hạn")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token không hợp lệ")


# Dependency to verify and decode access token and get current user from database
def get_current_user(
    token: HTTPAuthorizationCredentials = Depends(http_bearer),
    db: Session = Depends(get_db),
):
    try:
        payload = decode_token(token.credentials)
        email = payload.get("sub")  # Lấy email từ payload

        if not email:
            raise HTTPException(status_code=401, detail="Không thể xác minh người dùng")

        # Truy vấn người dùng trong cơ sở dữ liệu
        user = db.query(NguoiDung).filter(NguoiDung.email == email).first()
        if not user:
            raise HTTPException(status_code=404, detail="Người dùng không tồn tại")
        
        return user

    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token đã hết hạn")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token không hợp lệ")
