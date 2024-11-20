import React from "react";
import {Link} from "react-router-dom";
import './Home.scss';
import { FaSearch, FaFacebookF, FaPhone, FaTimes, FaShoppingCart,FaHeart, FaBars  } from "react-icons/fa";
import { AiOutlineRight , AiOutlineGlobal } from "react-icons/ai";
import { SiHonda , SiYamahamotorcorporation } from "react-icons/si";
import { IoMdMail } from "react-icons/io";
import { CgWebsite } from "react-icons/cg";
import { Slide } from 'react-slideshow-image';
import 'react-slideshow-image/dist/styles.css';
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from "react-slick";
import DropdownMenu from "./dropoutMenu";


const slideImages = [
    { url: 'https://bizweb.dktcdn.net/100/349/876/themes/712490/assets/banner-collection.jpg?1724233899726' },
    { url: 'https://thegioixechaydien.com.vn/upload/hinhanh/xe-may-honda-winner-x-phien-ban-den-mo71.jpg' },
    { url: 'https://thegioixechaydien.com.vn/upload/hinhanh/xe-may-honda-sh-mode-125-phien-ban-ca-tinh-abs90.jpg' }
];


/*img-product-besst-selling*/
const slideImageProduct = [
    {
        title: "Honda SH 125 - Bản Thể Thao",
        price: "85.000.000đ",
        image: "https://cdn.honda.com.vn/motorbikes/August2024/OdEB73r6Io8GOwX51wTV.png"
    },
    {
        title: "Honda SH 125 - Bản Đặc Biệt",
        price: "83.500.000đ",
        image: "https://cdn.honda.com.vn/motorbikes/July2024/humYsFoqZxFLaMIhklZH.png"
    },
    {
        title: "Honda SH 125 - Bản Cao Cấp",
        price: "83.000.000đ",
        image: "https://cdn.honda.com.vn/motorbikes/August2024/4IyI4oAluqwkEzvNl2Yh.png"
    },
    {
        title: "Honda SH Mode 125 - Bản Cao Cấp",
        price: "64.000.000đ",
        image: "https://cdn.honda.com.vn/motorbikes/August2024/3mJZ9NV7sBmWVJalt796.png"
    },
    
];
/*Object-components-slide-product-best-selling */
const  settings = {
    dots : true,
    infinite: true,
    speed : 500,
    slidesToShow: 4,
    slidesToScroll: 2, 
    arrows : true,
    
  };


  /*img-product-bland-honda */
const SlideProductHonda = [
    {
        title : 'SH mode 125',
        price : '57.132.000đ',
        image: 'https://cdn.honda.com.vn/motorbikes/August2024/3mJZ9NV7sBmWVJalt796.png'

    },
    {
        title : 'SH350i',
        price : '151.190.000đ',
        image: 'https://cdn.honda.com.vn/motorbikes/November2024/sYTCNfgI5E0JUJ8BCTQ3.png'

    },
    {
        title : 'Vario 160',
        price : '51.990.000đ',
        image: 'https://cdn.honda.com.vn/motorbikes/August2024/OdEB73r6Io8GOwX51wTV.png'

    },
    {
        title : 'SH160i/125i',
        price : '73.921.091đ',
        image: 'https://cdn.honda.com.vn/motorbikes/August2024/h9TheYxZITC0FtJOlGmK.png'

    },
    {
        title : 'REBEL 500 2024',
        price : '181.300.000đ',
        image: 'https://cdn.honda.com.vn/motorbikes/September2024/VQWtrj4jqeSb7T5SMFPU.png'
    },
];
/*Object-components-slide-bland-honda */
const  settingsHonda = {
    dots : true,
    infinite: true,
    speed : 500,
    slidesToShow: 5,
    slidesToScroll: 5, 
    arrows : true,
    autoplay: true,
    autoplaySpeed: 3000
    
  };


    /*object-img-product-yamaha*/
  const SlideProductYamaha = [
    {
        title : 'SH mode 125',
        price : '57.132.000đ',
        image: 'https://yamaha-motor.com.vn/wp/wp-content/uploads/2024/01/Jupiter-Mat-Grey_004-768x645.png'

    },
    {
        title : 'SH350i',
        price : '151.190.000đ',
        image: 'https://yamaha-motor.com.vn/wp/wp-content/uploads/2024/01/FreeGo-Black-Red-SMK-004-768x645.png'

    },
    {
        title : 'Vario 160',
        price : '51.990.000đ',
        image: 'https://yamaha-motor.com.vn/wp/wp-content/uploads/2024/01/Exciter-155-VVA-Cyan-ABS_004.png'

    },
    {
        title : 'SH160i/125i',
        price : '73.921.091đ',
        image: 'https://yamaha-motor.com.vn/wp/wp-content/uploads/2024/10/Ja-Std-2024-Red-Metallic-004-768x645.png'

    },
    {
        title : 'Winner X',
        price : '46.160.000đ',
        image: 'https://yamaha-motor.com.vn/wp/wp-content/uploads/2024/01/TMAX-560-004-1.png'
    },
    {
        title : 'Winner X',
        price : '46.160.000đ',
        image: 'https://yamaha-motor.com.vn/wp/wp-content/uploads/2024/01/Mask-Group-5821.png'
    },


  ];

  const  settingsYamaha = {
    dots : true,
    infinite: true,
    speed : 500,
    slidesToShow: 6,
    slidesToScroll: 3, 
    arrows : true,
    autoplay: true,
    autoplaySpeed: 1000
    
  };

  const spanStyle = {
    background: '#efefef',
    color: '#000000'
};

    const divStyle = {
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundSize: 'cover',
        height: '400px'
    };

    /*object-components-slide-banner */
    const productHot = [
    {
        name: 'Yamaha R15 V3',
        oldPrice: '87.000.000₫',
        newPrice: '57.000.000₫',
        img: 'https://motomaluc.com/vnt_upload/product/07_2019/thumbs/740_yamaha-R15-v3-2019-3.png',
    },
    {
        name: 'Honda Vario 160',
        oldPrice: '61.500.000₫',
        newPrice: '46.500.000₫',
        img: 'https://cdn.honda.com.vn/motorbike-strong-points/December2022/jPc1KZKtRZRTPxgPhRYK.png',
    },
     
  ];

  /*Object-components-slide-product-hot */
  const settingProductHot = {
    dots : true,
    infinite: true,
    speed : 500,
    slidesToShow: 1,
    slidesToScroll: 1, 
    arrows : true,
  };


  const blandItem = [
    {label : 'Yamaha'},
    {label : 'Honda'},
    {label : 'Suzuki'}
  ];
  const blockvidision = [
    {label: "200cc"},
    {label: "300cc"},
    {label: "1000cc"},

  ];

  const skin = [
    {label : "Mũ bảo hiểm"},
    {label : "Áo giáp"},
    {label : "Chân phanh"},


  ]

    
