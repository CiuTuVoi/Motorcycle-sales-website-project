import os

for root, dirs, files in os.walk("."):
    if "__pycache__" in root:  # Bỏ qua thư mục __pycache__
        continue
    for dir_name in dirs:
        init_path = os.path.join(root, dir_name, "__init__.py")
        if not os.path.exists(init_path):
            with open(init_path, "w") as f:
                pass  # Tạo file rỗng
