import React, { useEffect, useState } from "react";
import "./ViewProduct.scss";
import { InputNumber, message } from "antd";
import Header from "../Header/Header";
import { Carousel } from "react-responsive-carousel";
import "react-responsive-carousel/lib/styles/carousel.min.css";
import Footer from "../Footer/Footer";
import axios from "axios";
import { useParams } from "react-router-dom";

const ViewProduct = () => {
  const [product, setProduct] = useState(null);
  const [cart, setCart] = useState([]);
  const [rating, setRating] = useState(0);
  const [quantity, setQuantity] = useState(1);
  const { ma_san_pham } = useParams();
  console.log("ma san pham là", ma_san_pham);

  // Hàm format key thông số kỹ thuật
  const formatLabel = (key) => {
    return key
      .replace(/_/g, " ") // Thay dấu "_" bằng dấu cách
      .replace(/(?:^|\s)\S/g, (a) => a.toUpperCase()); // Viết hoa chữ cái đầu mỗi từ
  };

  useEffect(() => {
    if (!ma_san_pham) {
      console.error("ma_san_pham is undefined");
      return;
    }

    axios
      .get(`http://127.0.0.1:8000/products/${ma_san_pham}`)
      .then((response) => {
        setProduct(response.data);
      })
      .catch((error) => {
        console.error("Error fetching product details:", error);
      });
  }, [ma_san_pham]);

  const handleStarClick = (index) => setRating(index + 1);

  const handleSubmit = (e) => {
    e.preventDefault();
    message.success("Đánh giá của bạn đã được gửi thành công!");
  };

  const handleAddToCart = (product, quantity) => {
    if (!product?.id) {
      message.error("Không thể thêm sản phẩm vào giỏ hàng.");
      return;
    }

    setCart((prevCart) => {
      const existingProduct = prevCart.find((item) => item.id === product.id);
      if (existingProduct) {
        return prevCart.map((item) =>
          item.id === product.id
            ? { ...item, quantity: item.quantity + quantity }
            : item
        );
      }
      return [...prevCart, { ...product, quantity }];
    });
    message.success(`${product.ten_san_pham} đã được thêm vào giỏ hàng`);
  };

  if (!product) return <p>Không tìm thấy sản phẩm.</p>;

  return (
    <div className="container">
      <Header />
      <div className="container-content">
        <div className="product">
          <div className="product-detail">
            <Carousel className="main-slide">
              {product?.anh_dai_dien ? (
                Array.isArray(product.anh_dai_dien) ? (
                  product.anh_dai_dien.map((image, index) => (
                    <div key={index}>
                      <img src={image} alt={product.ten_san_pham} />
                    </div>
                  ))
                ) : (
                  <div>
                    <img
                      src={product.anh_dai_dien}
                      alt={product.ten_san_pham}
                    />
                  </div>
                )
              ) : (
                <div>Hình ảnh sản phẩm không khả dụng.</div>
              )}
            </Carousel>
            <div className="content-wrapper">
              <h3>{product.ten_san_pham}</h3>
              <div className="price">
                <p className="new-price">
                  {new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  }).format(product.gia)}
                </p>
              </div>

              <ul>
                <li>🎁 01 Nón bảo hiểm</li>
                <li>🎁 01 Khung biển số</li>
                <li>🎁 01 Móc khóa</li>
                <li>🎁 01 Túi vải</li>
                <li>🎁 01 Gói bảo dưỡng - bảo trì 5 năm</li>
              </ul>

              <div className="add-number">
                <li>
                  <div className="input-wrapper">
                    <InputNumber
                      min={1}
                      max={100}
                      defaultValue={1}
                      onChange={(value) => setQuantity(value)}
                    />
                  </div>
                  <button onClick={() => handleAddToCart(product, quantity)}>
                    ADD TO CART
                  </button>
                </li>
              </div>
            </div>
          </div>

          <div className="review-container">
            <h3>Viết đánh giá cho {product.ten_san_pham}</h3>
            <form className="review-form" onSubmit={handleSubmit}>
              <div className="rating">
                <label>Đánh giá của bạn *</label>
                <div className="stars">
                  {[...Array(5)].map((_, index) => (
                    <span
                      key={index}
                      role="button"
                      aria-label={`Rate ${index + 1} star${
                        index + 1 > 1 ? "s" : ""
                      }`}
                      className={`star ${index < rating ? "active" : ""}`}
                      onClick={() => handleStarClick(index)}
                    >
                      ★
                    </span>
                  ))}
                </div>
              </div>
              <textarea placeholder="Viết đánh giá..." required></textarea>
              <button type="submit">GỬI</button>
            </form>
          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
};

export default ViewProduct;
