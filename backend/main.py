from fastapi import FastAPI
from user import router as user_router  # Import router từ user.py
from reset_password import router as reset_password_router # Import router từ reset_passwork.py
from product import router as product_router # Import router từ product.py

app = FastAPI()

# Thêm router vào ứng dụng chính
app.include_router(user_router)
app.include_router(reset_password_router)
app.include_router(product_router)
