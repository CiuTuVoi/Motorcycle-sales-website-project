import { configureStore } from "@reduxjs/toolkit";
import userReducer from "./userSlide"; // Import userSlice
import cartReducer from "./cartSlice"; // Import cartSlice

const store = configureStore({
  reducer: {
    user: userReducer,
    cart: cartReducer,
  },
});

export default store;
