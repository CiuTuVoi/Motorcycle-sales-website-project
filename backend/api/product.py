from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models.models import SanPham
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
class ProductCreate(BaseModel):
    ma_loai_xe: int
    ten_san_pham: str
    hang_xe: str
    gia: float  # Giá gốc
    gia_khuyen_mai: float | None = None  # Giá khuyến mại (có thể trống)
    anh_dai_dien: str

    class Config:
        from_attributes = True



# API: Lấy danh sách sản phẩm (cho tất cả người dùng, không yêu cầu đăng nhập)
@router.get("/products")
def get_products(db: Session = Depends(get_db)):
    products = db.query(SanPham).all()
    if not products:
        raise HTTPException(status_code=404, detail="Không tìm thấy sản phẩm")
    return products


# API: Thêm sản phẩm mới (chỉ cho admin)
@router.post("/products", response_model=ProductCreate)
def create_product(
    product_create: ProductCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Chỉ cho admin
):
    # Kiểm tra nếu sản phẩm đã tồn tại
    existing_product = db.query(SanPham).filter(SanPham.ten_san_pham == product_create.ten_san_pham).first()
    if existing_product:
        raise HTTPException(status_code=400, detail="Sản phẩm đã tồn tại")

    # Tạo sản phẩm mới
    new_product = SanPham(
        ma_loai_xe=product_create.ma_loai_xe,
        ten_san_pham=product_create.ten_san_pham,
        hang_xe=product_create.hang_xe,
        gia=product_create.gia,
        gia_khuyen_mai=product_create.gia_khuyen_mai,
        anh_dai_dien=product_create.anh_dai_dien
    )

    db.add(new_product)
    db.commit()
    db.refresh(new_product)
    return ProductCreate.from_orm(new_product)


# API: Sửa sản phẩm (chỉ cho admin)
@router.put("/products/{product_id}", response_model=ProductCreate)
def update_product(
    product_id: int,
    product_update: ProductCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Chỉ cho admin
):
    # Tìm sản phẩm
    product = db.query(SanPham).filter(SanPham.ma_san_pham == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Không tìm thấy sản phẩm")

    # Cập nhật thông tin
    product.ma_loai_xe = product_update.ma_loai_xe
    product.ten_san_pham = product_update.ten_san_pham
    product.hang_xe = product_update.hang_xe
    product.gia = product_update.gia
    product.gia_khuyen_mai = product_update.gia_khuyen_mai
    product.anh_dai_dien = product_update.anh_dai_dien

    db.commit()
    db.refresh(product)
    return ProductCreate.from_orm(product)


# API: Xóa sản phẩm (chỉ cho admin)
@router.delete("/products/{product_id}")
def delete_product(
    product_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    product = db.query(SanPham).filter(SanPham.ma_san_pham == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    
    db.delete(product)
    db.commit()
    return {"message": "Product deleted successfully"}
