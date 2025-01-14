export const loginAPI = async (email, password) => {
    try {
      const response = await fetch("https://reqres.in/api/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ email, password }),
      });
  
      if (!response.ok) {
        throw new Error("Đăng nhập thất bại");
      }
  
      const data = await response.json();
  
      // Thêm logic phân quyền (demo: hardcode vai trò)
      if (email === "admin@example.com") {
        data.role = "admin";
      } else {
        data.role = "user";
      }
  
      return data;
    } catch (error) {
      console.error("Lỗi khi gọi API:", error);
      return null;
    }
  };
  