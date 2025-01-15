import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import Cookies from 'js-cookie';

const UserRoleRedirect = () => {
    const navigate = useNavigate();
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const token = Cookies.get("access_token");

        if (!token) {
            navigate("/login");
            return;
        }

        fetch("/user_info", {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${token}`,
            },
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                let targetPath;
                switch (data.vai_tro) {
                    case "admin":
                        targetPath = "/admin";
                        break;
                    case "user":
                        targetPath = "/user";
                        break;
                    default:
                        console.error("Vai trò không xác định:", data.vai_tro);
                        targetPath = "/error";
                        break;
                }
                navigate(targetPath);
            })
            .catch(error => {
                console.error("Lỗi khi lấy thông tin người dùng:", error);
                Cookies.remove("access_token"); // Xóa token nếu cần
                navigate("/login");
            })
            .finally(() => setLoading(false)); // Dừng trạng thái loading
    }, [navigate]);

    if (loading) {
        return <div>Đang tải...</div>;
    }

    return null; // Component này chỉ điều hướng
};

export default UserRoleRedirect;
