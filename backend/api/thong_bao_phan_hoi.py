from fastapi import APIRouter, HTTPException, Depends, Request
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models.models import DanhGia, ThongBao, PhanHoi
from fastapi.security import OAuth2PasswordBearer
import jwt
from models.database import get_db

router = APIRouter()

SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Middleware giải mã token và lấy thông tin người dùng
def extract_user_data(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload  # Trả về payload chứa thông tin người dùng
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token đã hết hạn")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token không hợp lệ")



# Schema cho tạo phản hồi
class PhanHoiCreate(BaseModel):
    ma_danh_gia: int  # Mã đánh giá mà phản hồi liên quan
    noi_dung: str      # Nội dung phản hồi


# Schema cho thông báo
class ThongBaoRead(BaseModel):
    ma_thong_bao: int
    ma_nguoi_dung: int
    noi_dung: str
    da_doc: bool

    class Config:
        from_attributes = True


# API: Tạo phản hồi và gửi thông báo
@router.post("/phan-hoi/", response_model=ThongBaoRead)
def create_phan_hoi(
    phan_hoi: PhanHoiCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(extract_user_data)  # Lấy dữ liệu người dùng từ token
):
    # Lấy mã người dùng từ token
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Người dùng không xác thực.")

    # 1. Kiểm tra xem đánh giá có tồn tại không
    danh_gia = db.query(DanhGia).filter(DanhGia.ma_danh_gia == phan_hoi.ma_danh_gia).first()
    if not danh_gia:
        raise HTTPException(status_code=404, detail="Đánh giá không tồn tại.")

    # 2. Tạo phản hồi mới
    new_phan_hoi = PhanHoi(
        ma_danh_gia=phan_hoi.ma_danh_gia,
        ma_nguoi_dung=ma_nguoi_dung,  # Dùng mã người dùng từ token
        noi_dung=phan_hoi.noi_dung
    )
    db.add(new_phan_hoi)
    db.commit()
    db.refresh(new_phan_hoi)

    # 3. Tạo thông báo cho người tạo đánh giá
    noi_dung_thong_bao = f"Người dùng {ma_nguoi_dung} đã trả lời đánh giá của bạn."
    new_thong_bao = ThongBao(
        ma_nguoi_dung=danh_gia.ma_nguoi_dung,  # Người nhận thông báo là chủ của đánh giá
        noi_dung=noi_dung_thong_bao
    )
    db.add(new_thong_bao)
    db.commit()
    db.refresh(new_thong_bao)

    return new_thong_bao

# API: Tạo phản hồi khi chủ đánh giá phản hồi lại
@router.post("/phan-hoi/rep/", response_model=ThongBaoRead)
def reply_to_phan_hoi(
    phan_hoi: PhanHoiCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(extract_user_data)  # Lấy dữ liệu người dùng từ token
):
    # Lấy mã người dùng từ token
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Người dùng không xác thực.")

    # 1. Kiểm tra xem đánh giá có tồn tại không
    danh_gia = db.query(DanhGia).filter(DanhGia.ma_danh_gia == phan_hoi.ma_danh_gia).first()
    if not danh_gia:
        raise HTTPException(status_code=404, detail="Đánh giá không tồn tại.")

    # 2. Tạo phản hồi mới
    new_phan_hoi = PhanHoi(
        ma_danh_gia=phan_hoi.ma_danh_gia,
        ma_nguoi_dung=ma_nguoi_dung,  # Dùng mã người dùng từ token
        noi_dung=phan_hoi.noi_dung
    )
    db.add(new_phan_hoi)
    db.commit()
    db.refresh(new_phan_hoi)

    # 3. Tạo thông báo cho người phản hồi trước đó
    noi_dung_thong_bao = f"Người dùng {ma_nguoi_dung} đã trả lời phản hồi của bạn."
    new_thong_bao = ThongBao(
        ma_nguoi_dung=danh_gia.ma_nguoi_dung,  # Người nhận thông báo là chủ của phản hồi ban đầu
        noi_dung=noi_dung_thong_bao
    )
    db.add(new_thong_bao)
    db.commit()
    db.refresh(new_thong_bao)

    return new_thong_bao
