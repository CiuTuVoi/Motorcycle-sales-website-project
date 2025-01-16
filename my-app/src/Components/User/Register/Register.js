import React, { useState } from 'react';
import axios from 'axios';
// import './Register.scss'

const RegisterForm = () => {
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
    } catch (error) {
      setMessage(error.response?.data?.detail || 'Đăng ký thất bại');
    }
  };

  return (
    <div>
      <h2>Đăng Ký Tài Khoản</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Tên đăng nhập:
          <input
            type="text"
            name="ten_dang_nhap"
            value={formData.ten_dang_nhap}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Mật khẩu:
          <input
            type="password"
            name="mat_khau"
            value={formData.mat_khau}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Họ tên:
          <input
            type="text"
            name="ho_ten"
            value={formData.ho_ten}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Tuổi:
          <input
            type="number"
            name="tuoi"
            value={formData.tuoi}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Giới tính:
          <select
            name="gioi_tinh"
            value={formData.gioi_tinh}
            onChange={handleChange}
          >
            <option value="Nam">Nam</option>
            <option value="Nu">Nữ</option>
          </select>
        </label>
        <label>
          Email:
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Số điện thoại:
          <input
            type="text"
            name="so_dien_thoai"
            value={formData.so_dien_thoai}
            onChange={handleChange}
            required
          />
        </label>
        <label>
          Địa chỉ:
          <input
            type="text"
            name="dia_chi"
            value={formData.dia_chi}
            onChange={handleChange}
            required
          />
        </label>
        <button type="submit">Đăng Ký</button>
      </form>
      {message && <p>{message}</p>}
    </div>
  );
};

export default RegisterForm;
