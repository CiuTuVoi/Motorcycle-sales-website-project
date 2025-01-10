from sqlalchemy import Column, Integer, String, ForeignKey,Boolean, Text, DateTime, func, DECIMAL, Enum, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from models.database import Base

Base = declarative_base()


# Mô hình ORM cho bảng `nguoi_dung`
class NguoiDung(Base):
    __tablename__ = 'nguoi_dung'
    
    ma_nguoi_dung = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ten_dang_nhap = Column(String(255))
    mat_khau = Column(String(255))
    ho_ten = Column(String(255))
    tuoi = Column(Integer)
    gioi_tinh = Column(String(10))
    email = Column(String(255))
    dia_chi = Column(String(255))
    so_dien_thoai = Column(String(20))
    vai_tro = Column(Enum('Admin', 'User', name = 'vai_tro'), default='User', nullable=False)
    trang_thai = Column(Enum('HoatDong', 'BiKhoa', name = 'trang_thai'), default='HoatDong', nullable=False)

    ngay_tao = Column(DateTime, default=func.now(), onupdate=func.now())
    refresh_token = Column(String, nullable=True)

    # Thiết lập mối quan hệ ngược lại với đánh giá
    danhGia = relationship('DanhGia', back_populates="nguoiDung")
    # Thiết lập mối quan hệ ngược lại với đơn hàng
    donHang = relationship('DonHang', back_populates="nguoiDung")
    # Thiết lập mối quan hệ ngược lại với thông báo
    thongBao = relationship('ThongBao', back_populates="nguoiDung")
    phanHoi = relationship('PhanHoi', back_populates="nguoiDung")
    gioHang = relationship('GioHang', back_populates="nguoiDung")

class SanPham(Base):
    __tablename__ = 'san_pham'
    ma_san_pham = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_loai_xe = Column(Integer, ForeignKey('loai_xe.ma_loai_xe'))
    ten_san_pham = Column(String(255))
    hang_xe = Column(String(255))
    gia = Column(Integer)
    anh_dai_dien = Column(String(255))
    ngay_tao = Column(DateTime, default=func.now(), onupdate=func.now())

    # Thiết lập mối quan hệ ngược lại với đánh giá
    danhGia = relationship('DanhGia', back_populates="sanPham")
    # Thiết lập mối quan hệ ngược lại với kho hàng
    khoHang = relationship('KhoHang', back_populates="sanPham", uselist=False)
    # Thiết lập mối quan hệ ngược lại với loại xe
    loaiXe = relationship('LoaiXe', back_populates="sanPham")
    # Thiết lập mối quan hệ ngược lại với thông số kỹ thuật
    thongSoKyThuat = relationship('ThongSoKyThuat', back_populates="sanPham")
    # Thiết lập mối quan hệ ngược lại với đơn hàng
    donHang = relationship('DonHang', back_populates="sanPham")
    # Thiết lập mối quan hệ ngược lại với sản phẩm khuyến mãi
    sanPhamKhuyenMai = relationship('SanPhamKhuyenMai', back_populates="sanPham" ,uselist=False)
    # Thiết lập mối quan hệ ngược lại với ảnh xe
    anhXe = relationship('AnhXe', back_populates="sanPham")
    # Thiết lập mối quan hệ ngược lại với giỏ hàng
    gioHang = relationship('GioHang', back_populates="sanPham")

class DanhGia(Base):
    __tablename__ = 'danh_gia'
    ma_danh_gia = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_san_pham = Column(Integer, ForeignKey('san_pham.ma_san_pham'))
    ma_nguoi_dung = Column(Integer, ForeignKey('nguoi_dung.ma_nguoi_dung'))
    so_sao = Column(Integer)
    nhan_xet = Column(Text)
    ngay_tao = Column(DateTime, default=func.now(), onupdate=func.now())

    # Thiết lập mối quan hệ với NguoiDung và SanPham
    nguoiDung = relationship('NguoiDung', back_populates="danhGia")
    sanPham = relationship('SanPham', back_populates="danhGia")
    phanHoi = relationship('PhanHoi', back_populates="danhGia")

class KhoHang(Base):
    __tablename__ = 'kho_hang'
    ma_san_pham = Column(Integer,ForeignKey('san_pham.ma_san_pham'), primary_key=True, index=True)
    so_luong = Column(Integer)
    

    sanPham = relationship('SanPham', back_populates="khoHang")

class LoaiXe(Base):
    __tablename__ = 'loai_xe'
    ma_loai_xe = Column(Integer, primary_key=True, index=True, autoincrement=True)
    loai_xe = Column(String(255))

    sanPham = relationship('SanPham', back_populates="loaiXe")

class ThongSoKyThuat(Base):
    __tablename__ = 'thong_so_ky_thuat'
    ma_thong_so = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_san_pham = Column(Integer, ForeignKey('san_pham.ma_san_pham'))
    khoi_luong = Column(String(10))
    DRC = Column(String(20))
    khoang_cach_truc_banh_xe = Column(String(10))
    do_cao_yen = Column(String(10))
    khoang_sang_gam_xe = Column(String(10))
    dung_tich_binh_xang = Column(String(10))
    kich_thuoc_lop_truoc = Column(String(50))
    kich_thuoc_lop_sau = Column(String(50))
    phuoc_truoc = Column(String(50))
    phuoc_sau = Column(String(50))
    loai_dong_co = Column(String(50))
    cong_suat_toi_da = Column(String(50))
    dung_tich_nhot_may = Column(String(50))
    muc_tieu_thu_nhien_lieu = Column(String(50))
    loai_truyen_dong = Column(String(50))
    he_thong_khoi_dong = Column(String(30))
    moment_cuc_dai = Column(String(30))
    dung_tich_xylanh = Column(String(10))
    duong_kinh_x_hanh_trinh_pitong = Column(String(20))
    ty_so_nen = Column(String(10))

    sanPham = relationship('SanPham', back_populates="thongSoKyThuat")

