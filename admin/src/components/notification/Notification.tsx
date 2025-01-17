import React, { useState } from "react";
import "./notification.scss";

interface Notification {
  id: number;
  title: string;
  time: string;
  isRead: boolean;
}

const Notifications: React.FC = () => {
  const [notifications, setNotifications] = useState<Notification[]>([
    { id: 1, title: "Bạn có một đơn hàng mới.", time: "1 ngày", isRead: false },
    { id: 2, title: "Bạn có một đánh giá mới.", time: "1 ngày", isRead: true },
    { id: 3, title: "Bạn có một đơn hàng mới.", time: "2 ngày", isRead: true },
  ]);

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
    </div>
  );
};

export default Notifications;