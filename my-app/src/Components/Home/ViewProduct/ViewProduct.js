import React, { useState } from "react";
import "./ViewProduct.scss";

import "react-slideshow-image/dist/styles.css";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { InputNumber } from "antd";
import Header from "../Header/Header";
import { Carousel } from "react-responsive-carousel";
import "react-responsive-carousel/lib/styles/carousel.min.css";
import Footer from "../Footer/Footer";

const dataproduct = require("../../data/dataproduct.json");
const dataSpecc = require("../../data/dataSpecc.json");

const onchange = (value) => {
  console.log(value);
};

function More() {
  const [rating, setRating] = useState(0);

  const [selecedColor, setSelecedColor] = useState("black");

  const handleStarClick = (index) => {
    setRating(index + 1);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("Rating:", rating);
    alert("Review submitted!");
  };

  return (
    <div className="container">
      <div className="header-view">
        <Header />
      </div>

      {/* Product Detail Section */}
      <div className="container-content">
        <div className="product">
          <div className="product-detail">
            <Carousel className="main-slide">
              {dataproduct.map((index) => (
                <div key={index.id}>
                  <img src={index.hinhAnh[selecedColor]} alt={index.tenXe} />
                </div>
              ))}
              <div></div>
            </Carousel>
            <div className="content-wrapper">
              <h3>{dataproduct[0].tenXe}</h3>

              <div className="price">
                <p className="new-price">{dataproduct[0].gia}</p>
              </div>



              <ul>
                <li>🎁 01 Nón bảo hiểm</li>
                <li>🎁 01 Khung biển số</li>
                <li>🎁 01 Móc khóa</li>
                <li>🎁 01 Túi vải</li>
                <li>🎁 01 Gói bảo dưỡng - bảo trì 5 năm</li>
                <div className="add-number">
                  <li>
                    <InputNumber
                      min={1}
                      max={100}
                      defaultValue={1}
                      onChange={onchange}
                    />
                    <button onClick={handleSubmit}>ADD TO CART</button>
                  </li>
                </div>
              </ul>
            </div>

            {/*Color Selection Section*/}
            <div className="color-selection">
              <h4>Chọn màu</h4>
              <div className="colors">
                {Object.keys(dataproduct[0].hinhAnh).map((color) => (
                  <button
                    key={color}
                    className={`color-option ${color}`}
                    onClick={() => setSelecedColor(color)}
                  >
                    {color.charAt(0).toUpperCase() + color.slice(1)} {/* Hiển thị tên màu */}
                  </button>
                ))}
              </div>
            </div>

            
            {/* Banner Section */}
            <div className="banner">
              <div className="hotline">
                <h2>HOTLINE</h2>
                <h2>123456789</h2>
              </div>
              <div className="content">
                <ul>
                  <li>Sản phẩm chính hãng</li>
                  <li>Giá thành cạnh tranh</li>
                  <li>Thương hiệu uy tín</li>
                  <li>Bảo hành, bảo dưỡng 5 năm</li>
                </ul>
              </div>
            </div>
          </div>

          {/* Description Section */}
          <div className="description">
            <div className="description-banner">
              <h4>MIÊU TẢ</h4>
            </div>
            <div className="dash"></div>
            <p>
              <b>Yamaha R15 V3</b> là mẫu xe máy đang rất được ưa chuộng từ hãng
              xe Yamaha. Sản phẩm đang sẵn hàng với giá ưu đãi tại
              <b> Hệ Thống Xe Máy Hoàng Cầu</b>. Gọi ngay{" "}
              <b className="color-red">1900 63 66 67</b> để trải nghiệm mẫu xe
              miễn phí.
            </p>
          </div>

          {/* Specifications Section */}
          <div className="specifications">
            <div className="specifications-banner">
              <h4>THÔNG SỐ KỸ THUẬT</h4>
            </div>
            <div className="separate"></div>
            <div className="specifications-list">
              {dataSpecc.map((spec, index) => (
                <div key={spec.label + index} className="spec-content">
                  <table>
                    <tbody>
                      <tr>
                        <td>{spec.label} : </td>
                        <td>{spec.value}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              ))}
            </div>
          </div>

          {/* Image Gallery Section */}
          <div className="banner-img">
            <h4>HÌNH ẢNH SẢN PHẨM</h4>
          </div>
          <div className="separate-img"></div>

          {/* Review Section */}
          <div className="review-container">
            <h3>
              Be the first to review “Yamaha LEXI 155 VVA - Phiên Bản Tiêu
              Chuẩn”
            </h3>

            <form className="review-form" onSubmit={handleSubmit}>
              {/* Rating Section */}
              <div className="rating">
                <label>Your rating *</label>
                <div className="stars">
                  {[...Array(5)].map((_, index) => (
                    <span
                      key={index}
                      className={`star ${index < rating ? "active" : ""}`}
                      onClick={() => handleStarClick(index)}
                    >
                      ★
                    </span>
                  ))}
                </div>
              </div>

              {/* Review Text */}
              <div className="review-text">
                <label htmlFor="review">Your review *</label>
                <textarea
                  id="review"
                  rows="5"
                  placeholder="Write your review..."
                  required
                ></textarea>
              </div>

              {/* Name and Email */}
              <div className="name-email">
                <div className="field">
                  <label htmlFor="name">Name</label>
                  <input
                    type="text"
                    id="name"
                    placeholder="Your name"
                    required
                  />
                </div>
                <div className="field">
                  <label htmlFor="email">Email</label>
                  <input
                    type="email"
                    id="email"
                    placeholder="Your email"
                    required
                  />
                </div>
              </div>

              {/* Submit Button */}
              <button type="submit" className="submit-btn">
                SUBMIT
              </button>
            </form>
          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
}

export default More;
