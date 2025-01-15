import { createSlice } from "@reduxjs/toolkit";

const initialState = [];

const cartSlice = createSlice({
  name: "cart",
  initialState,
  reducers: {
    addToCart(state, action) {
      state.push(action.payload);
    },
    removeFromCart(state, action) {
      return state.filter((item) => item.id !== action.payload);
    },
    updateQuantity(state, action) {
      const { id, type } = action.payload; // Nhận id và loại hành động (increase/decrease)
      const item = state.find((item) => item.id === id);
      if (item) {
        if (type === "increase") item.quantity += 1;
        if (type === "decrease" && item.quantity > 1) item.quantity -= 1;
      }
    },
    clearCart(state) {
      return [];
    },
  },
});

// Selector tính tổng số lượng sản phẩm trong giỏ hàng
export const selectCartQuantity = (state) =>
  state.cart.reduce((total, item) => total + item.quantity, 0);

export const { addToCart, removeFromCart, updateQuantity, clearCart } =
  cartSlice.actions;
export default cartSlice.reducer;
