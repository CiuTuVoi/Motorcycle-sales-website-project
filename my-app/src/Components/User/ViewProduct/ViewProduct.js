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
  const [product, setProduct] = useState(null); // sản phẩm
  const [specification, setSpecification] = useState(null); // thông số kỹ thuật
  const [productImg, setProductImg] = useState([]); // hình ảnh
  const [cart, setCart] = useState([]);
  const [rating, setRating] = useState(0);
  const [quantity, setQuantity] = useState(1);
  const { ma_san_pham } = useParams();

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

    // lấy thông số kỹ thuật
    axios
      .get(`http://127.0.0.1:8000/thongso`)
      .then((response) => {
        console.log("Dữ liệu từ API thông số kỹ thuật:", response.data); // Kiểm tra dữ liệu trả về
        const spec = response.data.find(
          (item) => String(item.ma_san_pham) === String(ma_san_pham) // So sánh dạng chuỗi
        );
        console.log("Thông số kỹ thuật đã lọc:", spec); // Log kết quả sau khi lọc
        setSpecification(spec || null); // Nếu không tìm thấy, set null
      })
      .catch((error) => {
        console.error("Error fetching specifications:", error);
      });

    // lấy hình ảnh
    axios
      .get(`http://127.0.0.1:8000/anhxe`)
      .then((response) => {
        const images = response.data.filter(
          (item) => String(item.ma_san_pham) === String(ma_san_pham)
        );
        setProductImg(images || []);
      })
      .catch((error) => {
        console.error("Error fetching product images:", error);
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

          {/*Hình ảnh sản phẩm */}
          <h3 className="detail-specification">Hình ảnh xe</h3>
          <p className="line-specification"></p>

          <div className="productImage">
            <div style={{ display: "flex", flexWrap: "wrap", gap: "20px" }}>
              {productImg.map((item) => (
                <div key={item.ma_san_pham} style={{ textAlign: "center" }}>
                  <div>
                    <img
                      src={item.anh_1}
                      alt="Anh 1"
                      style={{
                        width: "200px",
                        height: "200px",
                        objectFit: "cover",
                      }}
                    />
                    <img
                      src={item.anh_2}
                      alt="Anh 2"
                      style={{
                        width: "200px",
                        height: "200px",
                        objectFit: "cover",
                      }}
                    />
                    <img
                      src={item.anh_3}
                      alt="Anh 3"
                      style={{
                        width: "200px",
                        height: "200px",
                        objectFit: "cover",
                      }}
                    />
                    <img
                      src={item.anh_4}
                      alt="Anh 4"
                      style={{
                        width: "200px",
                        height: "200px",
                        objectFit: "cover",
                      }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Bảng thông số kỹ thuật */}
          <h3 className="detail-specification">Thông số kỹ thuật</h3>
          <p className="line-specification"></p>

          <div className="specification">
            {specification ? (
              <table className="specification-table">
                <tbody>
                  {Object.entries(specification).map(
                    ([key, value]) =>
                      key !== "ma_san_pham" && ( // Bỏ qua `ma_san_pham`
                        <tr key={key}>
                          <td className="label">{formatLabel(key)}</td>
                          <td className="value">{value}</td>
                        </tr>
                      )
                  )}
                </tbody>
              </table>
            ) : (
              <p>Thông số kỹ thuật hiện chưa được cập nhật.</p>
            )}
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
