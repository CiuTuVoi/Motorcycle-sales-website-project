import React, { useState } from "react";
import Layout from "../Header/Header";
import Footer from "../Footer/Footer";
import { Link } from "react-router-dom";
import { BsCaretLeft, BsCaretRight } from "react-icons/bs";
import "./ListProduct.scss";

const Data = require("../../data/dataproduct.json");

const Honda = () => {
  const [selectedCategory, setSelectedCategory] = useState("honda"); // Danh mục mặc định

  const [currPage, setCurrPage] = useState(1);
  const itemsPerPage = 8; // Số lượng sản phẩm mỗi trang

  // Lọc sản phẩm theo danh mục đã chọn
  const filteredData = Data.filter((item) => item.category === selectedCategory);
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
              <button onClick={() => handleCategoryChange("honda")}>
                Xe máy Honda
              </button>
            </li>
            <li>
              <button onClick={() => handleCategoryChange("yamaha")}>
                Xe máy Yamaha
              </button>
            </li>
            <li>
              <button onClick={() => handleCategoryChange("sym")}>
                Xe máy Sym
              </button>
            </li>
            <li>
              <button onClick={() => handleCategoryChange("suzuki")}>
                Xe máy Suzuki
              </button>
            </li>
          </ul>
        </div>

        {/* Danh sách sản phẩm */}
        <div className="home">
          {currData.length === 0 ? (
            <p className="no-products">Không có sản phẩm nào trong danh mục này.</p>
          ) : (
            <div className="product-list">
              {currData.map((item) => (
                <Link to="/viewProduct" key={item.id}>
                  <div
                    onClick={() => handleImgClick(item)}
                    className="product-item"
                  >
                    <img
                      src={item.hinhAnh.black}
                      alt={item.tenXe}
                      className="product-image"
                    />
                    <h2 className="product-name">{item.tenXe}</h2>
                    <p className="product-brand">{item.hangXe}</p>
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
