# Ban_Xe

Dự án Python để quản lý việc mua bán xe máy. Cung cấp các chức năng như thêm, sửa, xóa xe và tìm kiếm thông tin xe dễ dàng.

## Yêu cầu

- Python 3.8+
- Các thư viện: pandas, flask (cài đặt bằng pip)
- VSCode hoặc IDE tương tự
- Docker (nếu dùng container)

## Cách cài đặt

1. Clone repository:
   ```bash
   git clone https://github.com/username/Ban_Xe.git
   cd Ban_Xe
2. Tạo môi trường ảo:
    ```bash
    python -m venv env
    source env/bin/activate  # Với Linux/macOS
    env\Scripts\activate     # Với Windows
3. Cài đặt thư viện requirement.txt:
    ```bash
    pip install -r requirements.txt

#### d. Hướng dẫn sử dụng
Mô tả cách sử dụng ứng dụng hoặc các chức năng chính.

```markdown
## Cách sử dụng

1. **Thêm xe mới**: Vào menu chính và chọn "Thêm xe mới".
2. **Tìm kiếm xe**: Nhập từ khoá (biển số, tên xe, hãng) để tìm kiếm.
3. **Xoá xe**: Chọn xe cần xoá từ danh sách.
4. **Xuất danh sách ra file CSV**: Chọn chức năng "Xuất file" trong menu.

```
## Cấu trúc file



# Project Architecture

## Overview
This project follows a **client-server architecture** where the frontend and backend communicate through REST APIs.

---

## Architecture Diagram

```mermaid
graph TD
    User[User Interface] -->|Requests| Frontend
    Frontend[ReactJS] -->|API Calls| Backend
    Backend[FastAPI] -->|SQL Queries| Database
    Database[(MySQL Database)]
