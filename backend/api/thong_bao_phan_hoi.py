from fastapi import APIRouter, HTTPException, Depends, Request
from pydantic import BaseModel
from enum import Enum
from sqlalchemy.orm import Session
from models.models import DanhGia, ThongBao, PhanHoi, NguoiDung, KhuyenMai
from fastapi.security import OAuth2PasswordBearer
import jwt
from models.database import get_db

router = APIRouter()

SECRET_KEY = "your_secret_key"
ALGORITHM = "HS256"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Middleware phân quyền
def verify_role(required_role: str):
    def role_checker(token: str = Depends(oauth2_scheme)):
        try:
            # Giải mã token để lấy thông tin người dùng
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            
            # Lấy vai trò từ token
            user_role = payload.get("role")
            
            if user_role is None:
                raise HTTPException(status_code=401, detail="Không có vai trò trong token")
            
            # Kiểm tra vai trò người dùng
            if user_role != required_role:
                raise HTTPException(status_code=403, detail="Access denied: Không đủ quyền truy cập")
        
        except jwt.ExpiredSignatureError:
            raise HTTPException(status_code=401, detail="Token đã hết hạn")
        except jwt.InvalidTokenError:
            raise HTTPException(status_code=401, detail="Token không hợp lệ")
        
    return role_checker

# Schema cho tạo phản hồi
class PhanHoiCreate(BaseModel):
    ma_danh_gia: int  # Mã đánh giá mà phản hồi liên quan
    noi_dung: str      # Nội dung phản hồi


class TrangThaiThongBao(str, Enum):
    khuyenMai = 'Khuyenmai'
    riengTu = 'Riengtu'

# Schema cho thông báo
class ThongBaoRead(BaseModel):
    ma_thong_bao: int
    ma_nguoi_dung: int
    noi_dung: str
    da_doc: bool
    loai_thong_bao: TrangThaiThongBao = TrangThaiThongBao.riengTu # mặc định là riêng tư

    class Config:
        from_attributes = True


# API: Tạo phản hồi và gửi thông báo
@router.post("/phan-hoi/", response_model=ThongBaoRead)
def create_phan_hoi(
    phan_hoi: PhanHoiCreate,
    db: Session = Depends(get_db),
    user_data: dict = Depends(verify_role)  # Lấy dữ liệu người dùng từ token
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

    # 3. Tạo thông báo cho người tạo đánh giá (Thông báo trả lời bình luận)
    noi_dung_thong_bao = f"Người dùng {ma_nguoi_dung} đã trả lời đánh giá của bạn."
    new_thong_bao = ThongBao(
        ma_nguoi_dung=danh_gia.ma_nguoi_dung,  # Người nhận thông báo là chủ của đánh giá
        noi_dung=noi_dung_thong_bao,
        loai_thong_bao="Riengtu"  # Loại thông báo là trả lời bình luận
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
    user_data: dict = Depends(verify_role)  # Lấy dữ liệu người dùng từ token
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

    # 3. Tạo thông báo cho người phản hồi trước đó (Thông báo trả lời phản hồi)
    noi_dung_thong_bao = f"Người dùng {ma_nguoi_dung} đã trả lời phản hồi của bạn."
    new_thong_bao = ThongBao(
        ma_nguoi_dung=danh_gia.ma_nguoi_dung,  # Người nhận thông báo là chủ của phản hồi ban đầu
        noi_dung=noi_dung_thong_bao,
        loai_thong_bao="Riengtu"  # Loại thông báo là trả lời phản hồi
    )
    db.add(new_thong_bao)
    db.commit()
    db.refresh(new_thong_bao)

    return new_thong_bao

@router.post("/tao_thong_bao_khuyen_mai")
async def tao_thong_bao_khuyen_mai(khuyen_mai_id: int, db: Session = Depends(get_db)):
    # Lấy thông tin khuyến mãi từ bảng KhuyenMai
    khuyen_mai = db.query(KhuyenMai).filter(KhuyenMai.ma_khuyen_mai == khuyen_mai_id).first()

    if not khuyen_mai:
        raise HTTPException(status_code=404, detail="Khuyến mãi không tồn tại")

    # Tạo thông báo khuyến mãi cho tất cả người dùng
    nguoi_dung_list = db.query(NguoiDung).filter(NguoiDung.trang_thai == 'HoatDong').all()
    for nguoi_dung in nguoi_dung_list:
        thong_bao = ThongBao(
            ma_nguoi_dung=nguoi_dung.ma_nguoi_dung,
            noi_dung=f"Chương trình khuyến mãi: {khuyen_mai.ten_khuyen_mai} - {khuyen_mai.mo_ta}",
            loai_thong_bao='Khuyenmai'  # Thông báo khuyến mãi
        )
        db.add(thong_bao)

    db.commit()
    return {"message": "Thông báo khuyến mãi đã được gửi đến tất cả người dùng."}


@router.patch("/thong_bao/{ma_thong_bao}", response_model=ThongBaoRead)
async def mark_notification_as_read(
    ma_thong_bao: int, db: Session = Depends(get_db), user_data: dict = Depends(verify_role)
):
    # Lấy mã người dùng từ token
    ma_nguoi_dung = user_data.get("ma_nguoi_dung")
    if not ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Người dùng không xác thực.")

    # Tìm thông báo trong cơ sở dữ liệu
    thong_bao = db.query(ThongBao).filter(ThongBao.ma_thong_bao == ma_thong_bao).first()
    if not thong_bao:
        raise HTTPException(status_code=404, detail="Thông báo không tồn tại.")

    # Kiểm tra nếu người dùng có quyền đánh dấu thông báo là đã đọc (chủ sở hữu thông báo)
    if thong_bao.ma_nguoi_dung != ma_nguoi_dung:
        raise HTTPException(status_code=403, detail="Không có quyền đánh dấu thông báo này.")

    # Cập nhật trạng thái đã đọc của thông báo
    thong_bao.da_doc = True
    db.commit()
    db.refresh(thong_bao)

    return thong_bao
