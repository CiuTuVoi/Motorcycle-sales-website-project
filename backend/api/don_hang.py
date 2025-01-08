from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel, Field
from decimal import Decimal
from typing import Optional
from sqlalchemy.orm import Session
from models.models import DonHang, NguoiDung
from enum import Enum
from fastapi.security import OAuth2PasswordBearer
import jwt
from models.database import get_db  # Hàm lấy session DB

router = APIRouter()

SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Middleware phân quyền
def verify_role(required_role: str = None):
    def role_checker(token: str = Depends(oauth2_scheme)):
        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            if required_role and payload.get("role") != required_role:
                raise HTTPException(status_code=403, detail="Access denied")
            return payload  # Trả về payload để sử dụng sau
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")
    return role_checker

# Enum trạng thái đơn hàng
class TrangThaiEnum(str, Enum):
    dangXuLy = 'Dang_xu_ly'
    hoanThanh = 'Hoan_thanh'
    daHuy = 'Da_huy'

class DonHangCreate(BaseModel):
    ma_nguoi_dung: Optional[int] = None  # Không bắt buộc
    ma_san_pham: int
    so_luong: int
    don_gia: Decimal = Field(..., gt=0, description="Đơn giá của sản phẩm, phải lớn hơn 0")
    tong_tien: Decimal = Field(..., gt=0, description="Tổng tiền, phải lớn hơn 0")
    trang_thai: TrangThaiEnum = TrangThaiEnum.dangXuLy

    class Config:
        from_attributes = True

    

# API: Lấy danh sách đơn hàng của người dùng
@router.get("/donhang")
def get_donhang(
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role('User'))
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    donhang_list = db.query(DonHang).filter(DonHang.ma_nguoi_dung == ma_nguoi_dung).all()

    if not donhang_list:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")

    return [DonHangCreate.from_orm(dh) for dh in donhang_list]

# API: Lấy danh sách toàn bộ đơn hàng (chỉ cho admin)
@router.get("/all-donhang")
def get_all_donhang(
    db: Session = Depends(get_db),
    _: dict = Depends(verify_role("Admin"))
):
    donhang_list = db.query(DonHang).all()
    if not donhang_list:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")
    return [DonHangCreate.from_orm(dh) for dh in donhang_list]

# API: Thêm đơn hàng mới
@router.post("/donhang", response_model=DonHangCreate)
def create_donhang(
    donhang_create: DonHangCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role('User'))
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")

    if not db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == ma_nguoi_dung).first():
        raise HTTPException(status_code=404, detail="Người dùng không tồn tại")

    # Loại bỏ ma_nguoi_dung khỏi dict để tránh xung đột
    donhang_data = donhang_create.dict()
    donhang_data.pop("ma_nguoi_dung", None)

    # Tạo đối tượng DonHang
    new_donhang = DonHang(**donhang_data, ma_nguoi_dung=ma_nguoi_dung)
    db.add(new_donhang)
    db.commit()
    db.refresh(new_donhang)
    return DonHangCreate.from_orm(new_donhang)


# API: Sửa đơn hàng
@router.put("/donhang/{donhang_id}", response_model=DonHangCreate)
def update_donhang(
    donhang_id: int,
    donhang_update: DonHangCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role())
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    donhang = db.query(DonHang).filter(DonHang.ma_don_hang == donhang_id).first()

    if not donhang:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")

    if donhang.ma_nguoi_dung != ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Không có quyền sửa đơn hàng này")

    for key, value in donhang_update.dict().items():
        setattr(donhang, key, value)

    db.commit()
    db.refresh(donhang)
    return DonHangCreate.from_orm(donhang)

# API: Xóa đơn hàng
@router.delete("/donhang/{donhang_id}")
def delete_donhang(
    donhang_id: int,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role('User'))
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    donhang = db.query(DonHang).filter(DonHang.ma_don_hang == donhang_id).first()

    if not donhang:
        raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")

    if donhang.ma_nguoi_dung != ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Không có quyền xóa đơn hàng này")

    db.delete(donhang)
    db.commit()
    return {"message": "Đơn hàng đã được hủy thành công"}
