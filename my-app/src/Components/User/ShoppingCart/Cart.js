import React from "react";
import { useSelector, useDispatch } from "react-redux";
import { removeFromCart, clearCart } from "../redux/cartSlice";
import "./Cart.scss";
import Header from "../Header/Header";
import Footers from "../Footer/Footer";

const Cart = () => {
  const cart = useSelector((state) => state.cart);
  const dispatch = useDispatch();

  const calculateTotal = () => {
    return cart
      .reduce((total, item) => total + item.gia * item.quantity, 0)
      .toLocaleString();
  };

  // Default image for invalid or missing URLs
  const defaultImage = "/images/default.png";

  return (
    <div>
      <Header />
      <div className="cart-container">
        <h2 className="cart-title">Giỏ Hàng</h2>
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
                {cart.map((item) => (
                  <tr key={item.ma_san_pham}>
                    <td>
                      <img
                        src={
                          item.anh_dai_dien && item.anh_dai_dien.startsWith("http")
                            ? item.anh_dai_dien
                            : defaultImage
                        }
                        alt={item.ten_san_pham || "Sản phẩm"}
                        className="cart-item-image"
                        onError={(e) => {
                          e.target.onerror = null;
                          e.target.src = defaultImage;
                        }}
                      />
                    </td>
                    <td>{item.ten_san_pham}</td>
                    <td>{item.quantity}</td>
                    <td>{item.gia.toLocaleString()} VND</td>
                    <td>{(item.gia * item.quantity).toLocaleString()} VND</td>
                    <td>
                      <button
                        className="btn-remove"
                        onClick={() => dispatch(removeFromCart(item.ma_san_pham))}
                        aria-label={`Xóa sản phẩm ${item.ten_san_pham}`}
                      >
                        Xóa
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            <div className="cart-total">
              <h3>Tổng cộng: {calculateTotal()} VND</h3>
            </div>
            <div className="cart-actions">
              <button
                className="btn-clear"
                onClick={() => dispatch(clearCart())}
                aria-label="Xóa tất cả sản phẩm"
              >
                Xóa Tất Cả
              </button>
              <button className="btn-checkout" aria-label="Thanh toán">
                Thanh Toán
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
