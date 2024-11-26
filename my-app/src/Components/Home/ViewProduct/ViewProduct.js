import React, { useState } from "react";
import "./ViewProduct.scss";

import "react-slideshow-image/dist/styles.css";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { InputNumber} from "antd";
import Header from "../Header/Header";
import { Carousel } from "react-responsive-carousel";
import "react-responsive-carousel/lib/styles/carousel.min.css"; // requires a loader
import dataSpecc from "../../data/dataSpecc.json";
import Footer from "../Footer/Footer";


const onchange = (value) => {
  console.log(value);
};

// Dữ liệu sản phẩm

const product = [
  {
    image:
      "https://www.yamaha-motor-india.com/theme/v3/image/r15m/color/gray.png",
    name: "R15 V3",
    oldPrice: "20000000",
    newPrice: "1000000",
  },
  {
    image:
      "https://product.hstatic.net/200000281285/product/den_cbba673c2a6d456bbc915e3af3784d69.png",
    name: "R15 V3",
    oldPrice: "20000000",
    newPrice: "1000000",
  },
  {
    image:
      "https://yamaha-motor.com.vn/wp/wp-content/uploads/2017/11/R15_STDBLUE_IDN_2020-copy.png",
    name: "R15 V3",
    oldPrice: "20000000",
    newPrice: "1000000",
  },
];

function More() {
  const [rating, setRating] = useState(0);

  const handleStarClick = (index) => {
    setRating(index + 1);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Xử lý gửi dữ liệu ở đây
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
              <div>
                <img src={product[0].image} alt="Image 1" />
              </div>
              <div>
                <img src={product[1].image} alt="Image 2" />
              </div>
              <div>
                <img src={product[2].image} alt="Image 3" />
              </div>
            </Carousel>

            <div className="content-wrapper">
              <h3>{product[0].name}</h3>

              <div className="price">
                <p className="old-price">{product[0].oldPrice}</p>
                <p className="new-price">{product[0].newPrice}</p>
              </div>
              <ul>
                <li>🎁 01 Nón bảo hiểm</li>
                <li>🎁 01 Khung biển số</li>
                <li>🎁 01 Móc khóa</li>
                <li>🎁 01 Túi vải</li>
                <li>🎁 01 Gói bảo dưỡng - bảo trì 5 năm</li>
                <li>
                  <InputNumber
                    className="add-number"
                    min={1}
                    max={100}
                    defaultValue={1}
                    onChange={onchange}
                  />
                </li>
              </ul>
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
          <div className="addtocart">
            <button>ADD TO CART</button>
          </div>

          {/*dexcerption-product*/}
          <div className="descerption">
            <div className="desception-baner">
              <h4>MIÊU TẢ</h4>
            </div>
            <div className="dash"></div>
            <p>
              <b>Yamaha R15 V3 </b>là mẫu xe máy đang rất được ưa chuộng đến từ
              hãng xe máy Yamaha. Sản phẩm đang sẵn hàng và có giá ưu đãi cực
              tốt tại<b> Hệ Thống Xe Máy Hoàng Cầu </b>. Gọi ngay{" "}
              <b className="color-red">1900 63 66 67</b> để được trải nghiệm
              miễn phí mẫu xe Yamaha R15 V3
            </p>
          </div>

          {/*specifications-product*/}
          <div className="specifications">
            <div className="specifications-banner">
              <h4>THÔNG SỐ KỸ THUẬT</h4>
            </div>
            <div className="separate"></div>
            <div className="specifications-list">
              {dataSpecc.map((spec, index) => (
                <div key={spec.label + index} className="spec-conten">
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

          <div className="banner-img">
            <h4>HÌNH ẢNH SẢN PHẨM</h4>
          </div>
          <div className="separate-img"></div>
          <div className = "slide-product-img">
            
          </div>

          {/*review*/}
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
