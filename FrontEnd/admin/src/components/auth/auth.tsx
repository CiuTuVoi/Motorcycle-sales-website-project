  import Cookies from 'js-cookie';
  import api from '../services/Api';

  // URL của API login
  const LOGIN_URL = "/login"; 
  const USER_INFO_URL = "/user_info";

  // Hàm xác thực đăng nhập
  export const login = async (ten_dang_nhap: string, mat_khau: string) => {
    try {
      const response = await api.post(
        LOGIN_URL, 
        { ten_dang_nhap, mat_khau },
      );
      const { data } = response;
      console.log("Response data:", data);
      // Lưu token vào cookie
      Cookies.set("access_token", data.access_token, { secure: true, sameSite: 'strict' });
      const userInfoResponse = await api.get(USER_INFO_URL, {
        headers: {
          Authorization: `Bearer ${data.access_token}`,
        },
      });
      const userInfo = userInfoResponse.data;
    console.log("Thông tin người dùng:", userInfo);

    if (userInfo.vai_tro !== "Admin") {
      Cookies.remove("access_token");
      throw new Error("Bạn không có quyền truy cập. Chỉ Admin mới được phép đăng nhập.");
    }
      return data.access_token;
    } catch (error: any) {
      if (error.response) {
          throw new Error(error.response.data.detail || "Đã xảy ra lỗi khi đăng nhập.");
        } else if (error.request) {
          throw new Error("Không thể kết nối tới máy chủ. Vui lòng thử lại sau.");
        } else {
          throw new Error("Lỗi trong quá trình thiết lập yêu cầu. Vui lòng thử lại.");
        }
    }
  };

  // Hàm lấy token từ cookie
  export const getToken = () => {
    return Cookies.get("access_token");
  };

  // Hàm đăng xuất (xóa cookie)
  export const logout = () => {
    Cookies.remove("access_token");
  };
