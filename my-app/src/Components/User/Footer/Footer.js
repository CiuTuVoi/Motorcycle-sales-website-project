import React from "react";
import { FaSearch, FaPhone } from "react-icons/fa";
import { AiOutlineGlobal } from "react-icons/ai";
import { CgWebsite } from "react-icons/cg";
import "react-slideshow-image/dist/styles.css";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import './Footer.scss'
function Footers() {
  return (
    <footer className="footer">
      <div className="footer-services">
        <h3>DANH MỤC DỊCH VỤ</h3>
        <div className="services-menu">
          <button>XE MÁY TRẢ GÓP</button>
          <button>XE MÁY NHẬP KHẨU</button>
          <button>XE MÁY CHÍNH HÃNG</button>
          <button>PHỤ KIỆN XE MÁY</button>
          <button>ĐỐI TÁC</button>
          <button>VỀ CHÚNG TÔI</button>
        </div>
      </div>

      <div className="footer-description">
        <p>Thương hiệu uy tín</p>
        <p>Sản phẩm chính hãng</p>
        <p>Giá thành cạnh tranh</p>
        <p>Hậu mãi tốt nhất</p>
      </div>

      <div className="footer-content">
        <div className="footer-left">
          <button className="contact-button">
            <a href="liên hệ">LIÊN HỆ HOTLINE</a>
          </button>
          <button className="email-button">
            <a href="email">GỬI EMAIL</a>
          </button>
          <h3>THẾ GIỚI XE MÁY</h3>
          <p>
            Chuyên nhập khẩu và phân phối trực tiếp các <br />
            sản phẩm xe máy chính hãng các thương hiệu <br /> Honda, Yamaha,
            Suzuki ...
          </p>
          <p>Trả góp xe máy chính hãng trong & ngoài nước</p>
        </div>

        <div className="footer-policies">
          <h3>Chính Sách</h3>
          <ul>
            <li>Mua Hàng</li>
            <li>Thanh Toán</li>
            <li>Bảo hành</li>
            <li>Bảo mật</li>
          </ul>
        </div>

        <div className="footer-info">
          <h3>Thông Tin</h3>
          <ul>
            <li>Về chúng tôi</li>
            <li>Dịch vụ</li>
            <li>Kiến thức</li>
            <li>Liên hệ</li>
          </ul>
        </div>

        <div className="footer-contact">
          <h3>THÔNG TIN LIÊN HỆ</h3>
          <p>
            <span className="address">
              <AiOutlineGlobal />
            </span>{" "}
            Địa chỉ: Đại học khoa học tự nhiên - ĐHQGHN
          </p>
          <p>
            <span className="website">
              <CgWebsite />
            </span>{" "}
            Website: thegioixemay.com
          </p>
          <p>
            <span className="phone">
              <FaPhone />
            </span>{" "}
            Hotline: 1234567899
          </p>
          <div className="search">
            <input
              type="search"
              placeholder="Tìm kiếm sản phẩm"
              aria-label="search"
            />
            <button>
              <FaSearch />
            </button>
          </div>
        </div>
      </div>
    </footer>
  );
}
export default Footers;
