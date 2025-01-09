from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from typing import List
from rapidfuzz import fuzz
import re
from sqlalchemy.orm import Session
from models.models import SanPham as SanPhamModel, LoaiXe
from fastapi.security import OAuth2PasswordBearer
from models.database import get_db

router = APIRouter()

# Base schema cho loại xe
class LoaiXeBase(BaseModel):
    loai_xe: str

# Schema đọc dữ liệu loại xe
class LoaiXeSchema(LoaiXeBase):
    ma_loai_xe: int

    class Config:
        from_attributes = True

# Base schema cho sản phẩm
class SanPhamBase(BaseModel):
    ma_loai_xe: int
    ten_san_pham: str
    hang_xe: str
    gia: int
    anh_dai_dien: str

# Schema đọc dữ liệu sản phẩm
class SanPhamSchema(SanPhamBase):
    ma_san_pham: int

    class Config:
        from_attributes = True

def normalize_string(s: str) -> str:
    # Loại bỏ khoảng trắng và chuyển về chữ thường
    return re.sub(r"\s+", "", s).lower()

# API Tìm kiếm sản phẩm dựa theo thể loại xe
@router.get("/products/by_loaixe/", response_model=List[SanPhamSchema])
def search_products_by_loaixe(loai_xe: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    loai_xe_clean = normalize_string(loai_xe)
    
    # Lấy tất cả loại xe trong cơ sở dữ liệu
    all_categories = db.query(LoaiXe).all()
    
    # Tìm loại xe khớp nhất bằng fuzzy matching
    best_match = None
    highest_score = 0
    for category in all_categories:
        category_normalized = normalize_string(category.loai_xe)
        score = fuzz.partial_ratio(loai_xe_clean, category_normalized)
        if score > highest_score and score > 80:  # Ngưỡng điểm tương đồng 80%
            best_match = category
            highest_score = score
    
    if not best_match:
        raise HTTPException(status_code=404, detail="Không tìm thấy loại xe phù hợp")
    
    # Tìm sản phẩm khớp với loại xe
    products = db.query(SanPhamModel).filter(SanPhamModel.ma_loai_xe == best_match.ma_loai_xe).all()
    return products


# API Tìm kiếm sản phẩm cụ thể thông qua tên sản phẩm
@router.get("/products/by_name/", response_model=SanPhamSchema)
def search_product_by_name(ten_san_pham: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    ten_san_pham_clean = normalize_string(ten_san_pham)
    
    # Lấy tất cả sản phẩm trong cơ sở dữ liệu
    all_products = db.query(SanPhamModel).all()
    
    # Tìm sản phẩm khớp nhất bằng fuzzy matching
    best_match = None
    highest_score = 0
    for product in all_products:
        product_normalized = normalize_string(product.ten_san_pham)
        score = fuzz.partial_ratio(ten_san_pham_clean, product_normalized)
        if score > highest_score and score > 80:  # Ngưỡng điểm tương đồng 80%
            best_match = product
            highest_score = score
    
    if not best_match:
        raise HTTPException(status_code=404, detail="Không tìm thấy sản phẩm phù hợp")
    
    return best_match


# API Trả về danh sách xe thuộc hãng Honda, Suzuki,...
@router.get("/products/by_hangxe/", response_model=List[SanPhamSchema])
def search_products_by_hangxe(hang_xe: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    hang_xe_clean = normalize_string(hang_xe)
    
    # Lấy tất cả sản phẩm trong cơ sở dữ liệu
    all_products = db.query(SanPhamModel).all()
    
    # Lọc sản phẩm dựa trên fuzzy matching với hãng xe
    matching_products = []
    for product in all_products:
        hang_xe_normalized = normalize_string(product.hang_xe)
        score = fuzz.partial_ratio(hang_xe_clean, hang_xe_normalized)
        if score > 80:  # Ngưỡng điểm tương đồng 80%
            matching_products.append(product)
    
    if not matching_products:
        raise HTTPException(status_code=404, detail=f"Không tìm thấy sản phẩm thuộc hãng {hang_xe}")
    
    return matching_products
