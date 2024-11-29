import React, { useState } from "react";
import Layout from "../Header/Header";
import "./ListProduct.scss";
import Footer from "../Footer/Footer";
import { Link } from "react-router-dom";

const Data = require("../../data/dataproduct.json");

const Honda = () => {
  const [selectedCategory, setSelectedCategory] = useState("honda"); // Mặc định chọn Honda
  const [selectedProduct, setSelectedProduct] = useState(Data[0]); // Chọn sản phẩm đầu tiên mặc định

  // Hàm thay đổi danh mục sản phẩm
  const handCategoryChange = (category) => {
    setSelectedCategory(category);
  };

  // Hàm khi click vào hình ảnh sản phẩm
  const handImgClick = (product) => {
    setSelectedProduct(product);
  };

  // Lọc sản phẩm theo danh mục đã chọn
  const filteredData = Data.filter((item) => item.category === selectedCategory);

  return (
    <div className="container">
      <div className="Header-list-product">
        <Layout />
      </div>

      <div className="container-product">
        <div className="product-list-brand">
          <h2>DANH MỤC SẢN PHẨM</h2>
          <ul>
            <li>
              <a onClick={() => handCategoryChange("honda")}>Xe máy Honda</a>
            </li>
            <li>
              <a onClick={() => handCategoryChange("yamaha")}>Xe máy Yamaha</a>
            </li>
            <li>
              <a onClick={() => handCategoryChange("sym")}>Xe máy Sym</a>
            </li>
            <li>
              <a onClick={() => handCategoryChange("suzuki")}>Xe máy Suzuki</a>
            </li>
          </ul>
        </div>
        <div className="home">
          <div className="product-list">
            {filteredData.map((item) => (
              <Link to= "/viewProduct" key={item.id} >
                <div onClick={() => handImgClick(item)} className="product-item">
                  <img
                    src={item.hinhAnh}
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
        </div>
      </div>

      <div className="footer-wrapper">
        <Footer />
      </div>
    </div>
  );
};

export default Honda;