class DonHang(Base):
    __tablename__ = 'don_hang'
    ma_don_hang = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_nguoi_dung = Column(Integer, ForeignKey('nguoi_dung.ma_nguoi_dung'))
    ma_san_pham = Column(Integer, ForeignKey('san_pham.ma_san_pham'))
    so_luong = Column(Integer)
    don_gia = Column(DECIMAL(15, 2))
    tong_tien = Column(DECIMAL(15,2))
    trang_thai = Column(Enum('Dang_xu_ly', 'Hoan_thanh', 'Da_huy', name = 'trang_thai'), default = 'Dang_xu_ly', nullable=False)
    ngay_tao = Column(DateTime, default=func.now(), onupdate=func.now())

    nguoiDung = relationship('NguoiDung', back_populates="donHang")
    sanPham = relationship('SanPham', back_populates="donHang")

    lichSuGiaoDich = relationship('LichSuGiaoDich', back_populates="donHang")

class LichSuGiaoDich(Base):
    __tablename__ = 'lich_su_giao_dich'
    ma_giao_dich = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_don_hang = Column(Integer, ForeignKey('don_hang.ma_don_hang'))
    loai_thanh_toan = Column(Enum('STK', 'TienMat', name = 'loai_thanh_toan'), nullable=False )
    trang_thai_giao_hang = Column(Enum('DangGiao', 'HoanThanh', 'DaHuy', name = 'trang_thai_giao_hang'), nullable=False)
    thoi_gian_tao = Column(DateTime, default=func.now(), onupdate=func.now())

    donHang = relationship('DonHang', back_populates="lichSuGiaoDich")

class SanPhamKhuyenMai(Base):
    __tablename__ = 'san_pham_khuyen_mai'
    ma_san_pham = Column(Integer,ForeignKey('san_pham.ma_san_pham'), primary_key=True, index=True)
    ma_khuyen_mai = Column(Integer, ForeignKey('khuyen_mai.ma_khuyen_mai'))

    sanPham = relationship('SanPham', back_populates="sanPhamKhuyenMai")
    khuyenMai = relationship('KhuyenMai', back_populates="sanPhamKhuyenMai")

class KhuyenMai(Base):
    __tablename__ = 'khuyen_mai'
    ma_khuyen_mai = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ten_khuyen_mai = Column(String(255))
    mo_ta = Column(Text)
    muc_giam = Column(DECIMAL(10,2))
    ngay_bat_dau = Column(DateTime)
    ngay_ket_thuc = Column(DateTime)
    ngay_tao = Column(DateTime, default=func.now(), onupdate=func.now())

    sanPhamKhuyenMai = relationship('SanPhamKhuyenMai', back_populates="khuyenMai")

class ThongBao(Base):
    __tablename__ = 'thong_bao'
    
    ma_thong_bao = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_nguoi_dung = Column(Integer, ForeignKey('nguoi_dung.ma_nguoi_dung'))
    noi_dung = Column(String(255))
    da_doc = Column(Boolean, default=False)  # Kiểm tra nếu thông báo đã được đọc
    loai_thong_bao = Column(Enum('Khuyenmai', 'Riengtu', name='loai_thong_bao'), default='Riengtu')  # Loại thông báo

    nguoiDung = relationship('NguoiDung', back_populates="thongBao")

class PhanHoi(Base):
    __tablename__ = 'phan_hoi'
    ma_phan_hoi = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_danh_gia = Column(Integer, ForeignKey('danh_gia.ma_danh_gia'), index=True)
    ma_nguoi_dung = Column(Integer, ForeignKey('nguoi_dung.ma_nguoi_dung'), index=True)
    noi_dung = Column(Text)
    ngay_tao = Column(DateTime, default=func.now())
    
    # Quan hệ với bảng đánh giá và người dùng
    danhGia = relationship('DanhGia', back_populates="phanHoi")
    nguoiDung = relationship('NguoiDung', back_populates="phanHoi")

class AnhXe(Base):
    __tablename__ = 'mau_san_pham'
    ma_hinh_anh = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_san_pham = Column(Integer, ForeignKey('san_pham.ma_san_pham'), index=True)
    mau_sac = Column(String(20))
    anh_1 = Column(String(225))
    anh_2 = Column(String(225))
    anh_3 = Column(String(225))
    anh_4 = Column(String(225))

    sanPham = relationship('SanPham', back_populates="anhXe")

class GioHang(Base):
    __tablename__  = 'gio_hang'
    ma_gio_hang = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ma_nguoi_dung = Column(Integer, ForeignKey('nguoi_dung.ma_nguoi_dung'), index=True)
    ma_san_pham = Column(Integer, ForeignKey('san_pham.ma_san_pham'), index=True)
    so_luong = Column(Integer, default= 1, nullable=False)
    ngay_them = Column(DateTime, default=func.now())

    nguoiDung = relationship('NguoiDung', back_populates="gioHang")
    sanPham = relationship('SanPham', back_populates="gioHang")
