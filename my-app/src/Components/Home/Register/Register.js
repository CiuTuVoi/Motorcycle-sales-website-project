import React, { useState } from "react";
import "../Login/Login";

export default function Register({ onRegister }) {
  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [setShowRegister] = useState(false);

  const handleRegisterSubmit = (e) => {
    e.preventDefault();
    console.log("Register with:", { name, phone, email, password });
    onRegister({ name, phone, email, password });
  };

  return (
    <div class="overlay">
      <div class="modal-container">
        <h2>ĐĂNG KÝ</h2>
        <from onSubmit={handleRegisterSubmit}>
          <input
            type="text"
            placeholder="Họ và tên *"
            value={name}
            onChange={(e) => setName(e.target.value)}
            requored
          />
          <input
            type="phone"
            placeholder="Số điện thoại *"
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
            required
          />
          <input
            type="email"
            placeholder="Email *"
            value={setEmail}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          <input
            type="password"
            placeholder="Mật khẩu *"
            value={setPassword}
            onChage={(e) => setPassword(e.target.value)}
            required
          />

          <button type="submit" className="button">
            Đăng ký
          </button>
          <p class = "toggle-text">
            Đã có tài khoản?{" "}
            <span onClick={() => setShowRegister(false)}>Đăng nhập</span>
          </p>
        </from>
      </div>
    </div>
  );
}
