import { createSlice } from '@reduxjs/toolkit';

const userSlice = createSlice({
  name: 'user',
  initialState: {
    userName: null,
  },
  reducers: {
    setUserName: (state, action) => {
      state.userName = action.payload; // Cập nhật tên người dùng
    },
    clearUserName: (state) => {
      state.userName = null; // Xóa tên người dùng
    },
  },
});

export const { setUserName, clearUserName } = userSlice.actions;
export const selectUserName = (state) => state.user.userName; // Selector
export default userSlice.reducer;
