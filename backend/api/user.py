from fastapi import APIRouter, HTTPException, Depends, status, Response, Cookie
from pydantic import BaseModel, EmailStr
from enum import Enum
from sqlalchemy.orm import Session
from models.models import NguoiDung
from password.password_utils import hash_password, verify_password
from fastapi.security import OAuth2PasswordBearer
import jwt
from models.database import get_db
from datetime import datetime, timedelta
import re

# FastAPI router setup
router = APIRouter()

# JWT configuration
SECRET_KEY = "your_secret_key"  # Replace this with a secure key
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

class Token(BaseModel):
    access_token: str
    token_type: str

# Enum vai trò người dùng
class VaiTroEnum(str, Enum):
    admin = 'Admin'
    user = 'User'
class UpdateUserRole(BaseModel):
    role_update: VaiTroEnum

# Enum trạng thái người dùng
class TrangThaiEnum(str, Enum):
    hoatDong = 'HoatDong'
    biKhoa = 'BiKhoa'

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
    email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return bool(re.match(email_regex, ten_dang_nhap))

def is_phone_number(ten_dang_nhap: str) -> bool:
    # Kiểm tra định dạng số điện thoại
    phone_regex = r'^(0[3-9])([0-9]{8})$'
    return bool(re.match(phone_regex, ten_dang_nhap))


# Tạo token JWT
def create_access_token(data: dict):
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode = data.copy()
    to_encode.update({"exp": expire})
    access_token = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return access_token

# API: Đăng nhập và lấy token
@router.post("/login", status_code=status.HTTP_200_OK)
def login(request: LoginRequest, db: Session = Depends(get_db)):
    # Kiểm tra người dùng trong cơ sở dữ liệu
    user = None
    if is_email(request.ten_dang_nhap):
        user = db.query(NguoiDung).filter(NguoiDung.email == request.ten_dang_nhap).first()
    elif is_phone_number(request.ten_dang_nhap):
        user = db.query(NguoiDung).filter(NguoiDung.so_dien_thoai == request.ten_dang_nhap).first()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tài khoản không tồn tại"
        )

    # Kiểm tra trạng thái người dùng
    if user.trang_thai == "BiKhoa":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tài khoản của bạn đã bị khóa"
        )

    # Kiểm tra mật khẩu
    if not verify_password(request.mat_khau, user.mat_khau):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tài khoản hoặc mật khẩu không chính xác"
        )

    # Tạo access token
    access_token = create_access_token(data={
        "sub": user.email,
        "role": user.vai_tro,
        "ma_nguoi_dung": user.ma_nguoi_dung
    })

    # Tạo refresh token
    refresh_token = create_refresh_token(data={
        "sub": user.email,
        "role": user.vai_tro,
        "ma_nguoi_dung": user.ma_nguoi_dung
    })

    # Cập nhật refresh_token vào cơ sở dữ liệu
    user.refresh_token = refresh_token
    db.commit()  # Lưu thay đổi vào cơ sở dữ liệu

    return {"access_token": access_token, "token_type": "bearer", "refresh_token": refresh_token}


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

def decode_refresh_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Refresh token hết hạn.")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Refresh token không hợp lệ.")

def create_refresh_token(data: dict):
    expire = datetime.utcnow() + timedelta(days=7)  # Refresh token có hiệu lực 7 ngày
    to_encode = data.copy()
    to_encode.update({"exp": expire})
    refresh_token = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return refresh_token

def create_access_token(data: dict):
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode = data.copy()
    to_encode.update({"exp": expire})
    access_token = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return access_token

