@echo off
REM Khởi động Redis
start D:\Redis\Redis-x64-3.0.504\redis-server.exe

REM Chạy dự án Ban_Xe
cd D:\path\to\your\project
uvicorn main:app --reload

REM Dừng Redis khi kết thúc dự án (tuỳ chọn)
taskkill /IM redis-server.exe /F
