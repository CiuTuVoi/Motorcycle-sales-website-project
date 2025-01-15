from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy import func, extract
from datetime import datetime
from sqlalchemy.orm import Session
from models.models import SanPham, DonHang, SanPhamBanChay
from models.database import get_db
from pydantic import BaseModel

router = APIRouter()

# Schema Pydantic cho yêu cầu API
class UpdateSanPhamBanChayRequest(BaseModel):
    thang: int
    nam: int

# API lấy và cập nhật sản phẩm bán chạy
@router.post("/update_san_pham_ban_chay/")
def update_san_pham_ban_chay(request: UpdateSanPhamBanChayRequest, db: Session = Depends(get_db)):
    thang = request.thang
    nam = request.nam
    
    # Bước 1: Lấy dữ liệu đơn hàng theo tháng và năm, chỉ lấy 10 sản phẩm bán chạy nhất
    san_pham_ban = (
    db.query(
        DonHang.ma_san_pham,
        SanPham.ten_san_pham,
        SanPham.anh_dai_dien,  # Thêm trường anh_dai_dien
        func.sum(DonHang.so_luong).label("so_luong_ban")
    )
    .join(SanPham, DonHang.ma_san_pham == SanPham.ma_san_pham)
    .filter(extract("month", DonHang.ngay_tao) == thang)
    .filter(extract("year", DonHang.ngay_tao) == nam)
    .group_by(DonHang.ma_san_pham, SanPham.ten_san_pham, SanPham.anh_dai_dien)
    .order_by(func.sum(DonHang.so_luong).desc())
    .limit(10)
    .all()
)


    if not san_pham_ban:
        raise HTTPException(status_code=404, detail="Không có sản phẩm bán ra trong tháng và năm này")

    # Bước 2: Cập nhật hoặc thêm mới vào bảng `san_pham_ban_chay`
    for sp in san_pham_ban:
        san_pham_ban_chay = (
            db.query(SanPhamBanChay)
            .filter(SanPhamBanChay.ma_san_pham == sp.ma_san_pham)
            .filter(SanPhamBanChay.thang == thang, SanPhamBanChay.nam == nam)
            .first()
        )

        if san_pham_ban_chay:
            # Cập nhật số lượng bán và ngày cập nhật
            san_pham_ban_chay.so_luong_ban = sp.so_luong_ban
            san_pham_ban_chay.ngay_cap_nhat = datetime.now()
        else:
            # Thêm mới sản phẩm bán chạy
            new_san_pham_ban_chay = SanPhamBanChay(
                ma_san_pham=sp.ma_san_pham,
                ten_san_pham=sp.ten_san_pham,
                so_luong_ban=sp.so_luong_ban,
                anh_dai_dien=sp.anh_dai_dien,
                thang=thang,
                nam=nam,
                ngay_cap_nhat=datetime.now(),
            )
            db.add(new_san_pham_ban_chay)

    db.commit()

    # Bước 3: Trả về danh sách sản phẩm bán chạy trong tháng
    return {
        "thang": thang,
        "nam": nam,
        "san_pham_ban_chay": [
            {
                "ma_san_pham": sp.ma_san_pham,
                "ten_san_pham": sp.ten_san_pham,
                "so_luong_ban": sp.so_luong_ban,
                "anh_dai_dien": sp.anh_dai_dien,
            }
            for sp in san_pham_ban
        ],
    }
