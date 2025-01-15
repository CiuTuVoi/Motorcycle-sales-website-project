from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

# Import các router từ các module
from api.user import router as user_router
from password.reset_password import router as reset_password_router
from api.product import router as product_router
from api.danh_gia import router as danhgia_router
from api.kho_hang import router as khohang_router
from api.loai_xe import router as loaixe_router
from api.khuyen_mai import router as khuyenmai_router
from api.thong_so_ky_thuat import router as thongsokythuat_router
from api.thong_bao_phan_hoi import router as thongbaophanhoi_router
from api.don_hang import router as donhang_router
from api.anh_xe import router as anhxe_router
from api.gio_hang import router as giohang_router
from api.search import router as search_router
from api.cap_nhat_gia_khuyen_mai import router as capnhatgiakhuyenmai_router
from api.search_nguoi_dung import router as searchnguoidung_router
from api.san_pham_ban_chay import router as sanphambanchay_router

import sys
import os

app = FastAPI()

# Cấu hình CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Phân loại API
# Nhóm Quản lý Người dùng
app.include_router(user_router, prefix="/users", tags=["Quản Lý Người Dùng"])
app.include_router(reset_password_router, prefix="/users", tags=["Quản Lý Người Dùng"])

# Nhóm Quản lý Sản phẩm
app.include_router(product_router, prefix="/products", tags=["Quản Lý Sản Phẩm"])
app.include_router(khohang_router, prefix="/products", tags=["Quản Lý Kho Hàng"])
app.include_router(loaixe_router, prefix="/products", tags=["Quản Lý Loại Xe"])
app.include_router(anhxe_router, prefix="/products", tags=["Quản Lý Ảnh Xe"])
app.include_router(thongsokythuat_router, prefix="/products", tags=["Quản Lý Thông Số"])
app.include_router(khuyenmai_router, prefix="/products", tags=["Quản Lý Khuyến Mại"])
app.include_router(capnhatgiakhuyenmai_router, prefix="/products", tags=["Cập Nhật Giá Khuyến Mại"])
app.include_router(sanphambanchay_router, prefix="/products", tags=["Phân Tích Sản Phẩm"])

# Nhóm Quản lý Đơn hàng
app.include_router(donhang_router, prefix="/orders", tags=["Quản Lý Đơn Hàng"])
app.include_router(giohang_router, prefix="/orders", tags=["Sản Phẩm Yêu Thích"])

# Nhóm Đánh giá và Phản hồi
app.include_router(danhgia_router, prefix="/feedback", tags=["Đánh Giá Người Dùng"])
app.include_router(thongbaophanhoi_router, prefix="/feedback", tags=["Thông Báo Người Dùng"])

# Nhóm Tìm kiếm
app.include_router(search_router, prefix="/search", tags=["Tìm kiếm Sản Phẩm"])
app.include_router(searchnguoidung_router, prefix="/search", tags=["Tìm Kiếm Người Dùng"])
