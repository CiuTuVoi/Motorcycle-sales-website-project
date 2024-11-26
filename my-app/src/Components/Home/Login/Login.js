

import React, { useState } from "react";
import "./Login.scss";

export default function Login() {
  const [phoneEmail, setPhoneEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [showRegister, setShowRegister] = useState(false);

  const handleLoginSubmit = (e) => {
    e.preventDefault();
    console.log("Login with:", { phoneEmail, password });
    
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
            type = "password"
            placeholder="Mật khẩu *"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
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
