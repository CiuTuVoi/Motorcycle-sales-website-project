import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom'; // Import useNavigate
import './Register.scss';

const RegisterForm = () => {
  const navigate = useNavigate(); // Sử dụng useNavigate
  const [formData, setFormData] = useState({
    ten_dang_nhap: '',
    mat_khau: '',
    ho_ten: '',
    tuoi: '',
    gioi_tinh: 'Nam', // hoặc 'Nu'
    email: '',
    so_dien_thoai: '',
    dia_chi: '',
  });

  const [message, setMessage] = useState('');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:8000/dangky', formData);
      setMessage(response.data.message);

      if (response.data.message.includes('thành công')) {
        setTimeout(() => {
          navigate('/login'); 
        }, 2000); 
      }
    } catch (error) {
      setMessage(error.response?.data?.detail || 'Đăng ký thất bại');
    }
  };

  return (
    <div className="register-container">
      <h2 className="register-title">Đăng Ký Tài Khoản</h2>
      <form className="register-form" onSubmit={handleSubmit}>
        <div className="form-group">
          <label className="form-label">Tên đăng nhập:</label>
          <input
            className="form-input"
            type="text"
            name="ten_dang_nhap"
            value={formData.ten_dang_nhap}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label className="form-label">Mật khẩu:</label>
          <input
            className="form-input"
            type="password"
            name="mat_khau"
            value={formData.mat_khau}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label className="form-label">Họ tên:</label>
          <input
            className="form-input"
            type="text"
            name="ho_ten"
            value={formData.ho_ten}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label className="form-label">Tuổi:</label>
          <input
            className="form-input"
            type="number"
            name="tuoi"
            value={formData.tuoi}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label className="form-label">Giới tính:</label>
          <select
            className="form-select"
            name="gioi_tinh"
            value={formData.gioi_tinh}
            onChange={handleChange}
          >
            <option value="Nam">Nam</option>
            <option value="Nu">Nữ</option>
          </select>
        </div>
        <div className="form-group">
          <label className="form-label">Email:</label>
          <input
            className="form-input"
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label className="form-label">Số điện thoại:</label>
          <input
            className="form-input"
            type="text"
            name="so_dien_thoai"
            value={formData.so_dien_thoai}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label className="form-label">Địa chỉ:</label>
          <input
            className="form-input"
            type="text"
            name="dia_chi"
            value={formData.dia_chi}
            onChange={handleChange}
            required
          />
        </div>
        <button className="form-button" type="submit">Đăng Ký</button>
      </form>
      {message && <p className={`form-message ${message.includes('thành công') ? 'success' : 'error'}`}>{message}</p>}
    </div>
  );
};

export default RegisterForm;
