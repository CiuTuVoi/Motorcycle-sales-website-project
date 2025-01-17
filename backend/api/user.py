import re
from datetime import datetime, timedelta
from enum import Enum

import jwt
from fastapi import APIRouter, Cookie, Depends, HTTPException, Response, status
from fastapi.security import HTTPBearer
from pydantic import BaseModel, EmailStr
from sqlalchemy.orm import Session

from core.security import (
    REFRESH_TOKEN_EXPIRE_DAYS,
    create_access_token,
    create_refresh_token,
    decode_token,
    get_current_user,
    http_bearer,
)
from models.database import get_db
from models.models import NguoiDung
from password.password_utils import hash_password, verify_password

# FastAPI router setup
router = APIRouter()


class Token(BaseModel):
    access_token: str
    token_type: str


# Enum vai trò người dùng
class VaiTroEnum(str, Enum):
    admin = "Admin"
    user = "User"


class UpdateUserRole(BaseModel):
    role_update: VaiTroEnum


# Enum trạng thái người dùng
class TrangThaiEnum(str, Enum):
    hoatDong = "HoatDong"
    biKhoa = "BiKhoa"


class UpdateUserStatus(BaseModel):
    status_update: TrangThaiEnum


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
    vai_tro: VaiTroEnum = VaiTroEnum.user  # Mặc định là User
    trang_thai: TrangThaiEnum = TrangThaiEnum.hoatDong  # Mặc định là Hoạt Động


# Schema cho đăng nhập
class LoginRequest(BaseModel):
    ten_dang_nhap: str  # Tên đăng nhập (email hoặc số điện thoại)
    mat_khau: str


# Kiểm tra tên đăng nhập là email hay số điện thoại
def is_email(ten_dang_nhap: str) -> bool:
    # Kiểm tra định dạng email
    email_regex = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
    return bool(re.match(email_regex, ten_dang_nhap))


def is_phone_number(ten_dang_nhap: str) -> bool:
    # Kiểm tra định dạng số điện thoại
    phone_regex = r"^(0[3-9])([0-9]{8})$"
    return bool(re.match(phone_regex, ten_dang_nhap))


# API: Đăng nhập và lấy token
@router.post("/login", status_code=status.HTTP_200_OK)
def login(request: LoginRequest, response: Response, db: Session = Depends(get_db)):
    """
    API này sẽ tạo access token và refresh token
    """
    user = None
    if is_email(request.ten_dang_nhap):
        user = (
            db.query(NguoiDung).filter(NguoiDung.email == request.ten_dang_nhap).first()
        )
    elif is_phone_number(request.ten_dang_nhap):
        user = (
            db.query(NguoiDung)
            .filter(NguoiDung.so_dien_thoai == request.ten_dang_nhap)
            .first()
        )

    if not user or not verify_password(request.mat_khau, user.mat_khau):
        raise HTTPException(
            status_code=401, detail="Tài khoản hoặc mật khẩu không chính xác"
        )

    if user.trang_thai == "BiKhoa":
        raise HTTPException(status_code=401, detail="Tài khoản bị khóa")

    # Tạo token
    token_data = {
        "sub": user.email,
        "role": user.vai_tro,
        "ma_nguoi_dung": user.ma_nguoi_dung,
    }
    access_token = create_access_token(token_data)
    refresh_token = create_refresh_token(token_data)

    # Lưu refresh token vào DB
    user.refresh_token = refresh_token
    user.refresh_token_expire_at = datetime.utcnow() + timedelta(
        days=REFRESH_TOKEN_EXPIRE_DAYS
    )
    db.commit()

    # Gửi refresh token qua cookie
    response.set_cookie(
        key="refresh_token",
        value=refresh_token,
        httponly=True,
        secure=True,
        samesite="lax",
    )
    return {"access_token": access_token, "token_type": "bearer"}


# API: Lấy thông tin người dùng, bao gồm role
@router.get("/user_info", response_model=UserCreate)
def get_user_info(current_user: dict = Depends(get_current_user)):
    """
    API này sẽ giải mã token và trả về thông tin người dùng cho frontend
    """
    return current_user


# API: Refresh token
@router.post("/refresh_token", status_code=status.HTTP_200_OK)
def refresh_token(
    response: Response, db: Session = Depends(get_db), refresh_token: str = Cookie(None)
):
    """
    API này sẽ giải mã refresh token và trả về access token mới
    """
    if not refresh_token:
        raise HTTPException(status_code=401, detail="No refresh token provided")

    payload = decode_token(refresh_token)
    email = payload.get("sub")
    user = db.query(NguoiDung).filter(NguoiDung.email == email).first()

    if not user or user.refresh_token != refresh_token:
        raise HTTPException(
            status_code=401, detail="Refresh token không hợp lệ hoặc đã bị thu hồi"
        )

    # Tạo token mới
    new_access_token = create_access_token({"sub": email, "role": payload.get("role")})
    new_refresh_token = create_refresh_token(
        {"sub": email, "role": payload.get("role")}
    )

    # Cập nhật refresh token
    user.refresh_token = new_refresh_token
    user.refresh_token_expire_at = datetime.utcnow() + timedelta(
        days=REFRESH_TOKEN_EXPIRE_DAYS
    )
    db.commit()

    # Gửi refresh token mới qua cookie
    response.set_cookie(
        key="refresh_token",
        value=new_refresh_token,
        httponly=True,
        secure=True,
        samesite="lax",
    )
    return {"access_token": new_access_token, "token_type": "bearer"}


