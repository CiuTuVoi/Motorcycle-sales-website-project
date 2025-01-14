from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models.models import GioHang, NguoiDung, SanPham
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
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            user_role = payload.get("role")
            if user_role != required_role:
                raise HTTPException(status_code=403, detail="Access denied")
            return payload  # Trả về payload chứa thông tin người dùng
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")
    return role_checker


# Schema giỏ hàng
class GiohangCreate(BaseModel):
    ma_san_pham: int
    so_luong: int = 1
    
    class Config:
        from_attributes = True


# API: Lấy danh sách giỏ hàng của người dùng
@router.get("/giohang")
def get_giohang(
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role('User'))
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    giohang_list = db.query(GioHang).filter(GioHang.ma_nguoi_dung == ma_nguoi_dung).all()

    if not giohang_list:
        raise HTTPException(status_code=404, detail="Giỏ hàng đang trống")

    return [GiohangCreate.from_orm(dh) for dh in giohang_list]

# API: Thêm sản phẩm mới vào giỏ hàng 
# API: Thêm sản phẩm mới vào giỏ hàng
@router.post("/giohang", response_model=GiohangCreate)
def create_giohang(
    giohang_create: GiohangCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role('User'))  # user_data chứa payload từ token
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=400, detail="Không tìm thấy thông tin người dùng")

    # Kiểm tra sản phẩm
    san_pham = db.query(SanPham).filter(SanPham.ma_san_pham == giohang_create.ma_san_pham).first()
    if not san_pham:
        raise HTTPException(status_code=404, detail="Sản phẩm không tồn tại")

    # Kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
    existing_item = db.query(GioHang).filter(
        GioHang.ma_nguoi_dung == ma_nguoi_dung,
        GioHang.ma_san_pham == giohang_create.ma_san_pham
    ).first()

    if existing_item:
        # Cập nhật số lượng nếu sản phẩm đã tồn tại
        existing_item.so_luong += giohang_create.so_luong
        db.commit()
        db.refresh(existing_item)
        return GiohangCreate.from_orm(existing_item)

    # Thêm sản phẩm mới vào giỏ hàng
    new_giohang = GioHang(
        ma_nguoi_dung=ma_nguoi_dung,  # Lấy từ token
        ma_san_pham=giohang_create.ma_san_pham,
        so_luong=giohang_create.so_luong
    )
    db.add(new_giohang)
    db.commit()
    db.refresh(new_giohang)
    return GiohangCreate.from_orm(new_giohang)


# API: Xóa sản phẩm trong giỏ hàng
@router.delete("/giohang/{giohang_id}")
def delete_giohang(
    giohang_id: int,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role('User'))
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    giohang = db.query(GioHang).filter(GioHang.ma_gio_hang == giohang_id, GioHang.ma_nguoi_dung == ma_nguoi_dung).first()

    if not giohang:
        raise HTTPException(status_code=404, detail="Không có sản phẩm cần xóa trong giỏ")

    db.delete(giohang)
    db.commit()
    return {"message": "Sản phẩm đã được loại khỏi giỏ hàng"}
