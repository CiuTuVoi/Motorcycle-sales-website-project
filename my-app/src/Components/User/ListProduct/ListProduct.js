import React, { useState, useEffect } from "react";
import axios from "axios";
import Layout from "../Header/Header";
import Footer from "../Footer/Footer";
import { Link } from "react-router-dom";
import { BsCaretLeft, BsCaretRight } from "react-icons/bs";
import "./ListProduct.scss";

const Honda = () => {
  useEffect(() => {
    window.scrollTo(0, 0); // Đưa trang về đầu
  }, []);

  const [products, setProducts] = useState([]); // Dữ liệu sản phẩm từ API
  const [selectedCategory, setSelectedCategory] = useState("Honda"); // Danh mục mặc định
  const [currPage, setCurrPage] = useState(1);
  const itemsPerPage = 8; // Số lượng sản phẩm mỗi trang
  const [isLoading, setIsLoading] = useState(true); // Trạng thái loading

  // Hàm lấy dữ liệu từ API
  const fetchData = async (category) => {
    try {
      setIsLoading(true);
      const response = await axios.get(`http://127.0.0.1:8000/products`);
      console.log("API Response:", response.data); // Log response
      setProducts(response.data);
      setIsLoading(false);
    } catch (error) {
      console.error("Error fetching products:", error);
      setIsLoading(false);
    }
  };
  

  // Lấy dữ liệu khi danh mục thay đổi
  useEffect(() => {
    fetchData(selectedCategory);
  }, [selectedCategory]);

  // Lọc sản phẩm theo danh mục
  const filteredData = products.filter(
    (item) => item.hang_xe.toLowerCase() === selectedCategory.toLowerCase()
  ); // Dữ liệu từ API đã được lọc sẵn

  console.log("Products:", products);
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  // Lấy dữ liệu sản phẩm cho trang hiện tại
  const startIndex = (currPage - 1) * itemsPerPage;
  const currData = filteredData.slice(startIndex, startIndex + itemsPerPage);

  // Hàm thay đổi danh mục sản phẩm
  const handleCategoryChange = (category) => {
    setSelectedCategory(category);
    setCurrPage(1); // Đưa về trang đầu tiên
  };

  // Hàm xử lý chuyển trang
  const handlePageChange = (page) => {
    if (page > 0 && page <= totalPages) {
      setCurrPage(page);
    }
  };

  // Hàm khi người dùng click vào sản phẩm
  const handleImgClick = (item) => {
    console.log("Clicked product:", item);
  };

  return (
    <div className="container">
      {/* Header */}
      <div className="Header-list-product">
        <Layout />
      </div>

      {/* Danh mục sản phẩm */}
      <div className="container-product">
        <div className="product-list-brand">
          <h2>DANH MỤC SẢN PHẨM</h2>
          <ul>
            <li>
              <button onClick={() => handleCategoryChange("Honda")}>
                Xe máy Honda
              </button>
            </li>
            <li>
              <button onClick={() => handleCategoryChange("Yamaha")}>
                Xe máy Yamaha
              </button>
            </li>
            <li>
              <button onClick={() => handleCategoryChange("Sym")}>
                Xe máy Sym
              </button>
            </li>
            <li>
              <button onClick={() => handleCategoryChange("Suzuki")}>
                Xe máy Suzuki
              </button>
            </li>
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
                <Link to= {`/viewproduct/${products.ma_san_pham}`} key={item.ma_san_pham}>
                  <div
                    onClick={() => handleImgClick(item)}
                    className="product-item"
                  >
                    <img
                      src={item.anh_dai_dien}
                      alt={item.ten_san_pham}
                      className="product-image"
                    />
                    <h2 className="product-name">{item.ten_san_pham}</h2>
                    <p className="product-brand">{item.hang_xe}</p>
                    <span className="price">{item.gia}</span>
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

      {/* Footer */}
      <div className="footer-wrapper">
        <Footer />
      </div>
    </div>
  );
};

export default Honda;
