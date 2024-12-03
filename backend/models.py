from sqlalchemy import Column, Integer, String, ForeignKey, TEXT, DateTime, func, Double, Enum, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


# Mô hình ORM cho bảng `user`
class User(Base):
    __tablename__ = 'nguoi_dung'
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ten = Column(String(255))
    email = Column(String(255))
    mat_khau = Column(String(255))
    vai_tro = Column(Enum('admin', 'khach_hang', name = 'vai_tro'), default='khach_hang', nullable=False)
    created_at = Column(DateTime, default=func.now(), onupdate=func.now())

class Product(Base):
    __tablename__ = 'san_pham'
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    ten = Column(String(255))
    mo_ta = Column(TEXT)
    gia = Column(Integer)
    hinh_anh = Column(JSON)
    created_at = Column(DateTime, default=func.now(), onupdate=func.now())

class Comment(Base):
    __tablename__ = 'binh_luan'
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    nguoi_dung_id = Column(Integer, ForeignKey('nguoi_dung.id'))
    noi_dung = Column(TEXT)
    san_pham_id = Column(Integer)
    created_at = Column(DateTime, default=func.now(), onupdate=func.now())

    user = relationship('User', back_populates="binh_luan")
User.binh_luan = relationship('Comment', back_populates="user")