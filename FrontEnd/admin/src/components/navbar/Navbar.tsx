import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { logout } from "../../components/auth/auth";
import Cookies from "js-cookie";
import Notifications from "../notification/Notification";
import "./navbar.scss"

const Navbar: React.FC = () => {
  const navigate = useNavigate();
  const [userName, setUserName] = useState<string>("");
  const [showNotifications, setShowNotifications] = useState<boolean>(false); // State để hiển thị Notifications

  useEffect(() => {
    const fetchUserInfo = async () => {
      try {
        const response = await fetch("http://127.0.0.1:8000/user_info", {
          headers: {
            Authorization: `Bearer ${Cookies.get("access_token")}`,
          },
        });

        if (!response.ok) {
          throw new Error("Failed to fetch user info");
        }

        const userData = await response.json();
        setUserName(userData.ho_ten);
      } catch (error) {
        console.error(error);
        setUserName("Guest");
      }
    };

    fetchUserInfo();
  }, []);

  const handleLogout = () => {
    logout();
    navigate("/login");
  };

  const toggleNotifications = () => {
    setShowNotifications(prevState => !prevState);
  };

  return (
    <div className="navbar">
      <div className="logo">
        <img src="logo.svg" alt="" />
        <span>Admin</span>
      </div>
      <div className="icons">
        <img src="/search.svg" alt="" className="icon" />
        <img src="/app.svg" alt="" className="icon" />
        <img src="/expand.svg" alt="" className="icon" />
        
        <div className="notification" onClick={toggleNotifications}>
          <img src="/notifications.svg" alt="notifications" className="icon" />
          <span>1</span> {/* Hoặc một số lượng thông báo */}
        </div>

        {showNotifications && (
  <div className={`notification-popup ${showNotifications ? "visible" : ""}`}>
    <Notifications />
  </div>
)}

        <div className="user">
          <span>Admin {userName}</span>
        </div>
        <img src="/setting.svg" alt="" className="icon" />
        <button onClick={handleLogout} className="logout-btn">
          Đăng xuất
        </button>
      </div>
    </div>
  );
};

export default Navbar;
