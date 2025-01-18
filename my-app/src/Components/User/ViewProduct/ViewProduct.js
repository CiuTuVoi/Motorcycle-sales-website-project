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
import Cookies from "js-cookie";
import Review from "../review/Review";

const ViewProduct = () => {
  const [product, setProduct] = useState(null); // Sản phẩm
  const [specification, setSpecification] = useState(null); // Thông số kỹ thuật
  const [productImg, setProductImg] = useState([]); // Hình ảnh sản phẩm
  const [rating, setRating] = useState(0); // Đánh giá
  const [quantity, setQuantity] = useState(1); // Số lượng mua
  const { ma_san_pham } = useParams();
  const [reviewContent, setReviewContent] = useState("");
  const [reviews, setReviews] = useState([]);
  const [selectedPromotion, setSelectedPromotion] = useState(null);

  const dispatch = useDispatch();

  const formatLabel = (key) => {
    return key
      .replace(/_/g, " ")
      .replace(/(?:^|\s)\S/g, (a) => a.toUpperCase());
  };

  useEffect(() => {
    if (!ma_san_pham) {
      console.error("ma_san_pham is undefined");
      return;
    }

    const fetchData = async () => {
      try {
        const productResponse = await axios.get(
          `http://127.0.0.1:8000/products/${ma_san_pham}`
        );
        setProduct(productResponse.data);

        const specResponse = await axios.get("http://127.0.0.1:8000/thongso");
        const spec = specResponse.data.find(
          (item) => String(item.ma_san_pham) === String(ma_san_pham)
        );
        setSpecification(spec || null);

        const imagesResponse = await axios.get("http://127.0.0.1:8000/anhxe");
        const images = imagesResponse.data.filter(
          (item) => String(item.ma_san_pham) === String(ma_san_pham)
        );
        setProductImg(images || []);

        const promoResponse = await axios.get("http://127.0.0.1:8000/khuyenmai");
        const promo = promoResponse.data.find((item) => item.ma_khuyen_mai === 1); // Assuming promotion ID is 1
        setSelectedPromotion(promo);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, [ma_san_pham]);

  const fetchReviews = async () => {
    try {
      const response = await axios.get("http://127.0.0.1:8000/danhgia");
      const productReviews = response.data.filter(
        (review) => String(review.ma_san_pham) === String(ma_san_pham)
      );
      setReviews(productReviews);
    } catch (error) {
      console.error("Error fetching reviews:", error);
    }
  };

  useEffect(() => {
    fetchReviews();
  }, [ma_san_pham]);

  const handleReviewSubmit = async (e) => {
    e.preventDefault();

    if (!rating) {
      message.error("Vui lòng chọn số sao để đánh giá!");
      return;
    }

    if (!reviewContent.trim()) {
      message.error("Vui lòng nhập nội dung đánh giá!");
      return;
    }

    const reviewData = {
      ma_san_pham,
      so_sao: rating,
      nhan_xet: reviewContent,
    };

    const token = Cookies.get("token");

    try {
      await axios.post("http://127.0.0.1:8000/danhgia", reviewData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      message.success("Đánh giá của bạn đã được gửi thành công!");
      setRating(0);
      setReviewContent("");
      fetchReviews();
    } catch (error) {
      console.error("Error submitting review:", error);
      message.error("Đã xảy ra lỗi khi gửi đánh giá.");
    }
  };

  const handleAddToCart = async () => {
    if (!product) {
      message.error("Không thể thêm sản phẩm vào giỏ hàng.");
      return;
    }

    const item = {
      ma_san_pham: product.ma_san_pham,
      ten_san_pham: product.ten_san_pham,
      gia: product.gia_khuyen_mai || product.gia,
      so_luong: quantity,
    };

    const token = localStorage.getItem("access_token");

    try {
      const response = await axios.post("http://127.0.0.1:8000/giohang", item, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      dispatch(addToCart(response.data));
      message.success(`${product.ten_san_pham} đã được thêm vào giỏ hàng.`);
    } catch (error) {
      console.error("Error adding to cart:", error);
      message.error("Đã xảy ra lỗi khi thêm sản phẩm vào giỏ hàng.");
    }
  };

  const applyDiscount = (price) => {
    if (selectedPromotion && selectedPromotion.muc_giam) {
      return price - (price * selectedPromotion.muc_giam) / 100;
    }
    return price;
  };

  if (!product) return <p>Không tìm thấy sản phẩm.</p>;

  return (
    <div className="container">
      <Header />
      <div className="container-content">
        <div className="product">
          <div className="product-detail">
            <Carousel className="main-slide">
              {productImg.length > 0 ? (
                productImg.map((item, index) => (
                  <div key={`carousel-color-${index}`}>
                    <img
                      src={item.anh_1}
                      alt={`Color ${index + 1}`}
                      style={{ width: "100%", objectFit: "cover" }}
                    />
                  </div>
                ))
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
                  }).format(applyDiscount(product.gia_khuyen_mai || product.gia))}
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
                <button onClick={handleAddToCart}>THÊM VÀO GIỎ</button>
              </div>
            </div>
          </div>

          <h3 className="detail-specification">Hình ảnh xe</h3>
          <p className="line-specification"></p>
          <div className="productImage">
            <div style={{ display: "flex", flexWrap: "wrap", gap: "20px" }}>
              {productImg.map((item, index) => (
                <div
                  key={`image-${item.ma_san_pham}-${index}`}
                  style={{ textAlign: "center" }}
                >
                  {[item.anh_1, item.anh_2, item.anh_3, item.anh_4].map((image, idx) => (
                    <img
                      key={`image-${idx}`}
                      src={image}
                      alt={`Anh ${idx + 1}`}
                      style={{
                        width: "200px",
                        height: "200px",
                        objectFit: "cover",
                      }}
                    />
                  ))}
                </div>
              ))}
            </div>
          </div>

          <h3 className="detail-specification">Thông số kỹ thuật</h3>
          <h1 className="line-specification"></h1>
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

          <div className="review-container">
            <Review maSanPham={ma_san_pham} />
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default ViewProduct;
