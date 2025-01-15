import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "../Components/User/Homepage/Home";
import Login from "../Components/User/Login/Login";
import Register from "../Components/User/Register/Register";
import ListProduct from "../Components/User/ListProduct/ListProduct";
import ViewProduct from "../Components/User/ViewProduct/ViewProduct";
import Cart from "../Components/User/ShoppingCart/Cart";
import Favorite from "../Components/User/Favorite/favorite";
import UserRoleRedirect from "../Components/services/UserRoleRedirect"; // Component xử lý vai trò
import "./App.scss";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/listProduct" element={<ListProduct />} />
        <Route path="/viewProduct/:ma_san_pham" element={<ViewProduct />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/favorite" element={<Favorite/>}/>
        <Route path="/admin" element={<UserRoleRedirect role="admin" />} />
        <Route path="/user" element={<UserRoleRedirect role="user" />} />
      </Routes>
    </Router>
  );
}

export default App;
