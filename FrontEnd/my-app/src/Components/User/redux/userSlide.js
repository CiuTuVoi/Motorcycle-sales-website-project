import { createSlice } from '@reduxjs/toolkit';

// Khởi tạo trạng thái ban đầu từ localStorage
const initialState = {
  tendangnhap: localStorage.getItem('tendangnhap') || null, // Lấy từ localStorage nếu có
};

// Tạo slice cho user
const userSlice = createSlice({
  name: 'user', // Tên slice
  initialState,
  reducers: {
    // Action để cập nhật tên người dùng
    setUserName: (state, action) => {
      state.tendangnhap = action.payload; // Cập nhật Redux state
      localStorage.setItem('tendangnhap', action.payload); // Lưu vào localStorage
    },
    // Action để xóa tên người dùng
    clearUserName: (state) => {
      state.tendangnhap = null; // Reset Redux state
      localStorage.removeItem('tendangnhap'); // Xóa khỏi localStorage
    },
  },
});

// Export actions
export const { setUserName, clearUserName } = userSlice.actions;

// Selector để lấy tên người dùng từ state
export const selectUserName = (state) => state.user?.tendangnhap ?? null; // Đảm bảo không bị lỗi

// Export reducer để sử dụng trong store
export default userSlice.reducer;
