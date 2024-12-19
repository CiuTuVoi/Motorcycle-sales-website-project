import React, { useEffect, useState } from "react";
import "./ViewProduct.scss";
import { InputNumber } from "antd";
import Header from "../Header/Header";
import { Carousel } from "react-responsive-carousel";
import "react-responsive-carousel/lib/styles/carousel.min.css";
import Footer from "../Footer/Footer";
import axios from "axios";
import { useParams } from "react-router-dom";

const ViewProduct = () => {
  const [product, setProduct] = useState(null);
  const [specifications, setSpecifications] = useState(null);
  const [cart, setCart] = useState([]);
  const [rating, setRating] = useState(0);
  const [quantity, setQuantity] = useState(1);
  const { ma_san_pham } = useParams();

  console.log("Product ID:", ma_san_pham);

  // Hàm format key thông số kỹ thuật
  const formatLabel = (key) => {
    return key
      .replace(/_/g, " ") // Thay dấu "_" bằng dấu cách
      .replace(/(?:^|\s)\S/g, (a) => a.toUpperCase()); // Viết hoa chữ cái đầu mỗi từ
  };

  useEffect(() => {
    const fetchProductData = async () => {
      try {
        // Lấy dữ liệu từ API
        const productResponse = await axios.get(
          `http://127.0.0.1:8000/products/${ma_san_pham}`
        );
        const specsResponse = await axios.get(
          `http://127.0.0.1:8000/thongso/${ma_san_pham}`
        );

        // Kiểm tra và thiết lập dữ liệu
        setProduct(productResponse.data);
        setSpecifications(specsResponse.data);
      } catch (error) {
        console.error("Error fetching data from API:", error);
      }
    };

    fetchProductData();
    window.scrollTo({ top: 0, behavior: "smooth" });
  }, [ma_san_pham]);

  const handleStarClick = (index) => setRating(index + 1);

  const handleSubmit = (e) => {
    e.preventDefault();
    alert("Review submitted!");
  };

  const handleAddToCart = (product, quantity) => {
    const existingProduct = cart.find((item) => item.id === product.id);
    if (existingProduct) {
      setCart(
        cart.map((item) =>
          item.id === product.id
            ? { ...item, quantity: item.quantity + quantity }
            : item
        )
      );
    } else {
      setCart([...cart, { ...product, quantity }]);
    }
    alert(`${product.ten_san_pham} đã được thêm vào giỏ hàng`);
  };

  if (!product) return <p>Không tìm thấy sản phẩm.</p>;
  if (!specifications) return <p>Không tìm thấy thông số kỹ thuật.</p>;

  return (
    <div className="container">
      <Header />
      <div className="container-content">
        <div className="product">
          <div className="product-detail">
            <Carousel className="main-slide">
              {product.anh_dai_dien &&
                (Array.isArray(product.anh_dai_dien)
                  ? product.anh_dai_dien.map((image, index) => (
                      <div key={index}>
                        <img src={image} alt={product.ten_san_pham} />
                      </div>
                    ))
                  : (
                      <div>
                        <img src={product.anh_dai_dien} alt={product.ten_san_pham} />
                      </div>
                    ))}
            </Carousel>
            <div className="content-wrapper">
              <h3>{product.ten_san_pham}</h3>
              <div className="gia">
                <p className="new-price">{product.gia}</p>
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
                      onChange={(value) => setQuantity(value)}
                    />
                    <button onClick={() => handleAddToCart(product, quantity)}>
                      ADD TO CART
                    </button>
                  </li>
                </div>
              </ul>
            </div>
          </div>

          <div className="description">
            <h4>MIÊU TẢ</h4>
            <p>{product.mo_ta}</p>
          </div>
          <div className="specifications">
            <h4>THÔNG SỐ KỸ THUẬT</h4>
            <table>
              <tbody>
                {specifications &&
                  Object.entries(specifications).map(([key, value], index) => (
                    <tr key={index}>
                      <td>{formatLabel(key)}</td>
                      <td>
                        {typeof value === "object"
                          ? JSON.stringify(value)
                          : value}
                      </td>
                    </tr>
                  ))}
              </tbody>
            </table>
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
