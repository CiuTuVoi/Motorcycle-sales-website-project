from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from typing import List
from rapidfuzz import fuzz
import re
import random
from sqlalchemy.orm import Session
from models.models import SanPham as SanPhamModel, LoaiXe
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

# Hàm chuẩn hóa chuỗi
def normalize_string(s: str) -> str:
    # Loại bỏ khoảng trắng và chuyển về chữ thường
    return re.sub(r"\s+", "", s).lower()

# API Gợi ý sản phẩm theo tên sản phẩm
@router.get("/products/suggestions/by_name/", response_model=List[SanPhamSchema])
def get_product_suggestions_by_name(query: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    query_clean = normalize_string(query)
    
    # Lấy tất cả sản phẩm trong cơ sở dữ liệu
    all_products = db.query(SanPhamModel).all()
    
    # Lọc sản phẩm khớp nhất bằng fuzzy matching
    matching_products = []
    for product in all_products:
        product_normalized = normalize_string(product.ten_san_pham)
        score = fuzz.partial_ratio(query_clean, product_normalized)
        if score > 80:  # Ngưỡng điểm tương đồng 80%
            matching_products.append(product)
    
    # Trả về tối đa 3 sản phẩm gợi ý ngẫu nhiên
    if len(matching_products) > 3:
        matching_products = random.sample(matching_products, 3)
    
    return matching_products


# API Tìm kiếm sản phẩm theo tên sản phẩm (dùng khi người dùng nhấn Enter hoặc tìm kiếm)
@router.get("/products/search/by_name/", response_model=List[SanPhamSchema])
def search_products_by_name(query: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    query_clean = normalize_string(query)
    
    # Lấy tất cả sản phẩm trong cơ sở dữ liệu
    all_products = db.query(SanPhamModel).all()
    
    # Lọc sản phẩm khớp nhất bằng fuzzy matching
    matching_products = []
    for product in all_products:
        product_normalized = normalize_string(product.ten_san_pham)
        score = fuzz.partial_ratio(query_clean, product_normalized)
        if score > 80:  # Ngưỡng điểm tương đồng 80%
            matching_products.append(product)
    
    if not matching_products:
        raise HTTPException(status_code=404, detail="Không tìm thấy sản phẩm phù hợp")
    
    return matching_products


# API Gợi ý sản phẩm theo hãng xe
@router.get("/products/suggestions/by_hangxe/", response_model=List[SanPhamSchema])
def get_product_suggestions_by_hangxe(query: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    query_clean = normalize_string(query)
    
    # Lấy tất cả sản phẩm trong cơ sở dữ liệu
    all_products = db.query(SanPhamModel).all()
    
    # Lọc sản phẩm khớp nhất bằng fuzzy matching
    matching_products = []
    for product in all_products:
        hang_xe_normalized = normalize_string(product.hang_xe)
        score = fuzz.partial_ratio(query_clean, hang_xe_normalized)
        if score > 80:  # Ngưỡng điểm tương đồng 80%
            matching_products.append(product)
    
    # Trả về tối đa 3 sản phẩm gợi ý ngẫu nhiên
    if len(matching_products) > 3:
        matching_products = random.sample(matching_products, 3)
    
    return matching_products


# API Tìm kiếm sản phẩm theo hãng xe (dùng khi người dùng nhấn Enter hoặc tìm kiếm)
@router.get("/products/search/by_hangxe/", response_model=List[SanPhamSchema])
def search_products_by_hangxe(query: str, db: Session = Depends(get_db)):
    # Làm sạch chuỗi nhập
    query_clean = normalize_string(query)
    
    # Lấy tất cả sản phẩm trong cơ sở dữ liệu
    all_products = db.query(SanPhamModel).all()
    
    # Lọc sản phẩm khớp nhất bằng fuzzy matching
    matching_products = []
    for product in all_products:
        hang_xe_normalized = normalize_string(product.hang_xe)
        score = fuzz.partial_ratio(query_clean, hang_xe_normalized)
        if score > 80:  # Ngưỡng điểm tương đồng 80%
            matching_products.append(product)
    
    if not matching_products:
        raise HTTPException(status_code=404, detail="Không tìm thấy sản phẩm phù hợp")
    
    return matching_products


# API Tìm kiếm sản phẩm theo thể loại xe (giữ nguyên theo yêu cầu)
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
