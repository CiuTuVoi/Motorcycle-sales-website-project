import React, { useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { InputNumber, message } from "antd";
import axios from "axios";
import { useParams } from "react-router-dom";
import Header from "../Header/Header";
import Footer from "../Footer/Footer";
import { Carousel } from "react-responsive-carousel";
import "react-responsive-carousel/lib/styles/carousel.min.css";
import { addToCart } from "../redux/cartSlice";
import "./ViewProduct.scss";

const ViewProduct = () => {
  const [product, setProduct] = useState(null); // Sản phẩm
  const [specification, setSpecification] = useState(null); // Thông số kỹ thuật
  const [productImg, setProductImg] = useState([]); // Hình ảnh sản phẩm
  const [rating, setRating] = useState(0); // Đánh giá
  const [quantity, setQuantity] = useState(1); // Số lượng mua
  const { ma_san_pham } = useParams();
  const dispatch = useDispatch();

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

    // Lấy thông tin sản phẩm
    axios
      .get(`http://127.0.0.1:8000/products/${ma_san_pham}`)
      .then((response) => setProduct(response.data))
      .catch((error) => console.error("Error fetching product details:", error));

    // Lấy thông số kỹ thuật
    axios
      .get(`http://127.0.0.1:8000/thongso`)
      .then((response) => {
        const spec = response.data.find(
          (item) => String(item.ma_san_pham) === String(ma_san_pham)
        );
        setSpecification(spec || null); // Nếu không tìm thấy, set null
      })
      .catch((error) => console.error("Error fetching specifications:", error));

    // Lấy hình ảnh
    axios
      .get(`http://127.0.0.1:8000/anhxe`)
      .then((response) => {
        const images = response.data.filter(
          (item) => String(item.ma_san_pham) === String(ma_san_pham)
        );
        setProductImg(images || []);
      })
      .catch((error) => console.error("Error fetching product images:", error));
  }, [ma_san_pham]);

  // Xử lý thêm sản phẩm vào giỏ hàng
  const handleAddToCart = () => {
    if (!product) {
      message.error("Không thể thêm sản phẩm vào giỏ hàng.");
      return;
    }

    const item = {
      ma_san_pham: product.ma_san_pham,
      ten_san_pham: product.ten_san_pham,
      gia: product.gia,
      quantity,
    };

    dispatch(addToCart(item));
    message.success(`${product.ten_san_pham} đã được thêm vào giỏ hàng`);
  };

  if (!product) return <p>Không tìm thấy sản phẩm.</p>;

  return (
    <div className="container">
      <Header />
      <div className="container-content">
        <div className="product">
          {/* Chi tiết sản phẩm */}
          <div className="product-detail">
            <Carousel className="main-slide">
              {product?.anh_dai_dien ? (
                Array.isArray(product.anh_dai_dien) ? (
                  product.anh_dai_dien.map((image, index) => (
                    <div key={`image-${index}`}>
                      <img src={image} alt={product.ten_san_pham} />
                    </div>
                  ))
                ) : (
                  <div key="image-0">
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
                <InputNumber
                  min={1}
                  max={100}
                  defaultValue={1}
                  onChange={(value) => setQuantity(value)}
                />
                <button onClick={handleAddToCart}>ADD TO CART</button>
              </div>
            </div>
          </div>

          {/* Hình ảnh sản phẩm */}
          <h3 className="detail-specification">Hình ảnh xe</h3>
          <p className="line-specification"></p>
          <div className="productImage">
            <div style={{ display: "flex", flexWrap: "wrap", gap: "20px" }}>
              {productImg.map((item, index) => (
                <div key={`image-${item.ma_san_pham}-${index}`} style={{ textAlign: "center" }}>
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
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Thông số kỹ thuật */}
          <h3 className="detail-specification">Thông số kỹ thuật</h3>
          <p className="line-specification"></p>
          <div className="specification">
            {specification ? (
              <table className="specification-table">
                <tbody>
                  {Object.entries(specification).map(
                    ([key, value]) =>
                      key !== "ma_san_pham" && (
                        <tr key={`spec-${key}`}>
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

          {/* Đánh giá sản phẩm */}
          <div className="review-container">
            <h3>Viết đánh giá cho {product.ten_san_pham}</h3>
            <form
              className="review-form"
              onSubmit={(e) => {
                e.preventDefault();
                message.success("Đánh giá của bạn đã được gửi thành công!");
              }}
            >
              <div className="rating">
                <label>Đánh giá của bạn *</label>
                <div className="stars">
                  {[...Array(5)].map((_, index) => (
                    <span
                      key={index}
                      className={`star ${index < rating ? "filled" : ""}`}
                      onClick={() => setRating(index + 1)}
                    >
                      ☆
                    </span>
                  ))}
                </div>
              </div>
              <button type="submit">Gửi đánh giá</button>
            </form>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default ViewProduct;
