from datetime import date

from fastapi import APIRouter, Depends, HTTPException, Security
from sqlalchemy import and_, or_
from sqlalchemy.orm import Session

from core.security import verify_role
from models.database import get_db
from models.models import KhuyenMai, SanPham, SanPhamKhuyenMai

router = APIRouter()


@router.post("/update-discount-prices")
def update_discount_prices(
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin")),  # Chỉ admin có quyền thực hiện
):
    try:
        # Lấy ngày hiện tại (kiểu date)
        current_date = date.today()

        # Lấy tất cả các sản phẩm trong bảng san_pham_khuyen_mai đang trong thời gian khuyến mại
        san_pham_khuyen_mai = (
            db.query(SanPhamKhuyenMai)
            .join(KhuyenMai)
            .filter(
                and_(
                    KhuyenMai.ngay_bat_dau <= current_date,
                    KhuyenMai.ngay_ket_thuc >= current_date,
                )
            )
            .all()
        )

        # Cập nhật giá khuyến mại cho từng sản phẩm
        for spkm in san_pham_khuyen_mai:
            khuyen_mai = spkm.khuyenMai
            san_pham = spkm.sanPham

            # Tính giá khuyến mại
            if khuyen_mai.muc_giam and san_pham.gia:
                gia_khuyen_mai = float(san_pham.gia) * (
                    1 - float(khuyen_mai.muc_giam) / 100
                )
                san_pham.gia_khuyen_mai = round(gia_khuyen_mai, 2)

        # Cập nhật lại các sản phẩm không còn trong thời gian khuyến mại
        expired_discounts = (
            db.query(SanPham)
            .join(SanPhamKhuyenMai)
            .join(KhuyenMai)
            .filter(
                or_(
                    KhuyenMai.ngay_ket_thuc < current_date,
                    KhuyenMai.ngay_bat_dau > current_date,
                )
            )
            .all()
        )

        for sp in expired_discounts:
            sp.gia_khuyen_mai = None

        # Lưu các thay đổi vào cơ sở dữ liệu
        db.commit()

        return {"message": "Cập nhật giá khuyến mại thành công"}

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=500, detail=f"Lỗi khi cập nhật giá khuyến mại: {str(e)}"
        )
