import { loginAPI } from "../../services/adminService";
import React, { useState } from "react";
import { useNavigate } from "react-router-dom"; // Import useNavigate
import "./Login.scss";

export default function Login() {
  const [phoneEmail, setPhoneEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [showRegister, setShowRegister] = useState(false);

  const navigate = useNavigate(); // Sử dụng useNavigate để điều hướng

  const handleLoginSubmit = async (e) => {
    e.preventDefault();

    if (!phoneEmail || !password) {
      alert("Vui lòng điền đầy đủ thông tin!");
      return;
    }

    try {
      // Gọi API đăng nhập
      let res = await loginAPI(email, password);
      console.log("Response từ API:", res);

      if (res && res.role === "admin") {
        // Lưu trạng thái đăng nhập vào localStorage/sessionStorage
        localStorage.setItem("isAdmin", true);

        // Điều hướng đến trang Admin Dashboard
        navigate("/admin");
      } else if (res && res.role === "user") {
        // Lưu trạng thái người dùng
        localStorage.setItem("isUser", true);

        // Điều hướng đến trang chính của người dùng
        navigate("/");
      } else {
        alert("Tên đăng nhập hoặc mật khẩu không đúng!");
      }
    } catch (error) {
      console.error("Lỗi đăng nhập:", error);
      alert("Đăng nhập không thành công. Vui lòng thử lại!");
    }
  };

  const handleRegisterSubmit = (e) => {
    e.preventDefault();
    console.log("Register with:", { name, phone, email, password });
  };

  return (
    <div className="overlay">
      <div className="modal-container">
        <h2>{showRegister ? "ĐĂNG KÝ" : "ĐĂNG NHẬP"}</h2>
        {!showRegister ? (
          <form onSubmit={handleLoginSubmit}>
            <input
              type="text"
              placeholder="Số điện thoại hoặc email *"
              value={phoneEmail}
              onChange={(e) => setPhoneEmail(e.target.value)}
              required
            />
            <input
              type="password"
              placeholder="Mật khẩu *"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
            <button type="submit" className="button">ĐĂNG NHẬP</button>
            <p className="toggle-text">
              Chưa có tài khoản?{" "}
              <span onClick={() => setShowRegister(true)}>Đăng ký ngay</span>
            </p>
          </form>
        ) : (
          <form onSubmit={handleRegisterSubmit}>
            <input
              type="text"
              placeholder="Họ tên *"
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
            />
            <input
              type="text"
              placeholder="Số điện thoại *"
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
              required
            />
            <input
              type="email"
              placeholder="Địa chỉ email *"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
            <input
              type="password"
              placeholder="Mật khẩu *"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
            <button type="submit" className="button">ĐĂNG KÝ</button>
            <p className="toggle-text">
              Đã có tài khoản?{" "}
              <span onClick={() => setShowRegister(false)}>Đăng nhập</span>
            </p>
          </form>
        )}
      </div>
    </div>
  );
}