# API: Logout tài khoản người dùng
@router.post("/logout", status_code=status.HTTP_200_OK)
def logout(
    response: Response, db: Session = Depends(get_db), refresh_token: str = Cookie(None)
):
    """
    API này để thoát tài khoản và xóa refresh token khỏi cơ sở dữ liệu
    """
    if refresh_token:
        try:
            payload = decode_token(refresh_token)
            email = payload.get("sub")
            user = db.query(NguoiDung).filter(NguoiDung.email == email).first()
            if user:
                user.refresh_token = None
                user.refresh_token_expire_at = None
                db.commit()
        except jwt.PyJWTError:
            pass

    response.delete_cookie("refresh_token")
    return {"message": "Logged out successfully"}


# API đăng ký người dùng mới
@router.post("/dangky", status_code=status.HTTP_201_CREATED)
def register(user: UserCreate, db: Session = Depends(get_db)):
    """
    API này dùng để tạo tài khoản mới
    """
    # Kiểm tra tên đăng nhập trùng lặp
    existing_user = (
        db.query(NguoiDung)
        .filter(
            (NguoiDung.email == user.email)
            | (NguoiDung.so_dien_thoai == user.so_dien_thoai)
        )
        .first()
    )
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email hoặc số điện thoại đã được sử dụng",
        )

    # Băm mật khẩu
    hashed_password = hash_password(user.mat_khau)

    # Tạo đối tượng người dùng mới với vai trò và trạng thái mặc định
    new_user = NguoiDung(
        ten_dang_nhap=user.ten_dang_nhap,
        mat_khau=hashed_password,
        ho_ten=user.ho_ten,
        tuoi=user.tuoi,
        gioi_tinh=user.gioi_tinh,
        email=user.email,
        so_dien_thoai=user.so_dien_thoai,
        dia_chi=user.dia_chi,
        vai_tro="User",  # Mặc định là User
        trang_thai="HoatDong",  # Mặc định là Hoạt Động
        ngay_tao=datetime.utcnow(),
    )

    # Lưu vào cơ sở dữ liệu
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {
        "message": "Đăng ký tài khoản thành công",
        "user_id": new_user.ma_nguoi_dung,
    }


# API: Lấy thông tin người dùng (chỉ dành cho admin)
@router.get("/users/me")
def read_users_me(
    current_user: NguoiDung = Depends(get_current_user), db: Session = Depends(get_db)
):
    """
    API này dùng để xem toàn bộ thông tin tài khoản người dùng chỉ dùng cho admin
    """
    if current_user.vai_tro != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bạn không có quyền truy cập vào tài nguyên này",
        )

    # Get all users since user is admin
    users = db.query(NguoiDung).all()

    if not users:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy người dùng",
        )

    return [
        {
            "ho_ten": user.ho_ten,
            "tuoi": user.tuoi,
            "gioi_tinh" : user.gioi_tinh,
            "email": user.email,
            "so_dien_thoai" : user.so_dien_thoai,
            "role": user.vai_tro,
            "dia_chi" : user.dia_chi,
            "trang_thai" : user.trang_thai,
            "ma_nguoi_dung": user.ma_nguoi_dung,
        }
        for user in users
    ]


# API để admin thay đổi trạng thái của tài khoản
@router.put("/users/{user_id}/status", status_code=status.HTTP_200_OK)
def update_user_status(
    user_id: int,
    status_update: UpdateUserStatus,
    current_user: NguoiDung = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    API này dùng để thay đổi trạng thái của người dùng chỉ dành cho admin
    """
    if current_user.vai_tro != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bạn không có quyền truy cập vào tài nguyên này",
        )

    # Tìm người dùng cần sửa trạng thái
    user = db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == user_id).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="Người dùng không tồn tại"
        )

    # Cập nhật trạng thái người dùng
    user.trang_thai = status_update.status_update
    db.commit()

    # Nếu người dùng bị khóa, không cho phép đăng nhập nữa
    if user.trang_thai == "BiKhoa":
        user.refresh_token = None
        db.commit()

    return {
        "message": f"Trạng thái người dùng {user_id} đã được cập nhật thành công thành {status_update.status_update}"
    }


# API để thay đổi vai trò của tài khoản người dùng
@router.put("/users/{user_id}/role", status_code=status.HTTP_200_OK)
def update_user_role(
    user_id: int,
    role_data: UpdateUserRole,
    current_user: NguoiDung = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    API này dùng để thay đổi vai trò của người dùng chỉ dành cho admin
    """
    if current_user.vai_tro != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bạn không có quyền thay đổi vai trò người dùng",
        )

    # Tìm người dùng cần thay đổi vai trò
    user = db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == user_id).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="Người dùng không tồn tại"
        )

    # Thay đổi vai trò người dùng
    user.vai_tro = role_data.role_update.value
    db.commit()
    db.refresh(user)

    return {
        "message": f"Vai trò người dùng {user_id} đã được cập nhật thành {role_data.role_update.value}"
    }
