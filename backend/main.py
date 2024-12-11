from fastapi import FastAPI
from api.user import router as user_router  # Import router từ user.py
from password.reset_password import router as reset_password_router # Import router từ reset_passwork.py
from api.product import router as product_router # Import router từ product.py
from api.danh_gia import router as danhgia_router # Import router từ danh_gia.py
from api.kho_hang import router as khohang_router # Import router từ kho_hang.py
from api.loai_xe import router as loaixe_router # Import router từ loai_xe.py
from api.khuyen_mai import router as khuyenmai_router # Import router từ khuyenmai.py
from api.thong_so_ky_thuat import router as thongsokythuat_router # Import router từ thong_so_ky_thuat.py
import sys
import os

app = FastAPI()

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Thêm router vào ứng dụng chính
app.include_router(user_router)
app.include_router(reset_password_router)
app.include_router(product_router)
app.include_router(danhgia_router)
app.include_router(khohang_router)
app.include_router(loaixe_router)
app.include_router(khuyenmai_router)
app.include_router(thongsokythuat_router)
