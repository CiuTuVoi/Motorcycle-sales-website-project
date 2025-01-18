import React, { useState, useEffect } from "react";
import "./notification.scss";
import axios from "axios";
import Cookies from "js-cookie";

interface Notification {
  id: number;
  title: string;
  time: string;
  isRead: boolean;
}

const Notifications: React.FC = () => {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const token = Cookies.get("access_token");
    if (!token) {
      setError("Vui lòng đăng nhập");
      setIsLoading(false);
      return;
    }

    axios
      .get("http://localhost:8000/danhgia", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        const newNotifications = response.data.map((danhGia: any) => ({
          id: danhGia.ma_danh_gia,
          title: `Bạn có một đánh giá mới cho sản phẩm ID ${danhGia.ma_san_pham}`,
          time: "Vừa xong", // Có thể thay bằng thời gian cụ thể từ API nếu có
          isRead: false,
        }));
        setNotifications(newNotifications);
        setIsLoading(false);
      })
      .catch((err) => {
        setError("Lỗi khi tải đánh giá: " + err.message);
        setIsLoading(false);
      });
  }, []);

  const markAsRead = (id: number) => {
    setNotifications((prev) =>
      prev.map((notif) =>
        notif.id === id ? { ...notif, isRead: true } : notif
      )
    );
  };

  return (
    <div className="notifications">
      <h2>Thông báo</h2>
      {isLoading ? (
        <p>Loading...</p>
      ) : error ? (
        <p>{error}</p>
      ) : (
        <div className="notification-list">
          {notifications.map((notif) => (
            <div
              key={notif.id}
              className={`notification-item ${notif.isRead ? "read" : "unread"}`}
              onClick={() => markAsRead(notif.id)}
            >
              <div className="notification-content">
                <span>{notif.title}</span>
                <span className="notification-time">{notif.time}</span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default Notifications;
