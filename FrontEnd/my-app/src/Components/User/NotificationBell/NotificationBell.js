import React, { useState, useEffect } from "react";
import axios from "axios";
import { FaBell } from "react-icons/fa";
import './NotificationBell.scss'  // Biểu tượng chuông thông báo

const NotificationBell = ({ token }) => {
  const [notifications, setNotifications] = useState([]);
  const [isOpen, setIsOpen] = useState(false);  // Kiểm tra xem popup thông báo có mở hay không
  const [unreadCount, setUnreadCount] = useState(0);  // Số lượng thông báo chưa đọc

  // Lấy danh sách thông báo khi component được tải
  useEffect(() => {
    axios
      .get("http://127.0.0.1:8000/tao_thong_bao_khuyen_mai", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setNotifications(response.data);
        // Cập nhật số lượng thông báo chưa đọc
        setUnreadCount(response.data.filter((notif) => !notif.da_doc).length);
      })
      .catch((error) => console.error(error));
  }, [token]);

  // Hàm đánh dấu thông báo là đã đọc
  const markAsRead = async (notificationId) => {
    try {
      const response = await axios.patch(
        `http://127.0.0.1:8000/thong_bao/${notificationId}`,
        {},
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      // Cập nhật trạng thái của thông báo đã đọc
      setNotifications((prev) =>
        prev.map((notif) =>
          notif.ma_thong_bao === notificationId
            ? { ...notif, da_doc: true }
            : notif
        )
      );
      setUnreadCount((prev) => prev - 1); // Giảm số lượng thông báo chưa đọc
    } catch (error) {
      console.error("Lỗi khi cập nhật:", error.response?.data);
    }
  };

  return (
    <div className="notification-bell">
      {/* Biểu tượng chuông */}
      <div
        className="bell-icon"
        onClick={() => setIsOpen((prev) => !prev)}  // Toggle mở/đóng thông báo
        style={{ position: "relative" }}
      >
        <FaBell size={30} />
        {/* Hiển thị số lượng thông báo chưa đọc */}
        {unreadCount > 0 && (
          <div
            style={{
              position: "absolute",
              top: 0,
              right: 0,
              backgroundColor: "red",
              color: "white",
              borderRadius: "50%",
              padding: "5px",
              fontSize: "14px",
            }}
          >
            {unreadCount}
          </div>
        )}
      </div>

      {/* Popup danh sách thông báo */}
      {isOpen && (
        <div
          className="notification-dropdown"
          style={{
            position: "absolute",
            top: "40px",
            right: "0",
            backgroundColor: "white",
            border: "1px solid #ccc",
            padding: "10px",
            boxShadow: "0 4px 8px rgba(0, 0, 0, 0.2)",
            maxWidth: "250px",
            zIndex: 100,
          }}
        >
          <h3>Chưa có thông báo nào</h3>
          <ul style={{ listStyleType: "none", paddingLeft: 0 }}>
            {notifications.map((notif) => (
              <li
                key={notif.ma_thong_bao}
                style={{
                  padding: "8px",
                  backgroundColor: notif.da_doc ? "#f0f0f0" : "#f8f8f8",
                  marginBottom: "5px",
                }}
              >
                <p>{notif.noi_dung}</p>
                {!notif.da_doc && (
                  <button
                    onClick={() => markAsRead(notif.ma_thong_bao)}
                    style={{
                      backgroundColor: "#007bff",
                      color: "white",
                      border: "none",
                      padding: "5px 10px",
                      cursor: "pointer",
                      borderRadius: "5px",
                    }}
                  >
                    Đánh dấu đã đọc
                  </button>
                )}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default NotificationBell;
