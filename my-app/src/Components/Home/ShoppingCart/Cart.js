import React, { useState } from "react";
import Header from "../Header/Header";
import "./Cart.scss";

const dataProduct = require("../../data/dataproduct.json");
function Cart() {
  const [quantity, setQuantity] = useState(1);

  const handleIncrease = () => setQuantity(quantity + 1);
  const handleDecrease = () => {
    if (quantity > 0) setQuantity(quantity - 1);
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
              </tr>
            </thead>

            <tbody>
              {dataProduct.map(
                (
                  product 
                ) => (
                  <tr key={product.id}>
                    <td className="product-info">
                      <div className="product-details">
                        <img
                          className="product-img"
                          src={
                            product.hinhAnh
                          } 
                          alt={
                            product.tenXe
                          } 
                        />
                        <p>{product.tenSanPham}</p>{" "}
                        {/* Hiển thị tên sản phẩm */}
                      </div>
                    </td>
                    <td className="price">{product.gia.toLocaleString()}đ</td>{" "}
                    {/* Format giá tiền */}
                    <td>
                      <div className="quantity_controls">
                        <button onClick={handleDecrease}>-</button>
                        <input
                          type="text"
                          value={quantity}
                          readOnly /* Thêm thuộc tính readOnly để người dùng không chỉnh sửa trực tiếp */
                          className="quantity-input"
                        />
                        <button onClick={handleIncrease}>+</button>
                      </div>
                    </td>
                    <td className="total-price">
                      {(quantity * product.gia).toLocaleString()}đ
                    </td>
                  </tr>
                )
              )}
            </tbody>
          </table>
          <div className="cart-actions">
            <button className="continue-shopping">← TIẾP TỤC MUA SẮM</button>
            <button className="update-cart">LƯU THAY ĐỔI</button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Cart;
