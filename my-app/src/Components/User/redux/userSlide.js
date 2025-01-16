import { createSlice } from '@reduxjs/toolkit';

// Tạo slice cho user
const userSlice = createSlice({
  name: 'user', // Tên slice
  initialState: {
    tendangnhap: null, // Trạng thái ban đầu
  },
  reducers: {
    // Action để cập nhật tên người dùng
    setUserName: (state, action) => {
      state.tendangnhap = action.payload; // Nhận payload từ action và cập nhật state
    },
    // Action để xóa tên người dùng
    clearUserName: (state) => {
      state.tendangnhap = null; // Reset state về null
    },
  },
});

// Export actions
export const { setUserName, clearUserName } = userSlice.actions;

// Selector để lấy tên người dùng từ state
export const selectUserName = (state) => state.user?.tendangnhap ?? null; // Đảm bảo không bị lỗi

// Export reducer để sử dụng trong store
export default userSlice.reducer;
