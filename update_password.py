from password_utils import hash_password
import pymysql

# Kết nối cơ sở dữ liệu
connection = pymysql.connect(
    host="localhost",
    user="root",
    password="",
    database="ban_xe"
)

try:
    with connection.cursor() as cursor:
        # Lấy tất cả người dùng có mật khẩu chưa mã hóa
        cursor.execute("SELECT id, mat_khau FROM nguoi_dung WHERE mat_khau NOT LIKE '$%'")
        users = cursor.fetchall()

        for user in users:
            user_id = user[0]
            plain_password = user[1]

            # Mã hóa mật khẩu
            hashed_password = hash_password(plain_password)

            # Cập nhật mật khẩu đã mã hóa vào cơ sở dữ liệu
            cursor.execute(
                "UPDATE nguoi_dung SET mat_khau = %s WHERE id = %s",
                (hashed_password, user_id)
            )
            print(f"Đã mã hóa mật khẩu cho người dùng ID: {user_id}")

        # Lưu thay đổi vào cơ sở dữ liệu
        connection.commit()

finally:
    connection.close()
