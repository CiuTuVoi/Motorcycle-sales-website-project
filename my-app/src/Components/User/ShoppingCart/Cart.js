import React, { useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { removeFromCart, clearCart } from "../redux/cartSlice";
import axios from "axios";
import "./Cart.scss";
import Header from "../Header/Header";
import Footers from "../Footer/Footer";
import { message } from "antd";
import { Link, useNavigate } from "react-router-dom";

const Cart = () => {
  const [cart, setCart] = useState([]); // Danh sách sản phẩm trong giỏ hàng
  const [products, setProducts] = useState({}); // Lưu thông tin sản phẩm chi tiết với id là key
  const [selectedPromotion, setSelectedPromotion] = useState(null); // Lưu khuyến mãi cụ thể
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const fetchSpecificPromotion = async () => {
    try {
      const response = await axios.get("http://127.0.0.1:8000/khuyenmai");
      const promo = response.data.find((item) => item.ma_khuyen_mai === 1);
      setSelectedPromotion(promo); // Áp dụng khuyến mãi cụ thể
    } catch (error) {
      console.error("Lỗi khi gọi API khuyến mãi cụ thể:", error);
      message.error(
        `Lỗi khi gọi API khuyến mãi: ${error.response?.data?.detail || error.message}`
      );
    }
  };

  const applyDiscount = (price) => {
    if (selectedPromotion && selectedPromotion.muc_giam) {
      return price - (price * selectedPromotion.muc_giam) / 100; // Tính giá sau khuyến mãi
    }
    return price;
  };

  const fetchProduct = async () => {
    try {
      const productRespone = await axios.get("http://127.0.0.1:8000/products");
      setProducts(
        productRespone.data.reduce((acc, product) => {
          acc[product.ma_san_pham] = product;
          return acc;
        }, {}) // Tạo object với id sản phẩm làm key
      );
    } catch (error) {
      console.error("Error fetching products:", error);
    }
  };

  const fetchCart = async () => {
    try {
      const token = localStorage.getItem("access_token");
      const response = await axios.get(`http://127.0.0.1:8000/giohang`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setCart(response.data);
    } catch (error) {
      console.error("Error fetching cart data:", error);
    }
  };

  const handleRemoveFromCart = async (productId) => {
    try {
      const token = localStorage.getItem("access_token");
      await axios.delete(`http://127.0.0.1:8000/giohang/sanpham/${productId}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setCart((prevCart) =>
        prevCart.filter((item) => item.ma_san_pham !== productId)
      );
      dispatch(removeFromCart(productId));
      message.success("Sản phẩm đã được xóa khỏi giỏ hàng.");
    } catch (error) {
      console.error("Error removing product:", error);
      message.error("Không thể xóa sản phẩm khỏi giỏ hàng.");
    }
  };

  const handleClearCart = async () => {
    try {
      const token = localStorage.getItem("access_token");
      await axios.delete("http://127.0.0.1:8000/giohang/clear", {
        headers: { Authorization: `Bearer ${token}` },
      });
      setCart([]);
      dispatch(clearCart());
      message.success("Đã xóa toàn bộ giỏ hàng.");
    } catch (error) {
      console.error("Error clearing cart:", error);
      message.error("Không thể xóa toàn bộ giỏ hàng.");
    }
  };

  const calculateTotal = () => {
    const total = cart.reduce((total, item) => {
      const product = products[item.ma_san_pham];
      const price = product?.gia_khuyen_mai || product?.gia || 0;
      const discountedPrice = applyDiscount(price); // Áp dụng khuyến mãi
      const quantity = item.so_luong || 0;
      return total + discountedPrice * quantity;
    }, 0);
    
    // Định dạng giá tiền với dấu phân cách nghìn và đồng VND
    return new Intl.NumberFormat("vi-VN", {
      style: "currency",
      currency: "VND",
    }).format(total);
  };

  const handleCheckout = async () => {
    try {
      const token = localStorage.getItem("access_token");

      // Tạo mảng các sản phẩm từ giỏ hàng với số lượng
      const orderItems = cart.map(item => ({
        ma_san_pham: item.ma_san_pham,
        so_luong: item.so_luong
      }));

      console.log("Dữ liệu đơn hàng gửi đi:", orderItems);  // In dữ liệu gửi đi để kiểm tra

      // Tạo đơn hàng mới
      const orderData = {
        products: orderItems,  // Sản phẩm trong giỏ hàng
        total_price: calculateTotal(),  // Tổng giá trị đơn hàng
      };

      const response = await axios.post("http://127.0.0.1:8000/donhang", orderData, {
        headers: { Authorization: `Bearer ${token}` }
      });

      message.success("Đơn hàng đã được tạo thành công!");
      dispatch(clearCart());
      setCart([]);
      navigate("/order");
    } catch (error) {
      console.error("Error creating order:", error.response ? error.response.data : error.message);
      message.error("Không thể tạo đơn hàng.");
    }
  };

  useEffect(() => {
    fetchCart();
    fetchProduct();
    fetchSpecificPromotion();
  }, []);

  return (
    <div>
      <Header />
      <div className="cart-container">
        <h2>Giỏ Hàng</h2>
        {cart.length === 0 ? (
          <p className="empty-cart">Giỏ hàng của bạn đang trống.</p>
        ) : (
          <div className="cart-items">
            <table className="cart-table">
              <thead>
                <tr>
                  <th>Hình ảnh</th>
                  <th>Sản phẩm</th>
                  <th>Số lượng</th>
                  <th>Giá</th>
                  <th>Tổng</th>
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                {cart.map((item) => {
                  const product = products[item.ma_san_pham];
                  const price = product?.gia_khuyen_mai || product?.gia || 0;
                  const discountedPrice = applyDiscount(price);
                  return (
                    <tr key={item.ma_san_pham}>
                      <td>
                        <img
                          src={product?.anh_dai_dien || "/path/to/placeholder.jpg"}
                          alt={product?.ten_san_pham || "Unknown Product"}
                          className="cart-item-image"
                        />
                      </td>
                      <td>{product?.ten_san_pham || "Unknown Product"}</td>
                      <td>{item.so_luong}</td>
                      <td>
                        {new Intl.NumberFormat("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        }).format(discountedPrice)}
                      </td>
                      <td>
                        {new Intl.NumberFormat("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        }).format(discountedPrice * item.so_luong)}
                      </td>
                      <td>
                        <button
                          className="btn-remove"
                          onClick={() => handleRemoveFromCart(item.ma_san_pham)}
                        >
                          Xóa
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
            <div className="cart-total">
              <h3>Tổng cộng: {calculateTotal()}</h3>
            </div>
            <div className="cart-actions">
              <button className="btn-clear" onClick={handleClearCart}>
                Xóa Tất Cả
              </button>
              <button className="btn-checkout" onClick={handleCheckout}>
                Mua hàng
              </button>
            </div>
          </div>
        )}
      </div>
      <Footers />
    </div>
  );
};

export default Cart;
