-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2024 at 10:04 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `website_motorbike`
--

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `ma_chi_tiet` int(11) NOT NULL,
  `ma_don_hang` int(11) DEFAULT NULL,
  `ma_san_pham` int(11) DEFAULT NULL,
  `so_luong` int(11) NOT NULL,
  `gia` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`ma_chi_tiet`, `ma_don_hang`, `ma_san_pham`, `so_luong`, `gia`) VALUES
(1, 1, 1, 1, 106000000.00),
(2, 2, 15, 1, 23000000.00);

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `ma_danh_gia` int(11) NOT NULL,
  `ma_san_pham` int(11) DEFAULT NULL,
  `ma_nguoi_dung` int(11) DEFAULT NULL,
  `so_sao` int(11) DEFAULT NULL,
  `nhan_xet` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`ma_danh_gia`, `ma_san_pham`, `ma_nguoi_dung`, `so_sao`, `nhan_xet`, `ngay_tao`) VALUES
(1, 1, 5, 5, 'Xe rất tốt!', '2024-12-03 07:33:11'),
(2, 15, 6, 4, 'Giá hơi cao nhưng chất lượng ok.', '2024-12-03 07:33:11');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `ma_don_hang` int(11) NOT NULL,
  `ma_nguoi_dung` int(11) DEFAULT NULL,
  `tong_tien` decimal(15,2) NOT NULL,
  `trang_thai` enum('Dang_xu_ly','Hoan_thanh','Da_huy') DEFAULT 'Dang_xu_ly',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`ma_don_hang`, `ma_nguoi_dung`, `tong_tien`, `trang_thai`, `ngay_tao`) VALUES
(1, 5, 100000000.00, 'Dang_xu_ly', '2024-12-03 07:29:57'),
(2, 6, 20000000.00, 'Hoan_thanh', '2024-12-03 07:29:57');

-- --------------------------------------------------------

--
-- Table structure for table `kho_hang`
--

