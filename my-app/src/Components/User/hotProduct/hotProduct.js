// src/components/HotProductCartContainer.js
import React, { useEffect, useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import Slider from "react-slick"; // Import Slider từ react-slick
import "slick-carousel/slick/slick.css"; // CSS cần thiết cho react-slick
import "slick-carousel/slick/slick-theme.css";
import "./hostProduct.scss";

const HotProductCartContainer = () => {
  const [products, setProducts] = useState([]); // Chứa danh sách sản phẩm của hãng Honda
  const [isLoading, setIsLoading] = useState(true); // Trạng thái tải
  const [error, setError] = useState(null); // Trạng thái lỗi

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/products?hang_xe=Honda");
        const allProducts = response.data;

        // Sắp xếp danh sách theo giá tăng dần và lấy 5 sản phẩm đầu tiên
        const cheapestProducts = allProducts
          .sort((a, b) => a.gia - b.gia) // Sắp xếp theo giá tăng dần
          .slice(0, 5); // Chỉ lấy 5 sản phẩm đầu tiên

        setProducts(cheapestProducts);
      } catch (err) {
        console.error("Error fetching data from API:", err);
        setError("Không thể tải dữ liệu. Vui lòng thử lại sau.");
      } finally {
        setIsLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (isLoading) {
    return <p>Đang tải danh sách sản phẩm...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

  // Cấu hình cho react-slick (carousel)
  const settingProductHot = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
  };

  return (
    <div className="product-slideshow">
      {products.length > 0 ? (
        <Slider {...settingProductHot}>
          {products.map((product) => (
            <div className="product-card-container" key={product.id}>
              <div className="product-card">
                <div className="product-img">
                  <img
                    src={product.anh_dai_dien || "default_image.jpg"}
                    alt={product.ten_san_pham || "Sản phẩm"}
                  />
                  <div className="badge">HOT</div>
                </div>
                <div className="product-detail">
                  <h3>{product.ten_san_pham}</h3>
                  <div className="price">
                    <p className="new-price">{product.gia.toLocaleString()} VND</p>
                  </div>
                  <ul>
                    <li>🎁 01 Nón bảo hiểm</li>
                    <li>🎁 01 Khung biển số</li>
                    <li>🎁 01 Móc khóa</li>
                    <li>🎁 01 Túi vải</li>
                    <li>🎁 01 Gói bảo dưỡng - bảo trì 5 năm</li>
                  </ul>
                  <button>
                    <Link to={`/viewProduct/${product.ma_san_pham}`}>MORE</Link>
                  </button>
                </div>
              </div>
            </div>
          ))}
        </Slider>
      ) : (
        <p>Không có sản phẩm nào thuộc hãng Honda.</p>
      )}
    </div>
  );
};

export default HotProductCartContainer;
