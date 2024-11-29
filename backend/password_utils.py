from bcrypt import hashpw, gensalt, checkpw

def hash_password(plain_password):
    """Mã hóa mật khẩu từ chuỗi gốc."""
    return hashpw(plain_password.encode('utf-8'), gensalt()).decode('utf-8')

def verify_password(plain_password, hashed_password):
    """Xác minh mật khẩu người dùng nhập với mật khẩu đã mã hóa."""
    return checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))
