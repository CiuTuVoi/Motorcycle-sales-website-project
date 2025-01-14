from fastapi import APIRouter, HTTPException, Depends, Security
from pydantic import BaseModel
from sqlalchemy.orm import Session
from models.models import ThongSoKyThuat
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

# Schema thông số kỹ thuật
class ThongSoCreate(BaseModel):
    ma_san_pham: int
    khoi_luong: str
    DRC: str
    khoang_cach_truc_banh_xe: str
    do_cao_yen: str
    khoang_sang_gam_xe: str
    dung_tich_binh_xang: str
    kich_thuoc_lop_truoc: str
    kich_thuoc_lop_sau: str
    phuoc_truoc: str
    phuoc_sau: str
    loai_dong_co: str
    cong_suat_toi_da: str
    dung_tich_nhot_may: str
    muc_tieu_thu_nhien_lieu: str
    loai_truyen_dong: str
    he_thong_khoi_dong: str
    moment_cuc_dai: str
    dung_tich_xylanh: str
    duong_kich_x_hanh_trinh_pitong: str
    ty_so_nen: str

    class Config:
        from_attributes = True


# API: Lấy danh sách thông số kỹ thuật không cần đăng nhập
@router.get("/thongso")
def get_thongso(db: Session = Depends(get_db)):
    thongso = db.query(ThongSoKyThuat).all()
    if not thongso:
        raise HTTPException(status_code=404, detail="Không tìm thấy thông số")
    return thongso


# API: Thêm thông số mới (chỉ cho admin)
@router.post("/thongso", response_model=ThongSoCreate)
def create_thongso(
    thongso_create: ThongSoCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Kiểm tra nếu id thông số đã tồn tại
    existing_thongso = db.query(ThongSoKyThuat).filter(ThongSoKyThuat.ma_san_pham == thongso_create.ma_san_pham).first()
    if existing_thongso:
        raise HTTPException(status_code=400, detail="Thông số đã tồn tại")

    # Tạo thông số mới từ dữ liệu nhận được
    new_thongso = ThongSoKyThuat(
        ma_san_pham=thongso_create.ma_san_pham,
        khoi_luong=thongso_create.khoi_luong,
        DRC=thongso_create.DRC,
        khoang_cach_truc_banh_xe=thongso_create.khoang_cach_truc_banh_xe,
        do_cao_yen=thongso_create.khoang_cach_truc_banh_xe,
        khoang_sang_gam_xe=thongso_create.khoang_sang_gam_xe,
        dung_tich_binh_xang=thongso_create.dung_tich_binh_xang,
        kich_thuoc_lop_truoc=thongso_create.kich_thuoc_lop_truoc,
        kich_thuoc_lop_sau=thongso_create.kich_thuoc_lop_sau,
        phuoc_truoc=thongso_create.phuoc_truoc,
        phuoc_sau=thongso_create.phuoc_sau,
        loai_dong_co=thongso_create.loai_dong_co,
        cong_suat_toi_da=thongso_create.cong_suat_toi_da,
        dung_tich_nhot_may=thongso_create.dung_tich_nhot_may,
        muc_tieu_thu_nhien_lieu=thongso_create.muc_tieu_thu_nhien_lieu,
        loai_truyen_dong=thongso_create.loai_truyen_dong,
        he_thong_khoi_dong=thongso_create.he_thong_khoi_dong,
        moment_cuc_dai=thongso_create.moment_cuc_dai,
        dung_tich_xylanh=thongso_create.dung_tich_xylanh,
        duong_kich_x_hanh_trinh_pitong=thongso_create.duong_kich_x_hanh_trinh_pitong,
        ty_so_nen=thongso_create.ty_so_nen
    )

    # Lưu thông số vào cơ sở dữ liệu
    db.add(new_thongso)
    db.commit()
    db.refresh(new_thongso)

    # Trả về thông số mới tạo
    return ThongSoCreate.from_orm(new_thongso)


# API: Sửa thông số (chỉ cho admin)
@router.put("/thongso/{thongso_id}", response_model=ThongSoCreate)
def update_thongso(
    thongso_id: int,
    thongso_update: ThongSoCreate,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    # Tìm thông số trong cơ sở dữ liệu
    thongso = db.query(ThongSoKyThuat).filter(ThongSoKyThuat.ma_thong_so == thongso_id).first()
    
    if not thongso:
        raise HTTPException(status_code=404, detail="Thông số không tìm thấy")
    
    # Cập nhật thông tin thông số
    thongso.ma_san_pham = thongso_update.ma_san_pham
    thongso.khoi_luong = thongso_update.khoi_luong
    thongso.DRC = thongso_update.DRC
    thongso.khoang_cach_truc_banh_xe = thongso_update.khoang_cach_truc_banh_xe
    thongso.do_cao_yen = thongso_update.do_cao_yen
    thongso.khoang_sang_gam_xe = thongso_update.khoang_sang_gam_xe
    thongso.dung_tich_binh_xang = thongso_update.dung_tich_binh_xang
    thongso.kich_thuoc_lop_truoc = thongso_update.kich_thuoc_lop_truoc
    thongso.kich_thuoc_lop_sau = thongso_update.kich_thuoc_lop_sau
    thongso.phuoc_truoc = thongso_update.phuoc_truoc
    thongso.phuoc_sau = thongso_update.phuoc_sau
    thongso.loai_dong_co = thongso_update.loai_dong_co
    thongso.cong_suat_toi_da = thongso_update.cong_suat_toi_da
    thongso.dung_tich_nhot_may = thongso_update.dung_tich_nhot_may
    thongso.muc_tieu_thu_nhien_lieu = thongso_update.muc_tieu_thu_nhien_lieu
    thongso.loai_truyen_dong = thongso_update.loai_truyen_dong
    thongso.he_thong_khoi_dong = thongso_update.he_thong_khoi_dong
    thongso.moment_cuc_dai = thongso_update.moment_cuc_dai
    thongso.dung_tich_xylanh = thongso_update.dung_tich_xylanh
    thongso.duong_kich_x_hanh_trinh_pitong = thongso_update.duong_kich_x_hanh_trinh_pitong
    thongso.ty_so_nen = thongso_update.ty_so_nen
    
    # Commit thay đổi vào cơ sở dữ liệu
    db.commit()
    db.refresh(thongso)

    # Trả về thông số sau khi cập nhật
    return ThongSoCreate.from_orm(thongso)


# API: Xóa thông số (chỉ cho admin)
@router.delete("/thongso/{thongso_id}")
def delete_thongso(
    thongso_id: int,
    db: Session = Depends(get_db),
    _: str = Security(verify_role("Admin"))  # Kiểm tra role admin
):
    thongso = db.query(ThongSoKyThuat).filter(ThongSoKyThuat.ma_thong_so == thongso_id).first()
    if not thongso:
        raise HTTPException(status_code=404, detail="Thông số không tìm thấy")
    
    db.delete(thongso)
    db.commit()
    return {"message": "Thông số đã được xóa thành công"}
