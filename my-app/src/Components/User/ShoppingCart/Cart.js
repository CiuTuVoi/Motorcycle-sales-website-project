import React, { useState } from "react";
import { Link } from "react-router-dom";
import Header from "../Header/Header";
import "./Cart.scss";

function Cart() {

  const [cart , setCart] = useState([])
  // Tính tổng tiền cho mỗi sản phẩm dựa trên số lượng
  const calculateSubtotal = (product) => product.quantity * product.gia;

  // Xử lý tăng số lượng sản phẩm
  const handleIncrease = (id) => {
    setCart(
      cart.map((item) =>
        item.id === id ? { ...item, quantity: item.quantity + 1 } : item
      )
    );
  };

  // Xử lý giảm số lượng sản phẩm
  const handleDecrease = (id) => {
    setCart(
      cart.map((item) =>
        item.id === id && item.quantity > 1
          ? { ...item, quantity: item.quantity - 1 }
          : item
      )
    );
  };

  // Xử lý xóa sản phẩm khỏi giỏ hàng
  const handleRemove = (id) => {
    setCart(cart.filter((item) => item.id !== id));
  };

  // Tính tổng tiền toàn bộ giỏ hàng
  const calculateTotal = () => {
    return cart.reduce((acc, product) => acc + calculateSubtotal(product), 0);
  };

  return (
    <div className="container">
      <div className="header-cart">
        <Header />
      </div>

      <div className="cart-wrapper">
        <div className="cart-container">
          <table className="cart-table">
            <thead>
              <tr>
                <th>PRODUCT</th>
                <th>PRICE</th>
                <th>QUANTITY</th>
                <th>SUBTOTAL</th>
                <th>ACTION</th>
              </tr>
            </thead>

            <tbody>
              {cart.length > 0 ? (
                cart.map((product) => (
                  <tr key={product.id}>
                    <td className="product-info">
                      <div className="product-details">
                        <img
                          className="product-img"
                          src={product.hinhAnh.black}
                          alt={product.tenXe}
                        />
                        <p>{product.tenSanPham}</p>
                      </div>
                    </td>
                    <td className="price">{product.gia.toLocaleString()} VND</td>
                    <td>
                      <div className="quantity-controls">
                        <button onClick={() => handleDecrease(product.id)}>-</button>
                        <input
                          type="text"
                          value={product.quantity}
                          readOnly
                          className="quantity-input"
                        />
                        <button onClick={() => handleIncrease(product.id)}>+</button>
                      </div>
                    </td>
                    <td className="total-price">
                      {calculateSubtotal(product).toLocaleString()} VND
                    </td>
                    <td>
                      <button
                        className="remove-button"
                        onClick={() => handleRemove(product.id)}
                      >
                        Xóa
                      </button>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan="5" className="empty-cart">
                    Giỏ hàng trống
                  </td>
                </tr>
              )}
            </tbody>
          </table>

          {/* Total Price Section */}
          {cart.length > 0 && (
            <div className="cart-total">
              <h3>
                Tổng tiền: <span>{calculateTotal().toLocaleString()} VND</span>
              </h3>
            </div>
          )}

          {/* Cart Actions */}
          <div className="cart-actions">
            <Link to = "/listProduct">
            <button className="continue-shopping">← TIẾP TỤC MUA SẮM</button>
            </Link>
            <button className="update-cart">LƯU THAY ĐỔI</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Cart;
