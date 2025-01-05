from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models.models import AnhXe
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
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")
    return role_checker

# Schema sản phẩm
class AnhxeCreate(BaseModel):
    ma_san_pham: int
    mau_sac: str
    anh_1: str
    anh_2: str
    anh_3: str
    anh_4: str

    class Config:
        from_attributes = True


# API: Lấy danh sách ảnh xe (cho tất cả người dùng, không yêu cầu đăng nhập)
@router.get("/anhxe")
def get_anhxe(db: Session = Depends(get_db)):
    anhxe = db.query(AnhXe).all()
    if not anhxe:
        raise HTTPException(status_code=404, detail="Không tìm thấy ảnh nào")
    return anhxe

# API: Thêm ảnh cho xe mới (chỉ cho admin)
@router.post("/anhxe", response_model=AnhxeCreate)
def create_anhxe(
    anhxe_create: AnhxeCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Kiểm tra nếu ảnh đã tồn tại
    existing_anhxe = db.query(AnhXe).filter(AnhXe.ma_hinh_anh == anhxe_create.ma_hinh_anh).first()
    if existing_anhxe:
        raise HTTPException(status_code=400, detail="Ảnh đã tồn tại")

    # Tạo đối tượng hình ảnh mới từ dữ liệu nhận được
    new_anhxe = AnhXe(
        ma_san_pham=anhxe_create.ma_san_pham,
        mau_sac=anhxe_create.mau_sac,
        anh_1=anhxe_create.anh_1,
        anh_2=anhxe_create.anh_2,
        anh_3=anhxe_create.anh_3,
        anh_4=anhxe_create.anh_4
    )

    # Lưu ảnh vào cơ sở dữ liệu
    db.add(new_anhxe)
    db.commit()
    db.refresh(new_anhxe)

    # Trả về ảnh mới tạo
    return AnhxeCreate.from_orm(new_anhxe)


# API: Sửa ảnh (chỉ cho admin)
@router.put("/anhxe/{anhxe_id}", response_model=AnhxeCreate)
def update_anhxe(
    anhxe_id: int,
    anhxe_update: AnhxeCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Tìm hình ảnh trong cơ sở dữ liệu
    anhxe = db.query(AnhXe).filter(AnhXe.ma_hinh_anh == anhxe_id).first()
    
    if not anhxe:
        raise HTTPException(status_code=404, detail="Images not found")
    
    # Cập nhật thông tin ảnh xe
    anhxe.ma_san_pham = anhxe_update.ma_san_pham
    anhxe.mau_sac = anhxe_update.mau_sac
    anhxe.anh_1 = anhxe_update.anh_1
    anhxe.anh_2 = anhxe_update.anh_2
    anhxe.anh_3 = anhxe_update.anh_3
    anhxe.anh_4 = anhxe_update.anh_4

    # Commit thay đổi vào cơ sở dữ liệu
    db.commit()
    db.refresh(anhxe)

    # Trả về hình ảnh sau khi cập nhật
    return AnhxeCreate.from_orm(anhxe)


# API: Xóa hình ảnh sản phẩm (chỉ cho admin)
@router.delete("/anhxe/{anhxe_id}")
def delete_anhxe(
    anhxe_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    anhxe = db.query(AnhXe).filter(AnhXe.ma_hinh_anh ==anhxe_id).first()
    if not anhxe:
        raise HTTPException(status_code=404, detail="Images not found")
    
    db.delete(anhxe)
    db.commit()
    return {"message": "Images deleted successfully"}
