import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import './Login.scss'; // Import file SCSS

const Login = () => {
  const [tenDangNhap, setTenDangNhap] = useState('');
  const [matKhau, setMatKhau] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate('');

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:8000/login', {
        ten_dang_nhap: tenDangNhap,
        mat_khau: matKhau,
      });
      console.log("Dữ liệu từ API:", response);
      const { access_token, ten_dang_nhap } = response.data;

      // Lưu token và tên đăng nhập vào localStorage
      localStorage.setItem('access_token', access_token);
      localStorage.setItem('tendangnhap', ten_dang_nhap);

      // Chuyển hướng sau khi đăng nhập
      navigate('/');
      window.location.reload();
    } catch (err) {
      setError(err.response?.data?.detail || 'Đăng nhập thất bại');
    }
  };

  return (
    <div className="login-container">
      <h2>Đăng Nhập</h2>
      {error && <p className="error">{error}</p>}
      <form onSubmit={handleLogin}>
        <div className="input-group">
          <label>Nhập email</label>
          <input
            type="text"
            value={tenDangNhap}
            onChange={(e) => setTenDangNhap(e.target.value)}
            placeholder='email'
            required
            autoComplete="off"
          />
        </div>
        <div className="input-group">
        <label>Nhập mật khẩu</label>
          <input
            type="password"
            value={matKhau}
            onChange={(e) => setMatKhau(e.target.value)}
            placeholder='Mật khẩu'
            autoComplete="off"

            required
          />
        </div>
        <button type="submit" className="button">
          Đăng nhập
        </button>
      </form>
      <p className="register-link">
        Chưa có tài khoản?{' '}
        <span onClick={() => navigate('/register')} className="link">
          Đăng ký
        </span>
      </p>
    </div>
  );
};

export default Login;
