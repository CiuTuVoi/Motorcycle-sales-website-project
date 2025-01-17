import axios from 'axios';
import Cookies from 'js-cookie'; // Import thư viện js-cookie

const api = axios.create({
  baseURL: 'http://localhost:8000', // Địa chỉ API của bạn
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true, // Thiết lập để cookie tự động gửi kèm trong yêu cầu
});


// Thêm Authorization header với token từ cookie (nếu có)
api.interceptors.request.use(
  (config) => {
    const token = Cookies.get('access_token'); // Lấy token từ cookie
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }

    // Chỉ log trong môi trường phát triển
    if (process.env.NODE_ENV === "development") {
      console.log("Token từ cookie:", token);
    }

    return config;
  },
  (error) => {
    // Xử lý lỗi trong interceptor (nếu có)
    console.error("Lỗi trong request interceptor:", error);
    return Promise.reject(error);
  }
);

export default api;