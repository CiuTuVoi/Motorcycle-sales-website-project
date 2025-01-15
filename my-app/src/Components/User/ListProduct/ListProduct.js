import React, { useState, useEffect } from "react";
import axios from "axios";
import Layout from "../Header/Header";
import Footer from "../Footer/Footer";
import { Link } from "react-router-dom";
import { BsCaretLeft, BsCaretRight } from "react-icons/bs";
import { IoIosHeart } from "react-icons/io";
import "./ListProduct.scss";

const Honda = () => {
  useEffect(() => {
    window.scrollTo(0, 0); // Scroll to top of the page
  }, []);

  const [products, setProducts] = useState([]); // Dữ liệu sản phẩm từ API
  const [selectedCategory, setSelectedCategory] = useState("Honda"); // Danh mục mặc định
  const [currPage, setCurrPage] = useState(1);
  const itemsPerPage = 6; // Số sản phẩm mỗi trang
  const [isLoading, setIsLoading] = useState(true); // Trạng thái loading
  const [favoriteItems, setFavoriteItems] = useState([]); // Lưu các sản phẩm yêu thích

  // Lấy dữ liệu từ API
  const fetchData = async () => {
    try {
      setIsLoading(true);
      const response = await axios.get("http://127.0.0.1:8000/products");
      console.log("API Response:", response.data); // Log phản hồi API
      setProducts(response.data);
      setIsLoading(false);
    } catch (error) {
      console.error("Error fetching products:", error);
      setIsLoading(false);
    }
  };

  // Fetch dữ liệu khi component mount
  useEffect(() => {
    fetchData();

    // Load sản phẩm yêu thích từ localStorage nếu có
    const savedFavorites = JSON.parse(localStorage.getItem("favoriteItems")) || [];
    setFavoriteItems(savedFavorites);
  }, []);

  // Thêm hoặc xóa sản phẩm vào yêu thích
  const toggleFavorite = (item) => {
    let updatedFavorites;
    if (favoriteItems.some((fav) => fav.ma_san_pham === item.ma_san_pham)) {
      updatedFavorites = favoriteItems.filter((fav) => fav.ma_san_pham !== item.ma_san_pham);
    } else {
      updatedFavorites = [...favoriteItems, item];
    }
    setFavoriteItems(updatedFavorites);

    // Lưu danh sách yêu thích vào localStorage
    localStorage.setItem("favoriteItems", JSON.stringify(updatedFavorites));
  };

  // Lọc sản phẩm theo danh mục
  const filteredData = products.filter(
    (item) => item.hang_xe.toLowerCase() === selectedCategory.toLowerCase()
  );

  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  // Lấy các sản phẩm của trang hiện tại
  const startIndex = (currPage - 1) * itemsPerPage;
  const currData = filteredData.slice(startIndex, startIndex + itemsPerPage);

  // Chuyển trang
  const handlePageChange = (page) => {
    if (page > 0 && page <= totalPages) {
      setCurrPage(page);
      window.scrollTo(0, 0);
    }
  };

  // Thay đổi danh mục sản phẩm
  const handleCategoryChange = (category) => {
    setSelectedCategory(category);
    setCurrPage(1); // Đặt lại trang về 1
  };

  return (
    <div className="container">
      <div className="Header-list-product">
        <Layout />
      </div>

      <div className="container-product">
        <div className="product-list-brand">
          <h2>DANH MỤC SẢN PHẨM</h2>
          <ul>
            <li><button onClick={() => handleCategoryChange("Honda")}>Xe máy Honda</button></li>
            <li><button onClick={() => handleCategoryChange("Yamaha")}>Xe máy Yamaha</button></li>
            <li><button onClick={() => handleCategoryChange("Sym")}>Xe máy Sym</button></li>
            <li><button onClick={() => handleCategoryChange("Suzuki")}>Xe máy Suzuki</button></li>
          </ul>
        </div>

        {/* Danh sách sản phẩm */}
        <div className="home">
          {isLoading ? (
            <p>Loading...</p>
          ) : currData.length === 0 ? (
            <p className="no-products">Hiện sản phẩm chưa được cập nhật</p>
          ) : (
            <div className="product-list">
              {currData.map((item) => (
                <Link
                  to={`/viewProduct/${item.ma_san_pham}`}
                  key={item.ma_san_pham}
                >
                  <div
                    className="product-item"
                  >
                    <img
                      src={item.anh_dai_dien}
                      alt={item.ten_san_pham}
                      className="product-image"
                    />
                    <h2 className="product-name">{item.ten_san_pham}</h2>
                    <p className="product-brand">{item.hang_xe}</p>
                    <span className="price">
                      {new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      }).format(item.gia)}
                    </span>

                    {/* Biểu tượng yêu thích */}
                    <i
                      className={`favorate ${favoriteItems.some(
                        (fav) => fav.ma_san_pham === item.ma_san_pham
                      ) ? "active" : ""}`}
                      onClick={(e) => {
                        e.preventDefault(); // Ngăn hành động mặc định của liên kết
                        toggleFavorite(item);
                      }}
                    >
                      <IoIosHeart />
                    </i>
                  </div>
                </Link>
              ))}
            </div>
          )}

          {/* Phân trang */}
          {filteredData.length > 0 && (
            <div className="pagination-wrapper">
              <ul className="pagination">
                <li className="pagination-item">
                  <button
                    className="pagination-item-link"
                    onClick={() => handlePageChange(currPage - 1)}
                    disabled={currPage === 1}
                  >
                    <i className="icon">
                      <BsCaretLeft />
                    </i>
                  </button>
                </li>
                {Array.from({ length: totalPages }, (_, index) => (
                  <li className="number" key={index + 1}>
                    <button
                      className={`pagination-item-link ${
                        currPage === index + 1 ? "active" : ""
                      }`}
                      onClick={() => handlePageChange(index + 1)}
                    >
                      {index + 1}
                    </button>
                  </li>
                ))}
                <li className="pagination-item">
                  <button
                    className="pagination-item-link"
                    onClick={() => handlePageChange(currPage + 1)}
                    disabled={currPage === totalPages}
                  >
                    <i className="icon">
                      <BsCaretRight />
                    </i>
                  </button>
                </li>
              </ul>
            </div>
          )}
        </div>
      </div>

      <div className="footer-wrapper">
        <Footer />
      </div>
    </div>
  );
};

export default Honda;
