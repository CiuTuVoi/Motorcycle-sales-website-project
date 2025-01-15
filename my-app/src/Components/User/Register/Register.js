import React, { useState } from 'react';
import axios from 'axios';
import "./Register.scss";
import { useNavigate } from 'react-router-dom';

const Register = () => {
    const [formData, setFormData] = useState({
        ten_dang_nhap: '',
        mat_khau: '',
        ho_ten: '',
        tuoi: '',
        gioi_tinh: '',
        email: '',
        so_dien_thoai: '',
        dia_chi: '',
    });

    const [errors, setErrors] = useState({});
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };

    // Hàm kiểm tra dữ liệu form
    const validateForm = () => {
        const newErrors = {};
        if (!formData.ten_dang_nhap.trim()) newErrors.ten_dang_nhap = 'Tên đăng nhập là bắt buộc';
        if (!formData.mat_khau.trim() || formData.mat_khau.length < 6) {
            newErrors.mat_khau = 'Mật khẩu phải có ít nhất 6 ký tự';
        }
        if (!formData.ho_ten.trim()) newErrors.ho_ten = 'Họ tên là bắt buộc';
        if (formData.tuoi && (formData.tuoi < 18 || formData.tuoi > 100)) {
            newErrors.tuoi = 'Tuổi phải nằm trong khoảng từ 18 đến 100';
        }
        if (!formData.email.trim() || !/\S+@\S+\.\S+/.test(formData.email)) {
            newErrors.email = 'Email không hợp lệ';
        }
        if (!formData.so_dien_thoai.trim() || !/^\d{10,15}$/.test(formData.so_dien_thoai)) {
            newErrors.so_dien_thoai = 'Số điện thoại phải có 10-15 chữ số';
        }
        if (!formData.dia_chi.trim()) newErrors.dia_chi = 'Địa chỉ là bắt buộc';

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!validateForm()) return;

        setLoading(true);
        try {
            const response = await axios.post('http://localhost:8000/dangky', formData);
            alert(response.data.message);
            navigate('/login');
        } catch (error) {
            const errorMessage = error.response?.data?.detail || 'Có lỗi xảy ra. Vui lòng thử lại.';
            setErrors({ form: errorMessage });
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="register-container">
            <h2>Đăng ký tài khoản</h2>
            <form onSubmit={handleSubmit} className="register-form">
                <div className="form-group">
                    <label htmlFor="ten_dang_nhap">Tên đăng nhập*</label>
                    <input
                        type="text"
                        name="ten_dang_nhap"
                        id="ten_dang_nhap"
                        value={formData.ten_dang_nhap}
                        onChange={handleChange}
                        required
                    />
                    {errors.ten_dang_nhap && <span className="error">{errors.ten_dang_nhap}</span>}
                </div>

                <div className="form-group">
                    <label htmlFor="mat_khau">Mật khẩu*</label>
                    <input
                        type="password"
                        name="mat_khau"
                        id="mat_khau"
                        value={formData.mat_khau}
                        onChange={handleChange}
                        required
                    />
                    {errors.mat_khau && <span className="error">{errors.mat_khau}</span>}
                </div>

                <div className="form-group">
                    <label htmlFor="ho_ten">Họ tên*</label>
                    <input
                        type="text"
                        name="ho_ten"
                        id="ho_ten"
                        value={formData.ho_ten}
                        onChange={handleChange}
                        required
                    />
                    {errors.ho_ten && <span className="error">{errors.ho_ten}</span>}
                </div>

                <div className="form-group">
                    <label htmlFor="tuoi">Tuổi</label>
                    <input
                        type="number"
                        name="tuoi"
                        id="tuoi"
                        value={formData.tuoi}
                        onChange={handleChange}
                        required
                    />
                    {errors.tuoi && <span className="error">{errors.tuoi}</span>}
                </div>

                <div className="form-group">
                    <label>Giới tính:</label>
                    <div className="radio-group">
                        <label>
                            <input
                                type="radio"
                                name="gioi_tinh"
                                value="Nam"
                                checked={formData.gioi_tinh === "Nam"}
                                onChange={handleChange}
                            />
                            Nam
                        </label>
                        <label>
                            <input
                                type="radio"
                                name="gioi_tinh"
                                value="Nữ"
                                checked={formData.gioi_tinh === "Nữ"}
                                onChange={handleChange}
                            />
                            Nữ
                        </label>
                        <label>
                            <input
                                type="radio"
                                name="gioi_tinh"
                                value="Khác"
                                checked={formData.gioi_tinh === "Khác"}
                                onChange={handleChange}
                            />
                            Khác
                        </label>
                    </div>
                </div>

                <div className="form-group">
                    <label htmlFor="email">Email*</label>
                    <input
                        type="email"
                        name="email"
                        id="email"
                        value={formData.email}
                        onChange={handleChange}
                        required
                    />
                    {errors.email && <span className="error">{errors.email}</span>}
                </div>

                <div className="form-group">
                    <label htmlFor="so_dien_thoai">Số điện thoại*</label>
                    <input
                        type="text"
                        name="so_dien_thoai"
                        id="so_dien_thoai"
                        value={formData.so_dien_thoai}
                        onChange={handleChange}
                        required
                    />
                    {errors.so_dien_thoai && <span className="error">{errors.so_dien_thoai}</span>}
                </div>

                <div className="form-group">
                    <label htmlFor="dia_chi">Địa chỉ*</label>
                    <input
                        type="text"
                        name="dia_chi"
                        id="dia_chi"
                        value={formData.dia_chi}
                        onChange={handleChange}
                        required
                    />
                    {errors.dia_chi && <span className="error">{errors.dia_chi}</span>}
                </div>

                {errors.form && <span className="error">{errors.form}</span>}

                <button type="submit" className="register-button" disabled={loading}>
                    {loading ? 'Đang xử lý...' : 'Đăng ký'}
                </button>
            </form>
            <p className="toggle-text">
                Đã có tài khoản? <span onClick={() => navigate('/login')}>Đăng nhập</span>
            </p>
        </div>
    );
};

export default Register;
