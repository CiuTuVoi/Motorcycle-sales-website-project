import React, { useEffect, useState } from 'react';
import { Navigate } from 'react-router-dom';
import Cookies from 'js-cookie';

const ProtectedRoute = ({ children, requiredRole }) => {
    const [loading, setLoading] = useState(true);
    const [authorized, setAuthorized] = useState(false);
    const [redirectPath, setRedirectPath] = useState('/');

    useEffect(() => {
        const token = Cookies.get('access_token');

        if (!token) {
            setRedirectPath('/login');
            setAuthorized(false);
            setLoading(false);
            return;
        }

        // Gọi API kiểm tra vai trò người dùng
        fetch('/user_info', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`,
            },
        })
            .then(response => {
                if (!response.ok) {
                    if (response.status === 401) {
                        setRedirectPath('/login');
                    } else {
                        setRedirectPath('/');
                    }
                    throw new Error('Token không hợp lệ hoặc hết hạn');
                }
                return response.json();
            })
            .then(data => {
                const userRole = data.vai_tro;
                if (Array.isArray(requiredRole)) {
                    if (requiredRole.includes(userRole)) {
                        setAuthorized(true);
                    } else {
                        setRedirectPath('/');
                    }
                } else {
                    if (userRole === requiredRole) {
                        setAuthorized(true);
                    } else {
                        setRedirectPath('/');
                    }
                }
            })
            .catch(error => {
                console.error('Lỗi xác thực:', error);
                setRedirectPath('/login');
            })
            .finally(() => {
                setLoading(false);
            });
    }, [requiredRole]);

    if (loading) {
        return <div className="loader">Đang tải...</div>;
    }

    if (!authorized) {
        return <Navigate to={redirectPath} />;
    }

    return children;
};

export default ProtectedRoute;
