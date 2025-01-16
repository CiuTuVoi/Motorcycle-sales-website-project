import { configureStore } from "@reduxjs/toolkit";
import userReducer, {setUserName} from "./userSlide"; // Import userSlice
import cartReducer from "./cartSlice"; // Import cartSlice

const store = configureStore({
  reducer: {
    user: userReducer,
    cart: cartReducer,
  },
});
const savedUserName = localStorage.getItem("tendangnhap");
if (savedUserName) {
  store.dispatch(setUserName(savedUserName));
}

export default store;


