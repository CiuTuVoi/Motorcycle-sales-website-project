import { createSlice } from '@reduxjs/toolkit';

const cartSlice = createSlice({
  name: 'cart',
  initialState: [],
  reducers: {
    addToCart: (state, action) => {
      const product = action.payload;
      const existingProduct = state.find(item => item.ma_san_pham === product.ma_san_pham);

      if (existingProduct) {
        existingProduct.quantity += product.quantity;
      } else {
        state.push(product);
      }
    },
    removeFromCart: (state, action) => {
      return state.filter(item => item.ma_san_pham !== action.payload);
    },
    clearCart: () => [],
  },
});

export const { addToCart, removeFromCart, clearCart } = cartSlice.actions;
export const selectCartQuantity = (state) => 
    state.cart.reduce((total, item) => total + item.quantity, 0)

export default cartSlice.reducer;
