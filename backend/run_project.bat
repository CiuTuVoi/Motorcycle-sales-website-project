@echo off
REM Chạy Redis
start D:\Redis\Redis-x64-3.0.504\redis-server.exe

REM Chạy dự án Ban_Xe
cd D:\path\to\your\project
start /wait uvicorn main:app --reload

REM Tắt Redis mà không cần nhấn "y"
taskkill /IM redis-server.exe /F >nul 2>&1
