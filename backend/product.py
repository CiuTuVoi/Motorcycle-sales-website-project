from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models import Product
from fastapi.security import OAuth2PasswordBearer
import jwt
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
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
    ten: str
    mo_ta: str
    gia: int
    hinh_anh: list[str]

    class Config:
        orm_mode = True
        from_attributes = True

# Hàm lấy session cơ sở dữ liệu
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# API: Lấy danh sách sản phẩm (cho cả user và admin)
@router.get("/products")
def get_products(db: Session = Depends(get_db), _: str = Depends(oauth2_scheme)):
    products = db.query(Product).all()
    if not products:
        raise HTTPException(status_code=404, detail="Không tìm thấy sản phẩm")
    return products

# API: Thêm sản phẩm mới (chỉ cho admin)
@router.post("/products", response_model=ProductCreate)
def create_product(
    product_create: ProductCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("admin"))  # Kiểm tra role admin
):
    # Kiểm tra nếu sản phẩm đã tồn tại
    existing_product = db.query(Product).filter(Product.ten == product_create.ten).first()
    if existing_product:
        raise HTTPException(status_code=400, detail="Sản phẩm đã tồn tại")

    # Tạo đối tượng Product mới từ dữ liệu nhận được
    new_product = Product(
        ten=product_create.ten,
        mo_ta=product_create.mo_ta,
        gia=product_create.gia,
        hinh_anh=product_create.hinh_anh  # Lưu mảng tên hình ảnh vào cơ sở dữ liệu
    )

    # Lưu sản phẩm vào cơ sở dữ liệu
    db.add(new_product)
    db.commit()
    db.refresh(new_product)

    # Trả về sản phẩm mới tạo
    return ProductCreate.from_orm(new_product)

# API: Xóa sản phẩm (chỉ cho admin)
@router.delete("/products/{product_id}")
def delete_product(
    product_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("admin"))  # Kiểm tra role admin
):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    
    db.delete(product)
    db.commit()
    return {"message": "Product deleted successfully"}
