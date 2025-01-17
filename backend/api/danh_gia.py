from fastapi import APIRouter, Depends, HTTPException, Request
from pydantic import BaseModel
from sqlalchemy.orm import Session

from core.security import extract_user_data
from models.database import get_db  # Hàm lấy session DB
from models.models import DanhGia, NguoiDung

router = APIRouter()


# Schema: Đánh giá
class DanhGiaCreate(BaseModel):
    ma_san_pham: int
    so_sao: int
    nhan_xet: str

    class Config:
        from_attributes = True


# API Lấy danh sách đánh giá của người dùng
@router.get("/danhgia")
def get_danhgia(
    db: Session = Depends(get_db),
    user_data: dict = Depends(extract_user_data),  # Lấy dữ liệu người dùng từ token
):
    """
    API này dùng để xem các đánh giá của người dùng đối với từng người dùng
    """
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")  # Lấy mã người dùng từ token

    # Lấy danh sách đánh giá của người dùng
    danhgia = db.query(DanhGia).filter(DanhGia.ma_nguoi_dung == ma_nguoi_dung).all()

    if not danhgia:
        raise HTTPException(status_code=404, detail="Không tìm thấy đánh giá")

    return [
        {
            "ma_danh_gia": dg.ma_danh_gia,
            "ma_san_pham": dg.ma_san_pham,
            "so_sao": dg.so_sao,
            "nhan_xet": dg.nhan_xet,
            "ma_nguoi_dung": dg.ma_nguoi_dung,
        }
        for dg in danhgia
    ]


# API: Thêm đánh giá mới
@router.post(
    "/danhgia", response_model=DanhGiaCreate, dependencies=[Depends(extract_user_data)]
)
def create_danhgia(
    danhgia_create: DanhGiaCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(
        extract_user_data
    ),  # Truyền thông tin người dùng từ token
):
    """
    API này dùng để tạo đánh giá mới cho sản phẩm đối với người dùng
    """
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")  # Lấy mã người dùng từ token

    if not ma_nguoi_dung:
        raise HTTPException(
            status_code=401, detail="Không tìm thấy mã người dùng trong token"
        )

    # Kiểm tra người dùng trong cơ sở dữ liệu
    user = db.query(NguoiDung).filter(NguoiDung.ma_nguoi_dung == ma_nguoi_dung).first()
    if not user:
        raise HTTPException(status_code=404, detail="Người dùng không tồn tại")

    # Tạo đánh giá mới
    new_danhgia = DanhGia(
        ma_san_pham=danhgia_create.ma_san_pham,
        ma_nguoi_dung=ma_nguoi_dung,
        so_sao=danhgia_create.so_sao,
        nhan_xet=danhgia_create.nhan_xet,
    )

    db.add(new_danhgia)
    db.commit()
    db.refresh(new_danhgia)

    return DanhGiaCreate.from_orm(new_danhgia)


# API: Sửa đánh giá
@router.put(
    "/danhgia/{danhgia_id}",
    response_model=DanhGiaCreate,
    dependencies=[Depends(extract_user_data)],
)
def update_danhgia(
    danhgia_id: int,
    danhgia_update: DanhGiaCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(
        extract_user_data
    ),  # Truyền thông tin người dùng từ token
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")

    # Kiểm tra đánh giá
    danhgia = db.query(DanhGia).filter(DanhGia.ma_danh_gia == danhgia_id).first()
    if not danhgia:
        raise HTTPException(status_code=404, detail="Không tìm thấy đánh giá")

    # Chỉ chủ sở hữu mới có thể sửa
    if danhgia.ma_nguoi_dung != ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Không có quyền sửa đánh giá này")

    # Cập nhật đánh giá
    danhgia.ma_san_pham = danhgia_update.ma_san_pham
    danhgia.so_sao = danhgia_update.so_sao
    danhgia.nhan_xet = danhgia_update.nhan_xet

    db.commit()
    db.refresh(danhgia)

    return DanhGiaCreate.from_orm(danhgia)


# API: Xóa đánh giá
@router.delete("/danhgia/{danhgia_id}", dependencies=[Depends(extract_user_data)])
def delete_danhgia(
    danhgia_id: int,
    db: Session = Depends(get_db),
    user_data: dict = Depends(
        extract_user_data
    ),  # Truyền thông tin người dùng từ token
):
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")

    # Kiểm tra đánh giá
    danhgia = db.query(DanhGia).filter(DanhGia.ma_danh_gia == danhgia_id).first()
    if not danhgia:
        raise HTTPException(status_code=404, detail="Không tìm thấy đánh giá")

    # Chỉ chủ sở hữu mới có thể xóa
    if danhgia.ma_nguoi_dung != ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Không có quyền xóa đánh giá này")

    db.delete(danhgia)
    db.commit()

    return {"message": "Đánh giá đã được xóa thành công"}
