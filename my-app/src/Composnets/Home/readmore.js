import React from "react";
import "./readmore.scss";
import "./Home.scss";
import { Link } from "react-router-dom";
import {
  FaSearch,
  FaFacebookF,
  FaPhone,
  FaShoppingCart,
  FaHeart,
} from "react-icons/fa";
import { IoMdMail } from "react-icons/io";
import "react-slideshow-image/dist/styles.css";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import DropdownMenu from "./dropoutMenu";
import { InputNumber } from "antd";

const onchange = (value) => {
  console.log(value);
};

// Dữ liệu sản phẩm
const product = [
  {
    name: "Yamaha R15 V3",
    oldPrice: "87.000.000₫",
    newPrice: "57.000.000₫",
    img: "https://motomaluc.com/vnt_upload/product/07_2019/thumbs/740_yamaha-R15-v3-2019-3.png",
  },
  {
    name: "Honda Vario 160",
    oldPrice: "61.500.000₫",
    newPrice: "46.500.000₫",
    img: "https://cdn.honda.com.vn/motorbike-strong-points/December2022/jPc1KZKtRZRTPxgPhRYK.png",
  },
];

const blandItem = [
  { label: "Yamaha" },
  { label: "Honda" },
  { label: "Suzuki" },
];
const blockvidision = [
  { label: "200cc" },
  { label: "300cc" },
  { label: "1000cc" },
];

const skin = [
  { label: "Mũ bảo hiểm" },
  { label: "Áo giáp" },
  { label: "Chân phanh" },
];

function More() {
  return (
    <div className="container">
      <div className="wrapper">
        <div className="inner-wrapper">
          {/* Logo Section */}
          <div className="logo">
            <a href="./Home">
              <h1>LOGO</h1>
            </a>
          </div>

          {/* Search Section */}
          <div className="search">
            <input
              type="search"
              placeholder="Tìm kiếm sản phẩm"
              aria-label="search"
            />
            <div className="icon">
              <FaSearch />
            </div>
          </div>

          {/* Action Buttons Section */}
          <div className="button-actions">
            <div className="button-icon">
              <button>
                <FaFacebookF />
              </button>
            </div>
            <div className="button-icon">
              <button>
                <IoMdMail />
              </button>
            </div>
            <div className="button-icon">
              <button>
                <FaPhone />
              </button>
            </div>
          </div>

          {/* Cart Button Section */}
          <div className="button-cart">
            <button>
              <h4>GIỎ HÀNG</h4>
              <FaShoppingCart />
            </button>
          </div>

          {/*Favorites Button Section*/}
          <div className="button-favorites">
            <button>
              SP YÊU THÍCH
              <FaHeart />
            </button>
          </div>

          {/* login/Signup */}
          <div className="login">
            <Link to="/Login">Đăng nhập</Link>
            <span> / </span>
            <Link to="/Register">Đăng ký</Link>
          </div>
        </div>

        {/* Menu Section */}
        <div className="menu">
          <li>
            <a href="./Home">TRANG CHỦ</a>
          </li>
          <li>
            <a href="giới thiệu">GIỚI THIỆU</a>
          </li>
          <DropdownMenu title="HÃNG XE" items={blandItem} />
          <DropdownMenu title="PHÂN KHỐI" items={blockvidision} />
          <DropdownMenu title="PHỤ KIỆN" items={skin} />
        </div>
      </div>

      {/* Product Detail Section */}
      <div className="container-content">
        <div className="product">
          <div className="product-detail">
            <div className="product-img">
              <img src={product[0].img} alt={product[0].name} />
            </div>

            <div className="content-wrapper">
              <h3>{product[0].name}</h3>

              <div className="price">
                <p className="old-price">{product[0].oldPrice}</p>
                <p className="new-price">{product[0].newPrice}</p>
              </div>
              <ul>
                <li>🎁 01 Nón bảo hiểm</li>
                <li>🎁 01 Khung biển số</li>
                <li>🎁 01 Móc khóa</li>
                <li>🎁 01 Túi vải</li>
                <li>🎁 01 Gói bảo dưỡng - bảo trì 5 năm</li>
                <li>
                  <InputNumber
                    className="add-number"
                    min={1}
                    max={100}
                    defaultValue={1}
                    onChange={onchange}
                  />
                </li>
              </ul>
            </div>

            {/* Banner Section */}
            <div className="banner">
              <div className="hotline">
                <h2>HOTLINE</h2>
                <h2>123456789</h2>
              </div>
              <div className="content">
                <ul>
                  <li>Sản phẩm chính hãng</li>
                  <li>Giá thành cạnh tranh</li>
                  <li>Thương hiệu uy tín</li>
                  <li>Bảo hành, bảo dưỡng 5 năm</li>
                </ul>
              </div>
            </div>
          </div>

          <div className="addtocart">
            <button>ADD TO CART</button>
          </div>

          <div className="descerption">
            <div className="desception-baner">
              <h4>DESCRIPTION</h4>
            </div>
            <div className = "dash"></div>
            <p>
              <b>Yamaha R15 V3 </b>là mẫu xe máy đang rất được ưa chuộng đến từ hãng xe
              máy Yamaha. Sản phẩm đang sẵn hàng và có giá ưu đãi cực tốt tại<b> Hệ
              Thống Xe Máy Hoàng Cầu </b>. Gọi ngay <b className = "color-red">1900 63 66 67</b> để được trải nghiệm
              miễn phí mẫu xe Yamaha R15 V3
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default More;