const Home = () => {
    return (
        <div className="container">
            <div className="wrapper">
                <div className = "inner-wrapper">
                {/* Logo Section */}
                <div className="logo">
                    <a href="./Home"><h1>LOGO</h1></a>
                </div>

                
            
                {/* Search Section */}
                <div className="search">
                    <input type="search" placeholder="Tìm kiếm sản phẩm"  aria-label="search"/>
                    <div className="icon"><FaSearch /></div>
                </div>


                {/* Action Buttons Section */}
                <div className="button-actions">
                    <div className="button-icon">
                        <button><FaFacebookF /></button>
                    </div>
                    <div className="button-icon">
                        <button><IoMdMail /></button>
                    </div>
                    <div className="button-icon">
                        <button><FaPhone /></button>
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


                {/* login/Sigup */}
                <div className="login">
                    <Link to="/Login">Đăng nhập</Link>
                    <span> / </span>
                    <Link to = "/Register">Đăng ký</Link>
                </div>
            </div>

            
            
            {/* Menu Section */}
            <div className="menu">
            
                <li><a href="./Home">TRANG CHỦ</a></li>
                <li><a href="giới thiệu">GIỚI THIỆU</a></li>
                <DropdownMenu title= "HÃNG XE"items = {blandItem}/>
                <DropdownMenu title = "PHÂN KHỐI" items={blockvidision}/>
                <DropdownMenu title = "PHỤ KIỆN" items = {skin}/>
                </div>
            </div>
                
        
            {/* Slide Show Section */}
            <div className="slide-show">
                <Slide>
                    {slideImages.map((slideImage, index) => (
                        <div key={index}>
                            <div style={{ ...divStyle, backgroundImage: `url(${slideImage.url})` }}>
                                <span style={spanStyle}>{slideImage.caption}</span>
                            </div>
                        </div>
                    ))}
                </Slide>
            </div>


            {/*best-selling-products */}
            <div className = "best-selling-products">
                <h1>SẢN PHẨM BÁN CHẠY</h1>
            </div>
            <div className = "border">  </div>

            

            {/*slide-show-product-best-selling*/}
            <div className="product-slider">
                <Slide {...settings}>
                    {slideImageProduct.map((product, index) => (
                        <div key={index} className="product-card">
                            <div className="product-image" style={{ backgroundImage: `url(${product.image})` }}></div>
                            <div className="product-info">
                                <h5>{product.title}</h5>
                                <p className="product-price">{product.price}</p>
                            </div>
                        </div>
                    ))}
                </Slide>
            </div>

            
            {/*HOTPRODUCT-CART-CONTAINER*/}
            <div className="product-slideshow">
                <Slider {...settingProductHot}>
                    {productHot.map((product, index) => (
                    <div className="product-card-container" key={index}>
                        <div className="product-card">
                        <div className="product-img">
                            <img src = {product.img} alt="" />
                            <div className="badge">HOT</div>
                        </div>
                        <div className="product-detail">
                            <h3>{product.name}</h3>
                            <div className="price">
                            <p className="old-price">{product.oldPrice}</p>
                            <p className="new-price">{product.newPrice}</p>
                            </div>
                            <ul>
                            <li>🎁 01 Nón bảo hiểm</li>
                            <li>🎁 01 Khung biển số</li>
                            <li>🎁 01 Móc khóa</li>
                            <li>🎁 01 Túi vải</li>
                            <li>🎁 01 Gói bảo dưỡng - bảo trì 5 năm</li>
                            </ul>
                            <button><a href="./readmore">ĐỌC TIẾP</a></button>
                        </div>
                        </div>
                    </div>
                    ))}
                </Slider>
            </div>    


            {/* HONDAMENU */}
            <div className = "hondamenu">
                <div className = "iconhonda"><SiHonda /></div>
                <h1>XE MÁY HONDA </h1>
            </div>
            <link rel="stylesheet" href="" />
            <div className = "morehonda"><Link to = "/Honda">XEM THÊM <AiOutlineRight /></Link></div>
            <div className = "border">  </div>

            {/*BLANDHONDA */}
            <div className="blandhonda">
                <img src="https://hondathanhbinhan.com/wp-content/uploads/2021/08/banner-sh-mode-125-2024.png" alt="" />
            </div>


            {/* SLIDE-PRODUCT-HONDA */}
            <div className = "slide-product-honda">
                <Slide {...settingsHonda}>
                    {SlideProductHonda.map((product , index) => (
                        <div key = {index} className = "product-container">
                            <div className = "product-img" style = {{backgroundImage: `url(${product.image})`}}></div>
                            <div className = "product-info">
                                <h5>{product.title}</h5>
                                <p className = "product-price">{product.price}</p>
                            </div>
                        </div>
                    ))}
                </Slide>
            </div>

            

            {/* YAMAHAMENU */}
            <div className = "hondamenu">
                <div className = "iconhonda"><SiYamahamotorcorporation /></div>
                <h1>XE MÁY YAMAHA </h1>
            </div>
            
            <div className = "morehonda"><Link to = "/Honda">XEM THÊM <AiOutlineRight /></Link></div>
            <div className = "border">  </div>

            {/*BANNER-YAMAHA*/}
            <div className = "banner-yamaha">
                <img src="https://bazaarvietnam.vn/wp-content/uploads/2022/11/ket-noi-yamaha.jpg" alt="" />
                <img src="https://yamaha-motor.com.vn/wp/wp-content/uploads/2020/10/xe-ga-nam-gia-re-min.png" alt="" />
            </div>


            {/*SLIDE-PRODUCT-YAMAHA*/}

            <div className = "slide-product-yamaha">
                <Slide {...settingsYamaha}>
                    {SlideProductYamaha.map((product, index) => (
                        <div key = {index} className = "product-container">
                            <div className = "product-img" style = {{backgroundImage: `url(${product.image})`}}>
                                
                            </div>
                            <div className = "product-info">
                                <h5>{product.title}</h5>
                            </div>
                            <div className = "product-price">
                                {product.price}
                            </div>
                        </div>
                    ))}
                </Slide>
            </div>

            
            {/*FOOTER*/}
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
                        <button className="contact-button"><a href="liên hệ">LIÊN HỆ HOTLINE</a></button>
                        <button className="email-button"><a href="email">GỬI EMAIL</a></button>
                        <h3>THẾ GIỚI XE MÁY</h3>
                        <p>
                            Chuyên nhập khẩu và phân phối trực tiếp các <br />sản phẩm xe máy chính hãng
                            các thương hiệu <br /> Honda, Yamaha, Suzuki ...
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
                        <p><span className = "address"><AiOutlineGlobal /></span> Địa chỉ: Đại học khoa học tự nhiên - ĐHQGHN</p>
                        <p><span className = "website"><CgWebsite /></span> Website: thegioixemay.com</p>
                        <p><span className = "phone"><FaPhone /></span> Hotline: 1234567899</p>
                        <div className="search">
                            <input type="search" placeholder="Tìm kiếm sản phẩm"  aria-label="search"/>
                            <button><FaSearch /></button>   
                        </div>
                    </div>
                </div>
            </footer>

        </div>
    );
};

export default Home;


