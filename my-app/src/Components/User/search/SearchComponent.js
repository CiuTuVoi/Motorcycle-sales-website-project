import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import './SearchComponent.scss';

const SearchComponent = () => {
  const [query, setQuery] = useState("");
  const [suggestions, setSuggestions] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  // Hàm tìm kiếm gợi ý sản phẩm
  const fetchSuggestions = async (query) => {
    if (!query) {
      setSuggestions([]);
      return;
    }

    setLoading(true);
    try {
      const response = await axios.get('http://localhost:8000/api/products/suggestions/by_name/', {
        params: { query, limit: 10 },  // Giới hạn số lượng sản phẩm trả về
      });
      setSuggestions(response.data);
    } catch (error) {
      console.error('Lỗi khi lấy gợi ý sản phẩm:', error);
      setSuggestions([]);
    } finally {
      setLoading(false);
    }
  };

  // Xử lý khi người dùng nhập
  const handleInputChange = (e) => {
    const value = e.target.value;
    setQuery(value);
    fetchSuggestions(value);
  };

  // Xử lý khi người dùng click vào sản phẩm gợi ý
  const handleSuggestionClick = (productId) => {
    navigate(`/viewProduct/${productId}`);
  };

  return (
    <div className="search-component">
      <input
        type="text"
        value={query}
        onChange={handleInputChange}
        placeholder="TÌM KIẾM"
      />
      {loading && <p>Đang tải...</p>}
      {suggestions.length > 0 && (
        <div className="suggestions-list">
          {suggestions.map((product) => (
            <div 
              key={product.ma_san_pham} 
              className="suggestion-item" 
              onClick={() => handleSuggestionClick(product.ma_san_pham)}
            >
              <img
                src={product.anh_dai_dien || 'https://via.placeholder.com/150'}
                alt={product.ten_san_pham}
              />
              <div className="product-info">
                <h4>{product.ten_san_pham}</h4>
                <p>{product.hang_xe}</p>
                <span>
                  {new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  }).format(product.gia)}
                </span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default SearchComponent;
