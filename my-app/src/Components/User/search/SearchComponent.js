import React, { useState, useCallback, useEffect, useRef } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import _ from "lodash"; // Thư viện lodash để dùng debounce
import "./SearchComponent.scss";

const SearchComponent = () => {
  const [query, setQuery] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  const [selectedPromotion, setSelectedPromotion] = useState(null); // Lưu khuyến mãi cụ thể
  const navigate = useNavigate();
  const searchRef = useRef(null); // Dùng ref để tham chiếu vào phần tử chứa search và gợi ý

  // URL ảnh mặc định
  const DEFAULT_IMAGE = "https://via.placeholder.com/150";

  // Fetch khuyến mãi cụ thể (ví dụ khuyến mãi mã 1)
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

  // Áp dụng khuyến mãi nếu có
  const applyDiscount = (price) => {
    if (selectedPromotion && selectedPromotion.muc_giam) {
      return price - (price * selectedPromotion.muc_giam) / 100;
    }
    return price;
  };

  // Hàm debounce để giảm số lần gọi API
  const debounceFetch = useCallback(
    _.debounce(async (query) => {
      if (!query.trim()) {
        setSuggestions([]);
        return;
      }

      try {
        const response = await axios.get(
          "http://localhost:8000/products/suggestions/by_name/",
          {
            params: { query, limit: 10 },
          }
        );
        setSuggestions(response.data);
      } catch (error) {
        console.error("Lỗi khi lấy gợi ý sản phẩm:", error);
        setSuggestions([]);
      }
    }, 300), // Đợi 300ms trước khi gọi API
    []
  );

  // Xử lý khi người dùng nhập
  const handleInputChange = (e) => {
    const value = e.target.value;
    setQuery(value);
    debounceFetch(value);
  };

  // Xử lý khi người dùng click vào sản phẩm gợi ý
  const handleSuggestionClick = (productId) => {
    navigate(`/viewProduct/${productId}`);
    // Ẩn danh sách gợi ý và reset query
    setSuggestions([]);
    setQuery("");
  };

  // Ẩn gợi ý và xóa chữ "TÌM KIẾM" khi click bên ngoài
  const handleClickOutside = (e) => {
    if (searchRef.current && !searchRef.current.contains(e.target)) {
      setSuggestions([]);
      setQuery(""); // Xóa nội dung ô tìm kiếm
    }
  };

  // Load khuyến mãi khi component mount
  useEffect(() => {
    fetchSpecificPromotion();
  }, []);

  // Thêm sự kiện click vào document khi component mount
  useEffect(() => {
    document.addEventListener("click", handleClickOutside);
    return () => {
      document.removeEventListener("click", handleClickOutside);
    };
  }, []);

  return (
    <div className="search-component" ref={searchRef}>
      <input
        type="text"
        value={query}
        onChange={handleInputChange}
        placeholder="TÌM KIẾM"
      />
      {suggestions.length > 0 && (
        <div className="suggestions-list">
          {suggestions.map((product) => {
            // Áp dụng khuyến mãi và lấy giá
            const price = applyDiscount(product.gia_khuyen_mai || product.gia);

            return (
              <div
                key={product.ma_san_pham}
                className="suggestion-item"
                onClick={() => handleSuggestionClick(product.ma_san_pham)}
              >
                <img
                  src={product.anh_dai_dien || DEFAULT_IMAGE}
                  alt={product.ten_san_pham}
                />
                <div className="product-info">
                  <h4>{product.ten_san_pham}</h4>
                  <p>{product.hang_xe}</p>
                  <div className="price-info">
                    {product.gia_khuyen_mai && product.gia_khuyen_mai !== product.gia && (
                      <span className="old-price">
                        {new Intl.NumberFormat("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        }).format(product.gia)}
                      </span>
                    )}
                    <span className="current-price">
                      {new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      }).format(price)}
                    </span>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
};

export default SearchComponent;
