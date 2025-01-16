import React, { useEffect, useState } from "react";
import { Input, message } from "antd";
import axios from "axios";
import "./Review.scss";

const Review = ({ maSanPham }) => {
  const [rating, setRating] = useState(0);
  const [reviewContent, setReviewContent] = useState("");
  const [reviews, setReviews] = useState([]);
  const [loadingReviews, setLoadingReviews] = useState(true);
  const [username, setUsername] = useState("");
  const [product, setProduct] = useState(null);

  const token = localStorage.getItem("access_token");
  const ten_dang_nhap = localStorage.getItem("tendangnhap")

  useEffect(() => {
    if (token) {
      const userNameFromCookie = localStorage.getItem("ten_dang_nhap");
      setUsername(userNameFromCookie || "Người dùng");
    } else {
    }
  }, [token]);

  useEffect(() => {
    if (!maSanPham) {
      console.error("maSanPham is undefined");
      return;
    }
    axios
      .get(`http://127.0.0.1:8000/products/${maSanPham}`)
      .then((response) => {
        if (response.data) {
          setProduct(response.data);
        } else {
          console.error("No product data received from API");
        }
      })
      .catch((error) => {
        console.error("Error fetching product details:", error);
      });
  }, [maSanPham]);

  const fetchReviews = () => {
    setLoadingReviews(true);
    axios
      .get("http://127.0.0.1:8000/danhgia")
      .then((response) => {
        const productReviews = response.data.filter(
          (review) => String(review.ma_san_pham) === String(maSanPham)
        );
        setReviews(productReviews);
      })
      .catch((error) => console.error("Error fetching reviews:", error))
      .finally(() => setLoadingReviews(false));
  };

  useEffect(() => {
    if (maSanPham) fetchReviews();
  }, [maSanPham]);

  const handleReviewSubmit = (e) => {
    e.preventDefault();

    if (!rating || !reviewContent.trim()) {
      message.error("Vui lòng chọn số sao và nhập nội dung đánh giá!");
      return;
    }

    const reviewData = {
      ma_san_pham: maSanPham,
      so_sao: rating,
      nhan_xet: reviewContent,
    };

    axios
      .post("http://127.0.0.1:8000/danhgia", reviewData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then(() => {
        message.success("Đánh giá của bạn đã được gửi thành công!");
        setRating(0);
        setReviewContent("");
        fetchReviews();
      })
      .catch((error) => {
        console.error("Error submitting review:", error);
        if (error.response && error.response.status === 401) {
          message.error("Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
        } else {
          message.error("Đã xảy ra lỗi khi gửi đánh giá.");
        }
      });
  };

  if (!token) {
    return (
      <div className="review-container">
        <h3>Vui lòng đăng nhập để viết đánh giá</h3>
      </div>
    );
  }

  return (
    <div className="review-container">
      <h3>
        Chào {ten_dang_nhap}, viết đánh giá của bạn cho{" "}
        {product ? product.ten_san_pham : "sản phẩm này"}
      </h3>
      <form className="review-form" onSubmit={handleReviewSubmit}>
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
        <div className="review-input">
          <label htmlFor="review-content">Nội dung đánh giá *</label>
          <Input.TextArea
            id="review-content"
            rows="4"
            placeholder="Hãy chia sẻ ý kiến của bạn về sản phẩm..."
            value={reviewContent}
            onChange={(e) => setReviewContent(e.target.value)}
          />
        </div>
        <button type="submit">Gửi đánh giá</button>
      </form>

      <h3>Đánh giá khác</h3>
      <div className="reviews">
        {loadingReviews ? (
          <p>Đang tải đánh giá...</p>
        ) : reviews.length ? (
          reviews.map((review, index) => (
            <div key={index} className="review-item">
              <div className="review-stars">
                {[...Array(5)].map((_, i) => (
                  <span
                    key={i}
                    className={`star ${i < review.so_sao ? "filled" : ""}`}
                  >
                    ☆
                  </span>
                ))}
              </div>
              <p>{review.nhan_xet}</p>
            </div>
          ))
        ) : (
          <p>Chưa có đánh giá nào. Hãy là người đầu tiên!</p>
        )}
      </div>
    </div>
  );
};

export default Review;
