import React, { useState } from "react";
import { useDispatch } from "react-redux";
import { setUserName } from "../redux/userSlide";
import Cookies from "js-cookie";
import { useNavigate } from "react-router-dom";

const Login = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const handleLogin = (e) => {
    e.preventDefault();
    // Giả lập đăng nhập thành công
    const user = { name: username }; // Đây là dữ liệu trả về từ server
    Cookies.set("access_token", "mock_token", { expires: 7 }); // Lưu token giả
    dispatch(setUserName(user.name)); // Cập nhật Redux state
    navigate("/"); // Chuyển hướng về trang chủ
  };

  return (
    <form onSubmit={handleLogin}>
      <h2>Đăng nhập</h2>
      <div>
        <label>Tên người dùng:</label>
        <input
          type="text"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
      </div>
      <div>
        <label>Mật khẩu:</label>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>
      <button type="submit">Đăng nhập</button>
    </form>
  );
};

export default Login;