@router.post("/refresh_token", response_model=Token)
async def refresh_token(
    response: Response,
    refresh_token: str = Cookie(None),  # Lấy refresh token từ cookie
):
    if not refresh_token:
        raise HTTPException(status_code=401, detail="No refresh token provided")

    try:
        payload = decode_refresh_token(refresh_token)  # Giải mã token
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Refresh token đã hết hạn")
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Refresh token không hợp lệ")

    # Tạo token mới
    ma_nguoi_dung = payload["sub"]  # Lấy ma_nguoi_dung từ payload
    role = payload["role"]
    new_access_token = create_access_token(data={"sub": ma_nguoi_dung, "role": role})
    new_refresh_token = create_refresh_token(data={"sub": ma_nguoi_dung, "role": role})

    # Lưu refresh token mới vào cookie
    response.set_cookie(
        key="refresh_token",
        value=new_refresh_token,
        httponly=True,
        secure=True,  # Đảm bảo dùng HTTPS khi sản phẩm chạy trên môi trường production
        samesite="lax",
    )

    return {"access_token": new_access_token, "token_type": "bearer"}

# API đăng ký người dùng mới
@router.post("/dangky", status_code=status.HTTP_201_CREATED)
def register(user: UserCreate, db: Session = Depends(get_db)):
    # Kiểm tra tên đăng nhập trùng lặp
    existing_user = db.query(NguoiDung).filter(
        (NguoiDung.email == user.email) | (NguoiDung.so_dien_thoai == user.so_dien_thoai)
    ).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email hoặc số điện thoại đã được sử dụng"
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
        ngay_tao=datetime.utcnow()
    )

    # Lưu vào cơ sở dữ liệu
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {"message": "Đăng ký tài khoản thành công", "user_id": new_user.ma_nguoi_dung}


# API để đăng suất tài khoản người dùng 
@router.post("/logout", status_code=status.HTTP_200_OK)
async def logout(response: Response, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("sub")
        user = db.query(NguoiDung).filter(NguoiDung.email == email).first()
        if user:
            user.refresh_token = None
            db.commit()
    except jwt.PyJWTError:
        pass
    response.delete_cookie("refresh_token")
    return {"message": "Logged out successfully"}

#API để admin thay đổi trạng thái của tài khoản
@router.put("/users/{user_id}/status", status_code=status.HTTP_200_OK)
def update_user_status(
    user_id: int,
    status_update: UpdateUserStatus,  # Sử dụng schema UpdateUserStatus
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(get_db)
):
    try:
        # Giải mã token và kiểm tra vai trò
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        role = payload.get("role")

        if role != 'Admin':
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bạn không có quyền truy cập vào tài nguyên này"
            )

        # Tìm người dùng cần sửa trạng thái
        user = db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == user_id).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Người dùng không tồn tại"
            )

        # Cập nhật trạng thái người dùng
        user.trang_thai = status_update.status_update
        db.commit()  # Lưu thay đổi vào cơ sở dữ liệu
        db.refresh(user)

        # Nếu người dùng bị khóa, không cho phép đăng nhập nữa
        if user.trang_thai == "BiKhoa":
            user.refresh_token = None  # Xóa refresh token để ngừng khả năng đăng nhập
            db.commit()  # Lưu thay đổi

        return {"message": f"Trạng thái người dùng {user_id} đã được cập nhật thành công thành {status_update.status_update}"}

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

# API để thay đổi vai trò của tài khoản người dùng
@router.put("/users/{user_id}/role", status_code=status.HTTP_200_OK)
def update_user_role(
    user_id: int, 
    role_data: UpdateUserRole, 
    token: str = Depends(oauth2_scheme), 
    db: Session = Depends(get_db)):
    try:
        # Giải mã token và kiểm tra vai trò của admin
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        role = payload.get("role")

        if role != 'Admin':
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Bạn không có quyền thay đổi vai trò người dùng"
            )

        # Tìm người dùng cần thay đổi vai trò
        user = db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == user_id).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Người dùng không tồn tại"
            )

        # Thay đổi vai trò người dùng (chuyển Enum thành chuỗi)
        user.vai_tro = role_data.role_update.value  # Lấy giá trị chuỗi từ Enum
        db.commit()
        db.refresh(user)

        return {"message": f"Vai trò người dùng {user_id} đã được cập nhật thành {role_data.role_update.value}"}

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
