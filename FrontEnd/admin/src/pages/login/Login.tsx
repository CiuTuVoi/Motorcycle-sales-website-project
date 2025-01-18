import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { login } from "../../components/auth/auth"; 
import Cookies from "js-cookie";
import "./login.scss";

const Login: React.FC = () => {
  const [ten_dang_nhap, setEmail] = useState<string>("");
  const [mat_khau, setPassword] = useState<string>("");
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const navigate = useNavigate();

  useEffect(() => {
    const token = Cookies.get("access_token");
    if (token) {
      // Nếu đã có access_token, chuyển hướng về trang home
      navigate("/");
    }
  }, [navigate]);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    setLoading(true); 

    try {
      await login(ten_dang_nhap, mat_khau); 
      navigate("/");
    } catch (err: any) {
      setError(err.message || "Đã xảy ra lỗi khi đăng nhập.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login">
      <div className="login-container">
        <h1>Đăng nhập</h1>
        <form onSubmit={handleSubmit}>
          {error && <p className="error">{error}</p>}
          <div className="form-group">
            <input
              type="email"
              placeholder="Tên đăng nhập"
              value={ten_dang_nhap}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <input
              type="password"
              placeholder="Mật khẩu"
              value={mat_khau}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <button type="submit" disabled={loading}>
            {loading ? "Đang đăng nhập..." : "Đăng nhập"}
          </button>
        </form>
      </div>
    </div>
  );
};

export default Login;
