import React, { Component } from "react";
import Layout from "../Layout/layout";
import "./honda.scss";

const Data = require("../data.json");
class Honda extends Component {
  render() {
    return (
      <div className="container">
        <div>
          <Layout />{" "}
        </div>

        <div className="container-product">
          <div className="product-list-brand">
            <h2>DANH MỤC SẢN PHẨM</h2>
            <ul>
              <li>
                <a href="#">Xe máy Honda</a>
              </li>
              <li>
                <a href="#">Xe máy Yamaha</a>
              </li>
              <li>
                <a href="#">Xe máy Sym</a>
              </li>
              <li>
                <a href="#">Xe máy Suzuki</a>
              </li>
            </ul>
          </div>
          <div className="home">
          <div className="product-list ">
            {Data.map((item) => (
              <div key={item.id} className="product-item">
                <img
                  src={item.hinhAnh}
                  alt={item.tenXe}
                  className="product-image"
                />
                <h2 className="product-name">{item.tenXe}</h2>
                <p className="product-brand">{item.hangXe}</p>
                <span className="price">{item.gia}</span>
              </div>
            ))}
          </div>
        </div>
        </div>
        
      </div>
    );
  }
}

export default Honda;
