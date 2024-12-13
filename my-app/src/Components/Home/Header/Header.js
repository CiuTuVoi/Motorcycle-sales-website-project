import { Component } from "react";
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
import DropdownMenu from "../DropdowMenu/dropoutMenu";
import "./Header.scss";

const data = require("../../data/dataproduct.json");

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

class Layout extends Component {
  constructor(props) {
    super(props);
    this.state = {
      selecedCategory: "honda",
    };
  }

  handleCategoryChange = (category) => {
    this.setState({ selecedCategory: category });
  };
  render() {
    const{selecedCategory} = this.state
    const fitleData = data.filter((item) => item.category === selecedCategory);
    return (
      <div className="container">
        <div className="wrapper">
          <div className="inner-wrapper">
            {/* Logo Section */}
            <div className="logo">
              <Link to="/">
                <h1>
                  <img src="https://bizweb.dktcdn.net/100/422/602/themes/814220/assets/brand_image_2.png?1663380727397" />
                </h1>
              </Link>
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
                <button type="button">
                  <FaFacebookF />
                </button>
              </div>
              <div className="button-icon">
                <button type="button">
                  <IoMdMail />
                </button>
              </div>
              <div className="button-icon">
                <button type="button">
                  <FaPhone />
                </button>
              </div>
            </div>

            {/* Cart Button Section */}
            <div className="button-cart">
              <button type="button">
                <Link to  = "/cart">GIỎ HÀNG</Link>
                <FaShoppingCart />
              </button>
            </div>

            {/* Favorites Button Section */}
            <div className="button-favorites">
              <button type="button">
                SP YÊU THÍCH
                <FaHeart />
              </button>
            </div>

            {/* Login/Signup */}
            <div className="login">
              <Link to="/Login">Đăng nhập</Link>
              <span> / </span>
              <Link to="/Register">Đăng ký</Link>
            </div>
          </div>

          {/* Menu Section */}
          <div className="menu">
            <ul>
              <div className="no-drop">
                <li>
                  <Link to="/">TRANG CHỦ</Link>
                </li>
                <li>
                  <Link to="/gioi-thieu">GIỚI THIỆU</Link>
                </li>
              </div>
              <DropdownMenu title="HÃNG XE" items={blandItem} />
              <DropdownMenu title="PHÂN KHỐI" items={blockvidision} />
              <DropdownMenu title="PHỤ KIỆN" items={skin} />
            </ul>
          </div>
        </div>
      </div>
    );
  }
}

export default Layout;
