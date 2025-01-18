import React, { useEffect, useState } from "react";
import axios from "axios";
import { Slide } from "react-slideshow-image";
import { useNavigate } from "react-router-dom";
import "./BestSellingProducts.scss";

const BestSellingProducts = () => {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedPromotion, setSelectedPromotion] = useState(null);
  const navigate = useNavigate();

  const fetchBestSellingProducts = async (thang, nam) => {
    try {
      const response = await axios.post(
        "http://localhost:8000/update_san_pham_ban_chay/",
        { thang, nam }
      );
      return response.data.san_pham_ban_chay;
    } catch (error) {
      console.error("Lỗi khi gọi API:", error.response?.data || error.message);
      alert(`Lỗi khi gọi API: ${error.response?.data?.detail || error.message}`);
      return [];
    }
  };

  const fetchSpecificPromotion = async () => {
    try {
      const response = await axios.get("http://127.0.0.1:8000/khuyenmai");
      const promo = response.data.find((item) => item.ma_khuyen_mai === 1);
      setSelectedPromotion(promo);
    } catch (error) {
      console.error("Lỗi khi gọi API khuyến mãi cụ thể:", error);
      alert(
        `Lỗi khi gọi API khuyến mãi cụ thể: ${error.response?.data?.detail || error.message}`
      );
    }
  };

  const applyDiscount = (price) => {
    if (selectedPromotion && selectedPromotion.muc_giam) {
      return price - (price * selectedPromotion.muc_giam) / 100;
    }
    return price;
  };

  useEffect(() => {
    const loadData = async () => {
      setLoading(true);
      const thang = new Date().getMonth() + 1;
      const nam = new Date().getFullYear();
      await fetchSpecificPromotion();
      const data = await fetchBestSellingProducts(thang, nam);
      setProducts(data);
      setLoading(false);
    };

    loadData();
  }, []);

  if (loading) {
    return <p>Đang tải dữ liệu...</p>;
  }

  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 3,
    slidesToScroll: 1,
    arrows: true,
    responsive: [
      { breakpoint: 1024, settings: { slidesToShow: 3, slidesToScroll: 1 } },
      { breakpoint: 600, settings: { slidesToShow: 2, slidesToScroll: 1 } },
      { breakpoint: 480, settings: { slidesToShow: 1, slidesToScroll: 1 } },
    ],
  };

  const handleProductClick = (maSanPham) => {
    navigate(`/viewProduct/${maSanPham}`);
  };

  return (
    <div className="product-slider">
      <Slide {...settings}>
        {products.map((product) => {
          const discountedPrice = applyDiscount(product.gia);
          return (
            <div
              key={product.ma_san_pham}
              className="product-card"
              onClick={() => handleProductClick(product.ma_san_pham)}
            >
              <div
                className="product-image"
                style={{ backgroundImage: `url(${product.anh_dai_dien})` }}
              ></div>
              <div className="product-info">
                <h5>{product.ten_san_pham}</h5>
                <p className="product-price">
                  <span className="original-price">
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(product.gia)}
                  </span>
                  <span className="discounted-price">
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(discountedPrice)}
                  </span>
                </p>
                <p className="product-quantity">
                  Số lượng bán: {product.so_luong_ban}
                </p>
              </div>
            </div>
          );
        })}
      </Slide>
    </div>
  );
};

export default BestSellingProducts;
