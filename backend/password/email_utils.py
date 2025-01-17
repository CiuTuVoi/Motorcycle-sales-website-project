import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
from dotenv import load_dotenv

# Load thông tin từ file .env
load_dotenv()
EMAIL_ADDRESS = os.getenv("EMAIL_ADDRESS")  # Email gửi
EMAIL_PASSWORD = os.getenv("EMAIL_PASSWORD")  # Mật khẩu ứng dụng

def send_email(to_email, subject, content):
    """Gửi email với nội dung đơn giản."""
    try:
        # Tạo đối tượng email
        msg = MIMEMultipart()
        msg["From"] = EMAIL_ADDRESS
        msg["To"] = to_email
        msg["Subject"] = subject
        msg.attach(MIMEText(content, "plain"))

        # Kết nối SMTP server
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
            server.sendmail(EMAIL_ADDRESS, to_email, msg.as_string())
        print(f"Email đã gửi tới {to_email}")
    except Exception as e:
        print(f"Lỗi khi gửi email: {e}")
