import React, { useEffect, useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import Slide from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import "./hostProduct.scss";

const HotProductCartContainer = () => {
  const [products, setProducts] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [promotion6, setPromotion6] = useState(null);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/products");
        const prod = response.data.filter((item) => item.ma_loai_xe === 5);
        setProducts(prod);
      } catch (err) {
        console.error("Error fetching data from API:", err);
        setError("Không thể tải dữ liệu. Vui lòng thử lại sau.");
      } finally {
        setIsLoading(false);
      }
    };

    fetchProducts();
  }, []);

  useEffect(() => {
    const fetchPromotions = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/khuyenmai");
        const promo1 = response.data.find((item) => item.ma_khuyen_mai === 6);
        setPromotion6(promo1);
      } catch (err) {
        console.error("Error fetching promotions:", err);
      }
    };

    fetchPromotions();
  }, []);

  const applyDiscount = (price) => {
    if (!price) return 0;
    if (promotion6 && promotion6.muc_giam) {
      return price - (price * promotion6.muc_giam) / 100;
    }
    return price;
  };

  if (isLoading) {
    return <p>Đang tải danh sách sản phẩm...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

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
      {/* Danh sách sản phẩm */}
      {products.length > 0 ? (
        <Slide {...settingProductHot}>
          {products.map((product) => (
            <div className="product-card-container" key={product.ma_san_pham}>
              <div className="product-card">
                <div className="product-img">
                  <Link to = {`/viewProduct/${product.ma_san_pham}`}>
                    <img
                      src={product.anh_dai_dien || "default_image.jpg"}
                      alt={product.ten_san_pham || "Sản phẩm"}
                    />
                  </Link>

                  <div className="badge">HOT</div>
                </div>
                <div className="product-detail">
                  <h3>{product.ten_san_pham}</h3>
                  <div className="price">
                    {product.gia && (
                      <p className="old-price">
                        {product.gia.toLocaleString()} VND
                      </p>
                    )}
                    <p className="new-price">
                      {applyDiscount(product.gia).toLocaleString()} VND
                    </p>
                  </div>
                  {promotion6 && (
                    <div className="promotion-banner">
                      <h2>
                        🎉 Ưu đãi đặc biệt: {promotion6.ten_khuyen_mai} 🎉
                      </h2>
                      <p>{promotion6.mo_ta}</p>
                    </div>
                  )}
                  <button>
                    <Link to={`/viewProduct/${product.ma_san_pham}`}>XEM CHI TIẾT SẢN PHẨM</Link>
                  </button>
                </div>
              </div>
            </div>
          ))}
        </Slide>
      ) : (
        <p>Không có sản phẩm nào thuộc loại xe với mã 6.</p>
      )}
    </div>
  );
};

export default HotProductCartContainer;
