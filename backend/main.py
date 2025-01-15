from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from api.user import router as user_router  # Import router từ user.py
from password.reset_password import router as reset_password_router # Import router từ reset_passwork.py
from api.product import router as product_router # Import router từ product.py
from api.danh_gia import router as danhgia_router # Import router từ danh_gia.py
from api.kho_hang import router as khohang_router # Import router từ kho_hang.py
from api.loai_xe import router as loaixe_router # Import router từ loai_xe.py
from api.khuyen_mai import router as khuyenmai_router # Import router từ khuyenmai.py
from api.thong_so_ky_thuat import router as thongsokythuat_router # Import router từ thong_so_ky_thuat.py
from api.thong_bao_phan_hoi import router as thongbaophanhoi_router # Import router từ thong_bao_phan_hoi.py
from api.don_hang import router as donhang_router # Import router từ don_hang.py
from api.anh_xe import router as anhxa_router # Import router từ anh_xe.py
from api.gio_hang import router as giohang_router # Import router từ gio_hang.py
from api.search import router as search_router # Import router từ search.py
from api.cap_nhat_gia_khuyen_mai import router as capnhatgiakhuyenmai_router # Import router từ cap_nhat_gia_khuyen_mai.py 
from api.search_nguoi_dung import router as searchnguoidung_router # Import router từ search_nguoi_dung.py
from api.san_pham_ban_chay import router as sanphambanchay_router # Import router từ san_pham_ban_chay.py

import sys
import os

app = FastAPI()

# Cấu hình CORS để cho phép frontend kết nối đến backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # URL của frontend
    allow_credentials=True,
    allow_methods=["*"],  # Cho phép tất cả các phương thức HTTP
    allow_headers=["*"],  # Cho phép tất cả các headers
)


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
app.include_router(thongbaophanhoi_router)
app.include_router(donhang_router)
app.include_router(anhxa_router)
app.include_router(giohang_router)
app.include_router(search_router)
app.include_router(capnhatgiakhuyenmai_router)
app.include_router(searchnguoidung_router)
app.include_router(sanphambanchay_router)