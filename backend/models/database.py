from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from dotenv import load_dotenv
from .models import *
import os

load_dotenv(dotenv_path=os.path.join(os.path.dirname(__file__), '..', '.env'))



DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD", "")
DB_NAME = os.getenv("DB_NAME")

# Kiểm tra các biến môi trường bị thiếu
missing_vars = [var for var in ["DB_HOST", "DB_PORT", "DB_USER", "DB_PASSWORD", "DB_NAME"] if not os.getenv(var)]
if missing_vars:
    raise ValueError(f"Các biến môi trường sau không được thiết lập: {', '.join(missing_vars)}")

# Tạo URL kết nối MySQL
SQLALCHEMY_DATABASE_URL = f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# Kết nối cơ sở dữ liệu
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()