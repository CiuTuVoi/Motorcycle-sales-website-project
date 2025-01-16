import React from "react";
import { useSelector, useDispatch } from "react-redux";
import { removeFromCart, clearCart } from "../redux/cartSlice";
import "./Cart.scss";
import Header from "../Header/Header";
import Footers from "../Footer/Footer";

const Cart = () => {
  const cart = useSelector((state) => state.cart);
  console.log("thông tin sản phẩm", cart)
  const dispatch = useDispatch();

  const calculateTotal = () => {
    return cart
      .reduce((total, item) => total + item.gia * item.quantity, 0)
      .toLocaleString();
  };

  return (
    <div>
      <Header/>
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
                {cart.map((item) => (
                  <tr key={item.ma_san_pham}>
                    <td>
                      <img
                        src={item.anh_dai_dien}
                        alt={item.ten_san_pham}
                        className="cart-item-image"
                      />
                    </td>
                    <td>{item.ten_san_pham}</td>
                    <td>{item.quantity}</td>
                    <td>{item.gia.toLocaleString()} VND</td>
                    <td>{(item.gia * item.quantity).toLocaleString()} VND</td>
                    <td>
                      <button
                        className="btn-remove"
                        onClick={() =>
                          dispatch(removeFromCart(item.ma_san_pham))
                        }
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
              >
                Xóa Tất Cả
              </button>
              <button className="btn-checkout">Thanh Toán</button>
            </div>
          </div>
        )}
      </div>
      <Footers/>
    </div>
  );
};

export default Cart;
