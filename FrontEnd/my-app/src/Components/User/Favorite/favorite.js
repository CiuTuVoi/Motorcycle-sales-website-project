import React, { useState, useEffect } from "react";
import Layout from "../Header/Header";
import Footer from "../Footer/Footer";
import { Link } from "react-router-dom";
import "./favorite.scss";

const Favorites = () => {
  const [favoriteItems, setFavoriteItems] = useState([]);

  // Lấy danh sách yêu thích từ localStorage
  useEffect(() => {
    const savedFavorites = JSON.parse(localStorage.getItem("favoriteItems")) || [];
    console.log(savedFavorites);  // Kiểm tra dữ liệu yêu thích
    setFavoriteItems(savedFavorites);
  }, []);

  return (
    <div className="favorites-container">
      <Layout />
      <div className="favorites-content">
        <h2>SẢN PHẨM YÊU THÍCH</h2>
        {favoriteItems.length === 0 ? (
          <p>Chưa có sản phẩm yêu thích nào.</p>
        ) : (
          <div className="favorite-list">
            {favoriteItems.map((item) => (
              <Link to={`/viewProduct/${item.ma_san_pham}`} key={item.ma_san_pham}>
                <div className="favorite-item">
                  <img src={item.anh_dai_dien || 'https://via.placeholder.com/150'} alt={item.ten_san_pham} />
                  <h3>{item.ten_san_pham}</h3>
                  <p>{item.hang_xe}</p>
                  <span className="price">
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(item.gia)}
                  </span>
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>
      <Footer />
    </div>
  );
};

export default Favorites;
