import React, { useEffect, useState } from "react";
import { Input, message } from "antd";
import axios from "axios";
import Cookies from "js-cookie";
import "./Review.scss";

const Review = ({ maSanPham }) => {
  const [rating, setRating] = useState(0); // Đánh giá sao
  const [reviewContent, setReviewContent] = useState(""); // Nội dung đánh giá
  const [reviews, setReviews] = useState([]); // Danh sách đánh giá
  const [loadingReviews, setLoadingReviews] = useState(true); // Trạng thái tải
  const [username, setUsername] = useState(""); // Tên người dùng

  // Kiểm tra token đăng nhập
  const token = Cookies.get("token");

  // Nếu không có token, yêu cầu người dùng đăng nhập
  useEffect(() => {
    if (token) {
      const userNameFromCookie = Cookies.get("username");
      setUsername(userNameFromCookie || "Người dùng");
    }
  }, [token]);

  // Lấy danh sách đánh giá
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

  // Xử lý gửi đánh giá
  const handleReviewSubmit = (e) => {
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
      ma_san_pham: maSanPham,
      so_sao: rating,
      nhan_xet: reviewContent,
    };

    if (!token) {
      message.error("Bạn chưa đăng nhập. Vui lòng đăng nhập để gửi đánh giá.");
      return;
    }

    axios
      .post("http://127.0.0.1:8000/danhgia", reviewData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then(() => {
        message.success("Đánh giá của bạn đã được gửi thành công!");
        setRating(0); // Reset rating
        setReviewContent(""); // Reset review content
        fetchReviews(); // Tải lại đánh giá
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

  // Nếu không có token, yêu cầu người dùng đăng nhập
  if (!token) {
    return (
      <div className="review-container">
        <h3>Vui lòng đăng nhập để viết đánh giá</h3>
      </div>
    );
  }

  return (
    <div className="review-container">
      <h3>Chào {username}, viết đánh giá của bạn:</h3>
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
          <p>Chưa có đánh giá nào.</p>
        )}
      </div>
    </div>
  );
};

export default Review;
