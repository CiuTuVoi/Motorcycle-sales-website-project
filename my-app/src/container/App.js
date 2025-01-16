import React, { useEffect } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import { useDispatch } from "react-redux";
import { setUserName } from "../Components/User/redux/userSlide";

import Home from "../Components/User/Homepage/Home";
import Login from "../Components/User/Login/Login";
import Register from "../Components/User/Register/Register";
import ListProduct from "../Components/User/ListProduct/ListProduct";
import ViewProduct from "../Components/User/ViewProduct/ViewProduct";
import Cart from "../Components/User/ShoppingCart/Cart";
import Favorite from "../Components/User/Favorite/favorite";
import Introduce from "../Components/User/introduce/introduce";

import "./App.scss";

function App() {
  const dispatch = useDispatch();

  useEffect(() => {
    const storedUserName = localStorage.getItem("tendangnhap");
    if (storedUserName) {
      dispatch(setUserName(storedUserName));
    }
  }, [dispatch]);

  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/listProduct" element={<ListProduct />} />
        <Route path="/viewProduct/:ma_san_pham" element={<ViewProduct />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/favorite" element={<Favorite />} />
        <Route path="/introduce" element={<Introduce />} />
      </Routes>
    </Router>
  );
}

export default App;
