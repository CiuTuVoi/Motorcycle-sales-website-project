# Sử dụng Python 3.12.2 làm base image
FROM python:3.12.2-slim

# Đặt thư mục làm việc bên trong container
WORKDIR /app

# Sao chép file requirements.txt để cài đặt dependencies
COPY requirements.txt .

# Cài đặt các thư viện yêu cầu
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Expose cổng mặc định cho FastAPI (8000)
EXPOSE 8000

# Chạy ứng dụng FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