CREATE TABLE `kho_hang` (
  `ma_kho` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
  `so_luong_ton` int(11) NOT NULL,
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kho_hang`
--

INSERT INTO `kho_hang` (`ma_kho`, `ma_san_pham`, `so_luong_ton`, `ngay_cap_nhat`) VALUES
(1, 1, 50, '2024-12-03 07:28:51'),
(2, 2, 30, '2024-12-03 07:28:51'),
(3, 3, 20, '2024-12-03 07:28:51'),
(4, 4, 20, '2024-12-03 07:28:51'),
(5, 5, 20, '2024-12-03 07:28:51'),
(6, 6, 20, '2024-12-03 07:28:51'),
(7, 7, 20, '2024-12-03 07:28:51'),
(8, 8, 20, '2024-12-03 07:28:51'),
(9, 11, 20, '2024-12-03 07:28:51'),
(12, 12, 20, '2024-12-03 07:28:51'),
(13, 13, 20, '2024-12-03 07:28:51'),
(14, 14, 20, '2024-12-03 07:28:51'),
(15, 15, 20, '2024-12-03 07:28:51');

-- --------------------------------------------------------

--
-- Table structure for table `khuyen_mai`
--

CREATE TABLE `khuyen_mai` (
  `ma_khuyen_mai` int(11) NOT NULL,
  `ten_khuyen_mai` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `muc_giam` decimal(5,2) DEFAULT NULL,
  `ngay_bat_dau` date DEFAULT NULL,
  `ngay_ket_thuc` date DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khuyen_mai`
--

INSERT INTO `khuyen_mai` (`ma_khuyen_mai`, `ten_khuyen_mai`, `mo_ta`, `muc_giam`, `ngay_bat_dau`, `ngay_ket_thuc`, `ngay_tao`) VALUES
(1, 'Giảm giá cuối năm', 'Giảm 10% cho tất cả các dòng xe', 10.00, '2024-12-01', '2024-12-31', '2024-12-03 07:33:53');

-- --------------------------------------------------------

--
-- Table structure for table `lich_su_giao_dich`
--

CREATE TABLE `lich_su_giao_dich` (
  `ma_giao_dich` int(11) NOT NULL,
  `ma_don_hang` int(11) NOT NULL,
  `loai_thanh_toan` enum('STK','TienMat') NOT NULL,
  `trang_thai_giao_hang` enum('DangGiao','HoanThanh','DaHuy') NOT NULL,
  `thoi_gian_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lich_su_giao_dich`
--

INSERT INTO `lich_su_giao_dich` (`ma_giao_dich`, `ma_don_hang`, `loai_thanh_toan`, `trang_thai_giao_hang`, `thoi_gian_tao`) VALUES
(1, 1, 'STK', 'DangGiao', '2024-12-03 07:35:44'),
(2, 2, 'TienMat', 'HoanThanh', '2024-12-03 07:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `loai_xe`
--

CREATE TABLE `loai_xe` (
  `ma_loai_xe` int(11) NOT NULL,
  `loai_xe` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loai_xe`
--

INSERT INTO `loai_xe` (`ma_loai_xe`, `loai_xe`) VALUES
(1, 'Xe số'),
(2, 'Xe tay ga'),
(3, 'Xe côn tay'),
(4, 'Xe 50cc'),
(5, 'Xe phân khối lớn');

-- --------------------------------------------------------

--
-- Table structure for table `mau_san_pham`
--

CREATE TABLE `mau_san_pham` (
  `ma_hinh_anh` int(11) DEFAULT NULL,
  `ma_san_pham` int(11) DEFAULT NULL,
  `mau_sac` varchar(20) DEFAULT NULL,
  `anh_1` varchar(225) DEFAULT NULL,
  `anh_2` varchar(225) DEFAULT NULL,
  `anh_3` varchar(225) DEFAULT NULL,
  `anh_4` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mau_san_pham`
--

INSERT INTO `mau_san_pham` (`ma_hinh_anh`, `ma_san_pham`, `mau_sac`, `anh_1`, `anh_2`, `anh_3`, `anh_4`) VALUES
(1, 1, 'Xám đen', 'https://hondagiapbinhduong.com/wp-content/uploads/2023/09/bg-sh160-cao-cap-trang-den-350x205.jpg', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586212/3.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586212/0.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586212/7.png'),
(2, 2, 'Trắng', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586594/0.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586594/6.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586594/4.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586594/2.png'),
(3, 2, 'Đỏ đen', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586710/8.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586710/10.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586710/12.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729586710/14.png'),
(4, 2, 'Đen', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729589326/0.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729589326/6.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729589326/4.png', 'https://cdn.honda.com.vn/motorbike-versions/Image360/October2024/1729589326/2.png');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `ma_nguoi_dung` int(11) NOT NULL,
  `ten_dang_nhap` varchar(255) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `ho_ten` varchar(255) NOT NULL,
  `tuoi` int(11) DEFAULT NULL,
  `gioi_tinh` varchar(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` varchar(225) DEFAULT NULL,
  `vai_tro` enum('Admin','User') DEFAULT 'User',
  `trang_thai` enum('HoatDong','BiKhoa') DEFAULT 'HoatDong',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`ma_nguoi_dung`, `ten_dang_nhap`, `mat_khau`, `ho_ten`, `tuoi`, `gioi_tinh`, `email`, `so_dien_thoai`, `dia_chi`, `vai_tro`, `trang_thai`, `ngay_tao`) VALUES
(1, 'leductu', '123456', 'Lê Đức Tú', 20, 'Nam', 'leductu_t67@hus.edu.vn', '0965814070', 'Ha Noi', 'Admin', 'HoatDong', '2024-12-03 06:52:53'),
(2, 'levungocanh', '123456', 'Lê Vũ Ngọc Anh', 20, 'Nam', 'levungocanh_t67@hus.edu.vn', '0965814070', 'Vinh Phuc', 'Admin', 'HoatDong', '2024-12-03 06:52:53'),
(3, 'leductu1', '123456', 'Lê Đức Tú 1', 40, 'Nữ', 'letu19082004@gmail.com', '0965814070', 'Ha Noi', 'Admin', 'HoatDong', '2024-12-03 06:52:53'),
(4, 'leductu2', '123456', 'Lê Đức Tú 2', 18, 'Nam', 'ldt19082004@gmail.com', '0965814070', 'Ha Noi', 'Admin', 'HoatDong', '2024-12-03 06:52:53'),
(5, 'luongduythai', '123456', 'Lường Duy Thái', 17, 'Nữ', 'leductu19082004', '0965814070', 'Hoa Binh', 'User', 'HoatDong', '2024-12-03 06:52:53'),
(6, 'dohungdang', '123456', 'Đỗ Hùng Đăng', 30, 'Nam', 'leductu19082004', '0965814070', 'Ha Noi', 'User', 'HoatDong', '2024-12-03 06:52:53');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham`
--

CREATE TABLE `san_pham` (
  `ma_san_pham` int(11) NOT NULL,
  `ma_loai_xe` int(11) DEFAULT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `hang_xe` varchar(255) DEFAULT NULL,
  `gia` decimal(15,2) NOT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham`
--

INSERT INTO `san_pham` (`ma_san_pham`, `ma_loai_xe`, `ten_san_pham`, `hang_xe`, `gia`, `anh_dai_dien`, `ngay_tao`) VALUES
(1, 2, 'SH 160i_Bản thể thao', 'Honda', 106000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2024/01/7-4.png', '2024-12-03 07:23:03'),
(2, 2, 'SH 160i_Bản cao cấp', 'Honda', 104500000.00, 'https://xemayhoangcau.com/wp-content/uploads/2024/01/4-17.png', '2024-12-03 07:23:03'),
(3, 2, 'SH 160i_Bản đặc biệt', 'Honda', 104500000.00, 'https://xemayhoangcau.com/wp-content/uploads/2024/01/6-6.png', '2024-12-03 07:23:03'),
(4, 2, 'Honda Vision – Bản Đặc Biệt', 'Honda', 34900000.00, 'https://xemayhoangcau.com/wp-content/uploads/2024/01/3-23.png', '2024-12-03 07:23:03'),
(5, 1, 'Honda Wave RSX – Phiên Bản Đặc Biệt', 'Honda', 24500000.00, 'https://xemayhoangcau.com/wp-content/uploads/2024/01/3-23.png', '2024-12-03 07:23:03'),
(6, 2, 'Honda Air Blade 160 – Bản Đặc Biệt', 'Honda', 60000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2024/09/13.png', '2024-12-03 07:23:03'),
(7, 3, 'Honda Winner X – Bản Đặc Biệtt', 'Honda', 39000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/08/2-47.png', '2024-12-03 07:23:03'),
(8, 2, 'Honda Lead – Bản Cao Cấp', 'Honda', 42000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/08/2-48.png', '2024-12-03 07:23:03'),
(11, 3, 'Yamaha MT-03 2022 – Xanh Xám', 'Yamaha', 100000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/08/yamaha-mt-03-2022-xanh-xam-1.jpg', '2024-12-03 07:23:03'),
(12, 3, 'Yamaha Grande 2023 – Bản Giới Hạn', 'Yamaha', 35000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/10/1-39.png', '2024-12-03 07:23:03'),
(13, 3, 'Suzuki Satria 2022', 'Suzuki', 45000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/08/212-suzuki-satria-2022-trang-do-den-1.jpg', '2024-12-03 07:23:03'),
(14, 3, 'Kymco K Pipe 2022', 'Kymco', 23000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/08/258-kymco-k-pipe-2022-den-1.jpg', '2024-12-03 07:23:03'),
(15, 4, 'Sym Elite 50cc 2022', 'SYM', 23000000.00, 'https://xemayhoangcau.com/wp-content/uploads/2022/08/277-sym-elite-50cc-2022-do-1.jpg', '2024-12-03 07:23:03');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham_khuyen_mai`
--

CREATE TABLE `san_pham_khuyen_mai` (
  `ma_san_pham` int(11) NOT NULL,
  `ma_khuyen_mai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham_khuyen_mai`
--

INSERT INTO `san_pham_khuyen_mai` (`ma_san_pham`, `ma_khuyen_mai`) VALUES
(1, 1),
(2, 1),
(15, 1);

-- --------------------------------------------------------

--
-- Table structure for table `thong_so_ky_thuat`
--

CREATE TABLE `thong_so_ky_thuat` (
  `ma_thong_so` int(11) NOT NULL,
  `ma_san_pham` int(11) DEFAULT NULL,
  `khoi_luong` varchar(10) DEFAULT NULL,
  `DRC` varchar(20) DEFAULT NULL,
  `khoang_cach_truc_banh_xe` varchar(10) DEFAULT NULL,
  `do_cao_yen` varchar(10) DEFAULT NULL,
  `khoang_sang_gam_xe` varchar(10) DEFAULT NULL,
  `dung_tich_binh_xang` varchar(10) DEFAULT NULL,
  `kich_thuoc_lop_truoc` varchar(50) DEFAULT NULL,
  `kich_thuoc_lop_sau` varchar(50) DEFAULT NULL,
  `phuoc_truoc` varchar(50) DEFAULT NULL,
  `phuoc_sau` varchar(50) DEFAULT NULL,
  `loai_dong_co` varchar(50) DEFAULT NULL,
  `cong_suat_toi_da` varchar(50) DEFAULT NULL,
  `dung_tich_nhot_may` varchar(50) DEFAULT NULL,
  `muc_tieu_thu_nhien_lieu` varchar(50) DEFAULT NULL,
  `loai_truyen_dong` varchar(50) DEFAULT NULL,
  `he_thong_khoi_dong` varchar(30) DEFAULT NULL,
  `moment_cuc_dai` varchar(30) DEFAULT NULL,
  `dung_tich_xylanh` varchar(10) DEFAULT NULL,
  `duong_kinh_x_hanh_trinh_pitong` varchar(20) DEFAULT NULL,
  `ty_so_nen` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thong_so_ky_thuat`
--

INSERT INTO `thong_so_ky_thuat` (`ma_thong_so`, `ma_san_pham`, `khoi_luong`, `DRC`, `khoang_cach_truc_banh_xe`, `do_cao_yen`, `khoang_sang_gam_xe`, `dung_tich_binh_xang`, `kich_thuoc_lop_truoc`, `kich_thuoc_lop_sau`, `phuoc_truoc`, `phuoc_sau`, `loai_dong_co`, `cong_suat_toi_da`, `dung_tich_nhot_may`, `muc_tieu_thu_nhien_lieu`, `loai_truyen_dong`, `he_thong_khoi_dong`, `moment_cuc_dai`, `dung_tich_xylanh`, `duong_kinh_x_hanh_trinh_pitong`, `ty_so_nen`) VALUES
(1, 1, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(2, 2, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(3, 3, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`ma_chi_tiet`),
  ADD KEY `ma_don_hang` (`ma_don_hang`),
  ADD KEY `ma_san_pham` (`ma_san_pham`);

--
-- Indexes for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD PRIMARY KEY (`ma_danh_gia`),
  ADD KEY `ma_san_pham` (`ma_san_pham`),
  ADD KEY `ma_nguoi_dung` (`ma_nguoi_dung`);

--
-- Indexes for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`ma_don_hang`),
  ADD KEY `ma_nguoi_dung` (`ma_nguoi_dung`);

--
-- Indexes for table `kho_hang`
--
ALTER TABLE `kho_hang`
  ADD PRIMARY KEY (`ma_kho`),
  ADD KEY `ma_san_pham` (`ma_san_pham`);

--
-- Indexes for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  ADD PRIMARY KEY (`ma_khuyen_mai`);

--
-- Indexes for table `lich_su_giao_dich`
--
ALTER TABLE `lich_su_giao_dich`
  ADD PRIMARY KEY (`ma_giao_dich`),
  ADD KEY `ma_don_hang` (`ma_don_hang`);

--
-- Indexes for table `loai_xe`
--
ALTER TABLE `loai_xe`
  ADD PRIMARY KEY (`ma_loai_xe`);

--
-- Indexes for table `mau_san_pham`
--
ALTER TABLE `mau_san_pham`
  ADD KEY `ma_san_pham` (`ma_san_pham`);

--
-- Indexes for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`ma_nguoi_dung`);

--
-- Indexes for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`ma_san_pham`),
  ADD KEY `ma_loai_xe` (`ma_loai_xe`);

--
-- Indexes for table `san_pham_khuyen_mai`
--
ALTER TABLE `san_pham_khuyen_mai`
  ADD PRIMARY KEY (`ma_san_pham`,`ma_khuyen_mai`),
  ADD KEY `ma_khuyen_mai` (`ma_khuyen_mai`);

--
-- Indexes for table `thong_so_ky_thuat`
--
ALTER TABLE `thong_so_ky_thuat`
  ADD PRIMARY KEY (`ma_thong_so`),
  ADD KEY `ma_san_pham` (`ma_san_pham`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `ma_chi_tiet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kho_hang`
--
ALTER TABLE `kho_hang`
  MODIFY `ma_kho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  MODIFY `ma_khuyen_mai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lich_su_giao_dich`
--
ALTER TABLE `lich_su_giao_dich`
  MODIFY `ma_giao_dich` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loai_xe`
--
ALTER TABLE `loai_xe`
  MODIFY `ma_loai_xe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `ma_nguoi_dung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `ma_san_pham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `thong_so_ky_thuat`
--
ALTER TABLE `thong_so_ky_thuat`
  MODIFY `ma_thong_so` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`),
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`);

--
-- Constraints for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`),
  ADD CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`);

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`);

--
-- Constraints for table `kho_hang`
--
ALTER TABLE `kho_hang`
  ADD CONSTRAINT `kho_hang_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`) ON DELETE CASCADE;

--
-- Constraints for table `lich_su_giao_dich`
--
ALTER TABLE `lich_su_giao_dich`
  ADD CONSTRAINT `lich_su_giao_dich_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE;

--
-- Constraints for table `mau_san_pham`
--
ALTER TABLE `mau_san_pham`
  ADD CONSTRAINT `mau_san_pham_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`);

--
-- Constraints for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`ma_loai_xe`) REFERENCES `loai_xe` (`ma_loai_xe`);

--
-- Constraints for table `san_pham_khuyen_mai`
--
ALTER TABLE `san_pham_khuyen_mai`
  ADD CONSTRAINT `san_pham_khuyen_mai_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`),
  ADD CONSTRAINT `san_pham_khuyen_mai_ibfk_2` FOREIGN KEY (`ma_khuyen_mai`) REFERENCES `khuyen_mai` (`ma_khuyen_mai`);

--
-- Constraints for table `thong_so_ky_thuat`
--
ALTER TABLE `thong_so_ky_thuat`
  ADD CONSTRAINT `thong_so_ky_thuat_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
