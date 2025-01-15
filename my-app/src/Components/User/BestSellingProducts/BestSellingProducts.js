import React, { useEffect, useState } from "react";
import "./BestSellingProducts.scss"; // File CSS cho giao diện
import axios from "axios";

const BestSellingProducts = () => {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);

  // Hàm gọi API để lấy dữ liệu sản phẩm bán chạy
  const fetchBestSellingProducts = async (thang, nam) => {
    try {
      const response = await axios.post("http://localhost:8000/update_san_pham_ban_chay/", {
        thang: thang,
        nam: nam,
      });
      return response.data.san_pham_ban_chay; // Trả về danh sách sản phẩm từ API
    } catch (error) {
      console.error("Lỗi khi gọi API:", error.response?.data || error.message);
      alert(`Lỗi khi gọi API: ${error.response?.data?.detail || error.message}`);
      return [];
    }
  };

  // Hàm load dữ liệu khi component được render
  useEffect(() => {
    const loadBestSellingProducts = async () => {
      setLoading(true);
      const thang = new Date().getMonth() + 1; // Lấy tháng hiện tại
      const nam = new Date().getFullYear();   // Lấy năm hiện tại
      const data = await fetchBestSellingProducts(thang, nam);
      setProducts(data);
      setLoading(false);
    };

    loadBestSellingProducts();
  }, []);

  if (loading) {
    return <p>Đang tải dữ liệu...</p>;
  }

  return (
    <div className="best-selling-products">
      <h1>SẢN PHẨM BÁN CHẠY</h1>
      <div className="product-list">
        {products.map((product, index) => (
          <div key={index} className="product-card">
            <div
              className="product-image"
              style={{
                backgroundImage: `url(${product.anh_dai_dien || "default_image.jpg"})`,
              }}
            ></div>
            <div className="product-info">
              <h5>{product.ten_san_pham}</h5>
              <p>Số lượng bán: {product.so_luong_ban}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default BestSellingProducts;
