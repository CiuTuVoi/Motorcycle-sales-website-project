import React, { Component } from "react";
import { Link } from "react-router-dom";
import { FaFacebookF, FaPhone, FaShoppingCart, FaHeart } from "react-icons/fa";
import { IoMdMail } from "react-icons/io";
import DropdownMenu from "../DropdowMenu/dropoutMenu";
import "./Header.scss";
import { connect } from "react-redux";
import { selectCartQuantity } from "../redux/cartSlice";
import { selectFavoriteQuantity } from "../redux/favoriteSlice";
import { selectUserName, clearUserName } from "../redux/userSlide";
import SearchComponent from "../search/SearchComponent";
import NotificationBell from "../NotificationBell/NotificationBell";

const brandItems = [
  { label: "Yamaha", link: "/listproduct" },
  { label: "Honda", link: "/listproduct" },
  { label: "Suzuki", link: "/listproduct" },
  { label: "Sym", link: "/listproduct" },
];

const blockDivision = [
  { label: "200cc", link: "/200cc" },
  { label: "300cc", link: "/300cc" },
  { label: "1000cc", link: "/1000cc" },
];

const accessories = [
  { label: "Mũ bảo hiểm", link: "/helmet" },
  { label: "Áo giáp", link: "/armor" },
  { label: "Chân phanh", link: "/brake" },
];

class Layout extends Component {
  handleLogout = async () => {
    try {
      // Gửi yêu cầu logout đến server nếu cần
      await fetch("http://127.0.0.1:8000/logout", { method: "POST" });

      // Xóa thông tin đăng nhập trên client
      localStorage.removeItem("access_token");
      localStorage.removeItem("tendangnhap");

      // Xóa thông tin đăng nhập trong Redux
      this.props.clearUserName();
    } catch (error) {
      console.error("Đăng xuất thất bại:", error);
      alert("Đã xảy ra lỗi khi đăng xuất. Vui lòng thử lại.");
    }
  };

  render() {
    const { cartQuantity, favoriteQuantity, userName } = this.props;

    return (
      <div className="container">
        <div className="wrapper">
          <div className="inner-wrapper">
            {/* Logo Section */}
            <div className="logo">
              <Link to="/">
                <h1>
                  <img
                    src="https://png.pngtree.com/png-clipart/20230513/original/pngtree-motorbike-line-art-logo-design-png-image_9160404.png"
                    alt="Logo"
                  />
                </h1>
              </Link>
            </div>

            {/* Search Section */}
            <div className="search">
              <SearchComponent />
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
                {cartQuantity > 0 && (
                  <span className="cart-count">{cartQuantity}</span>
                )}
              </button>
            </div>

            {/* Favorites Button Section */}
            <div className="button-favorites">
              <button type="button">
                <Link className="link-favorite" to="/favorite">
                  SP YÊU THÍCH
                  {favoriteQuantity > 0 && (
                    <span className="favorite-count">{favoriteQuantity}</span>
                  )}
                  <span className="icon-favorite">
                  <FaHeart />
                </span>
                </Link>
                
              </button>
            </div>

            <div className="notificationbell">
              <NotificationBell />
            </div>

            {/* Login/Logout Section */}
            <div className="login">
              {userName ? (
                <>
                  <span className="user_name">{userName}</span>
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
              <DropdownMenu title="HÃNG XE" items={brandItems} />
              <DropdownMenu title="PHÂN KHỐI" items={blockDivision} />
              <DropdownMenu title="PHỤ KIỆN" items={accessories} />
            </ul>
          </div>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  cartQuantity: selectCartQuantity(state), // Lấy tổng số lượng giỏ hàng
  favoriteQuantity: selectFavoriteQuantity(state), // Lấy tổng số lượng sản phẩm yêu thích
  userName: selectUserName(state), // Lấy tên người dùng
});

const mapDispatchToProps = {
  clearUserName,
};

export default connect(mapStateToProps, mapDispatchToProps)(Layout);
