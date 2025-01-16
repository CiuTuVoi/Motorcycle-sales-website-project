import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Login = () => {
  const [tenDangNhap, setTenDangNhap] = useState('');
  const [matKhau, setMatKhau] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:8000/login', {
        ten_dang_nhap: tenDangNhap,
        mat_khau: matKhau,
        
      });
      console.log("dữ liệu từ api", response)
      const { access_token } = response.data;
      const {ten_dang_nhap} = response.data;


      // Lưu token vào localStorage hoặc cookies
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
    <div style={styles.container}>
      <h2>Đăng Nhập</h2>
      {error && <p style={styles.error}>{error}</p>}
      <form onSubmit={handleLogin}>
        <div style={styles.inputGroup}>
          <label>Tên đăng nhập:</label>
          <input
            type="text"
            value={tenDangNhap}
            onChange={(e) => setTenDangNhap(e.target.value)}
            required
          />
        </div>
        <div style={styles.inputGroup}>
          <label>Mật khẩu:</label>
          <input
            type="password"
            value={matKhau}
            onChange={(e) => setMatKhau(e.target.value)}
            required
          />
        </div>
        <button type="submit" style={styles.button}>
          Đăng nhập
        </button>
      </form>
    </div>
  );
};

const styles = {
  container: {
    maxWidth: '400px',
    margin: '0 auto',
    padding: '20px',
    border: '1px solid #ccc',
    borderRadius: '5px',
    boxShadow: '0 2px 5px rgba(0, 0, 0, 0.1)',
    textAlign: 'center',
  },
  inputGroup: {
    marginBottom: '15px',
  },
  button: {
    backgroundColor: '#007bff',
    color: '#fff',
    border: 'none',
    padding: '10px 15px',
    borderRadius: '5px',
    cursor: 'pointer',
  },
  error: {
    color: 'red',
    marginBottom: '10px',
  },
};

export default Login;
