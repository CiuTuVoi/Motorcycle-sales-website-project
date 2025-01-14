import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "../Components/User/Homepage/Home";
import Login from "../Components/User/Login/Login";
import Register from "../Components/User/Register/Register";
import ListProduct from "../Components/User/ListProduct/ListProduct";
import ViewProduct from "../Components/User/ViewProduct/ViewProduct";
import Header from "../Components/User/Header/Header";
import Footer from "../Components/User/Footer/Footer";
import Cart from "../Components/User/ShoppingCart/Cart";
import Admin from "../../../admin/src/App";
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
        <Route path="/header" element={<Header />} />
        <Route path="/footer" element={<Footer />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/admin" element={<Admin />} />
      </Routes>
    </Router>
  );
}
export default App;
