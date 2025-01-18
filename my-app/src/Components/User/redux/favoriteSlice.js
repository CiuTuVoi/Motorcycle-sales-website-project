import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  items: [], // Đảm bảo `items` luôn có giá trị mặc định là mảng
};

const favoriteSlice = createSlice({
  name: "favorite",
  initialState,
  reducers: {
    addToFavorites: (state, action) => {
      state.items.push(action.payload);
    },
    removeFromFavorites: (state, action) => {
      state.items = state.items.filter((item) => item.id !== action.payload.id);
    },
  },
});

export const { addToFavorites, removeFromFavorites } = favoriteSlice.actions;

export const selectFavoriteQuantity = (state) => state.favorite.items.length; // Sửa lỗi

export default favoriteSlice.reducer;
