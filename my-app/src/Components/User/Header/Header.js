import React, { Component } from "react";
import { Link } from "react-router-dom";
import { FaSearch, FaFacebookF, FaPhone, FaShoppingCart, FaHeart } from "react-icons/fa";
import { IoMdMail } from "react-icons/io";
import "react-slideshow-image/dist/styles.css";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import DropdownMenu from "../DropdowMenu/dropoutMenu";
import "./Header.scss";
import { connect } from "react-redux";
import { selectCartQuantity } from "../redux/cartSlice";
import { selectUserName, clearUserName } from "../redux/userSlide";
import Cookies from "js-cookie"; // Để lưu trữ session
import SearchComponent from "../search/SearchComponent";

const blandItem = [
  { label: "Yamaha" },
  { label: "Honda" },
  { label: "Suzuki" },
  { label: "Sym"}
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
  handleLogout = () => {
    Cookies.remove("access_token"); // Xóa token khi đăng xuất
    this.props.clearUserName(); // Xóa trạng thái tên người dùng trong Redux
  };

  render() {
    const { cartQuantity, userName } = this.props;

    return (
      <div className="container">
        <div className="wrapper">
          <div className="inner-wrapper">
            {/* Logo Section */}
            <div className="logo">
              <Link to="/">
                <h1>
                  <img src="https://bizweb.dktcdn.net/100/422/602/themes/814220/assets/brand_image_2.png?1663380727397" alt="Logo" />
                </h1>
              </Link>
            </div>

            {/* Search Section */}
            <div className="search">
              <SearchComponent/>
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
                <Link className="link-cart" to="/cart">
                  GIỎ HÀNG
                </Link>
                <FaShoppingCart />
                {cartQuantity > 0 && <span className="cart-count">{cartQuantity}</span>}
              </button>
            </div>

            {/* Favorites Button Section */}
            <div className="button-favorites">
              <button type="button">
                <Link className="link-favorite" to="/favorite">
                SP YÊU THÍCH
                <i className="icon-favorite"><FaHeart /></i>
                
                </Link>
              </button>
            </div>

            {/* Login/Logout Section */}
            <div className="login">
              {userName ? (
                <>
                  <span>Chào, {userName}</span>
                  <button className="logout-button" onClick={this.handleLogout}>
                    Đăng xuất
                  </button>
                </>
              ) : (
                <>
                  <Link to="/Login">Đăng nhập</Link>
                  <span> / </span>
                  <Link to="/Register">Đăng ký</Link>
                </>
              )}
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

const mapStateToProps = (state) => ({
  cartQuantity: selectCartQuantity(state), // Lấy số lượng giỏ hàng từ Redux
  userName: selectUserName(state), // Lấy tên người dùng từ Redux
});

const mapDispatchToProps = {
  clearUserName, // Action đăng xuất
};

export default connect(mapStateToProps, mapDispatchToProps)(Layout);
