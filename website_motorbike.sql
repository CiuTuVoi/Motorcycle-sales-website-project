-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2025 at 09:36 AM
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
-- Database: `website_motorbike_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `ma_danh_gia` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
  `ma_nguoi_dung` int(11) NOT NULL,
  `so_sao` int(11) DEFAULT NULL,
  `nhan_xet` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`ma_danh_gia`, `ma_san_pham`, `ma_nguoi_dung`, `so_sao`, `nhan_xet`, `ngay_tao`) VALUES
(1, 2, 4, 5, 'Siêu Cấp Đẹp Nhá!', '2025-01-05 06:55:08'),
(2, 2, 5, 4, 'Giá Hơi bị Đắt', '2025-01-05 06:55:08'),
(3, 3, 4, 5, 'Mua 2 con luôn', '2025-01-05 06:55:08');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `ma_don_hang` int(11) NOT NULL,
  `ma_nguoi_dung` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
  `so_luong` int(11) DEFAULT NULL,
  `don_gia` decimal(15,2) DEFAULT NULL,
  `tong_tien` decimal(15,2) NOT NULL,
  `trang_thai` enum('Dang_xu_ly','Hoan_thanh','Da_huy') DEFAULT 'Dang_xu_ly',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`ma_don_hang`, `ma_nguoi_dung`, `ma_san_pham`, `so_luong`, `don_gia`, `tong_tien`, `trang_thai`, `ngay_tao`) VALUES
(1, 4, 2, 1, 8344727.00, 7093018.00, 'Hoan_thanh', '2025-01-05 06:59:34'),
(2, 4, 3, 2, 73921091.00, 118273746.00, 'Hoan_thanh', '2025-01-05 07:01:19'),
(3, 5, 2, 1, 8344727.00, 7093018.00, 'Dang_xu_ly', '2025-01-05 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `kho_hang`
--

CREATE TABLE `kho_hang` (
  `ma_san_pham` int(11) NOT NULL,
  `so_luong` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kho_hang`
--

INSERT INTO `kho_hang` (`ma_san_pham`, `so_luong`) VALUES
(1, 100),
(2, 100),
(3, 100),
(4, 100),
(5, 100),
(6, 100),
(7, 100),
(8, 100),
(9, 100),
(10, 100),
(11, 100),
(12, 100),
(13, 100),
(14, 100),
(15, 100),
(16, 100),
(17, 100),
(18, 100),
(19, 100),
(20, 100),
(21, 100),
(22, 100),
(23, 100),
(24, 100),
(25, 100),
(26, 100),
(27, 100),
(28, 100),
(29, 100),
(30, 100),
(31, 100),
(32, 100),
(33, 100),
(34, 100),
(35, 100),
(36, 100),
(37, 100),
(38, 100),
(39, 100),
(40, 100),
(41, 100),
(42, 100),
(43, 100),
(44, 100),
(45, 100),
(46, 100),
(47, 100),
(48, 100);

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
(1, 'Giảm giá Tết Nguyên Đán', 'Khuyến mãi đặc biệt nhân dịp Tết Nguyên Đán, giảm giá 10% toàn bộ xe.', 10.00, '2025-01-10', '2025-01-31', '2025-01-05 06:48:46'),
(2, 'Khuyến mãi hè 2025', 'Giảm giá mùa hè cho các dòng xe phân khối lớn.', 15.00, '2025-06-01', '2025-06-30', '2025-01-05 06:48:46'),
(3, 'Giảm giá khai trương', 'Ưu đãi khai trương cửa hàng mới, giảm 20% cho các mẫu xe tay ga.', 20.00, '2025-02-01', '2025-02-15', '2025-01-05 06:48:46'),
(4, 'Khuyến mãi Black Friday', 'Giảm giá lớn Black Friday, áp dụng cho các dòng xe thể thao.', 25.00, '2025-11-25', '2025-11-30', '2025-01-05 06:48:46'),
(5, 'Ưu đãi khách hàng thân thiết', 'Chương trình tri ân khách hàng thân thiết, giảm giá 5% khi mua lần thứ hai.', 5.00, '2025-03-01', '2025-03-31', '2025-01-05 06:48:46'),
(6, 'Siêu giảm giá cuối năm', 'Khuyến mãi giảm giá cuối năm lên đến 30% cho xe phân khối lớn.', 30.00, '2025-12-01', '2025-12-31', '2025-01-05 06:48:46'),
(7, 'Giảm giá sinh nhật', 'Ưu đãi giảm giá 12% nhân dịp sinh nhật cửa hàng.', 12.00, '2025-07-01', '2025-07-15', '2025-01-05 06:48:46'),
(8, 'Khuyến mãi tháng 10', 'Giảm giá 8% toàn bộ sản phẩm trong tháng 10.', 8.00, '2025-10-01', '2025-10-31', '2025-01-05 06:48:46'),
(9, 'Flash Sale 50%', 'Khuyến mãi giảm giá 50% chỉ trong 24 giờ!', 50.00, '2025-05-15', '2025-05-15', '2025-01-05 06:48:46'),
(10, 'Ưu đãi mua xe trả góp', 'Giảm giá 10% khi mua xe trả góp với lãi suất 0%.', 10.00, '2025-08-01', '2025-08-31', '2025-01-05 06:48:46');

-- --------------------------------------------------------

--
-- Table structure for table `lich_su_giao_dich`
--

CREATE TABLE `lich_su_giao_dich` (
  `ma_giao_dich` int(11) NOT NULL,
  `ma_don_hang` int(11) NOT NULL,
  `loai_thanh_toan` enum('STK','TienMat') NOT NULL,
  `tong_tien` int(11) DEFAULT NULL,
  `trang_thai_giao_hang` enum('DangGiao','HoanThanh','DaHuy') NOT NULL,
  `thoi_gian_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lich_su_giao_dich`
--

INSERT INTO `lich_su_giao_dich` (`ma_giao_dich`, `ma_don_hang`, `loai_thanh_toan`, `tong_tien`, `trang_thai_giao_hang`, `thoi_gian_tao`) VALUES
(1, 1, 'STK', 7093018, 'HoanThanh', '2025-01-05 07:05:53'),
(2, 2, 'STK', 73921091, 'DangGiao', '2025-01-05 07:05:53');

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
(5, 'Xe phân khối lớn'),
(6, 'Xe Điện');

-- --------------------------------------------------------

--
-- Table structure for table `mau_san_pham`
--

CREATE TABLE `mau_san_pham` (
  `ma_hinh_anh` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
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
(1, 1, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(2, 1, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/7%20(1).png?raw=true'),
(3, 2, 'Xám Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/7.png?raw=true'),
(4, 2, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en/7%20(1).png?raw=true'),
(5, 3, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(6, 3, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/7.png?raw=true'),
(7, 4, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/7.png?raw=true'),
(8, 5, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/3%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(9, 5, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/15.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/13.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/7%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/11.png?raw=true'),
(10, 6, 'Xám Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/7.png?raw=true'),
(11, 7, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(12, 7, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/7.png?raw=true'),
(13, 7, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(14, 8, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/7.png?raw=true'),
(15, 9, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(16, 10, 'Xanh Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/7.png?raw=true'),
(17, 10, 'Xám Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/7.png?raw=true'),
(18, 11, 'Xám Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en/7%20(1).png?raw=true'),
(19, 12, 'Bạc Xanh Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/7.png?raw=true'),
(20, 12, 'Bạc Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20%C4%90%E1%BB%8F%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(21, 13, 'Xám Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(22, 14, 'Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(23, 14, 'Đỏ Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(24, 15, 'Đen Vàng', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20V%C3%A0ng/12.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20V%C3%A0ng/15.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20V%C3%A0ng/2.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20V%C3%A0ng/7.png?raw=true'),
(25, 16, 'Bạc Xanh Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/7.png?raw=true'),
(26, 17, 'Xám Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(27, 18, 'Bạc Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/7.png?raw=true'),
(28, 19, 'Xanh Đen Vàng', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20V%C3%A0ng/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20V%C3%A0ng/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20V%C3%A0ng/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20V%C3%A0ng/7.png?raw=true'),
(29, 20, 'Xanh Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/7.png?raw=true'),
(30, 21, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/7.png?raw=true'),
(31, 21, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/3%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(32, 22, 'Xanh Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Cao%20C%E1%BA%A5p/Xanh%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Cao%20C%E1%BA%A5p/Xanh%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Cao%20C%E1%BA%A5p/Xanh%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Cao%20C%E1%BA%A5p/Xanh%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(33, 23, 'Xám Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(34, 24, 'Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(35, 25, 'Đỏ Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(36, 26, 'Xánh Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/Xanh%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/Xanh%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/Xanh%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/Xanh%20%C4%90en/7.png?raw=true'),
(37, 26, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(38, 27, 'Vàng Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/V%C3%A0ng%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/V%C3%A0ng%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/V%C3%A0ng%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/V%C3%A0ng%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(39, 27, 'Xanh Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh%20%C4%90en%20B%E1%BA%A1c/7%20(1).png?raw=true'),
(40, 28, 'Xám Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/3%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/7.png?raw=true'),
(41, 28, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/%C4%90en/7.png?raw=true'),
(42, 29, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(43, 30, 'Nâu Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/N%C3%A2u%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/N%C3%A2u%20%C4%90en/3%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/N%C3%A2u%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/N%C3%A2u%20%C4%90en/7.png?raw=true'),
(44, 31, 'Trắng', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng/7.png?raw=true'),
(45, 31, 'Xanh', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh/7.png?raw=true'),
(46, 31, 'Đỏ', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F/7.png?raw=true'),
(47, 32, 'Đen Nhám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20Nh%C3%A1m/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20Nh%C3%A1m/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20Nh%C3%A1m/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20Nh%C3%A1m/7.png?raw=true'),
(48, 33, 'Xanh', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh/7%20(1).png?raw=true'),
(49, 33, 'Xám Trắng', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m%20Tr%E1%BA%AFng/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m%20Tr%E1%BA%AFng/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m%20Tr%E1%BA%AFng/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m%20Tr%E1%BA%AFng/7.png?raw=true'),
(50, 33, 'Xám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/X%C3%A1m/7.png?raw=true'),
(51, 34, 'Trắng Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Tr%E1%BA%AFng%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Tr%E1%BA%AFng%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Tr%E1%BA%AFng%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Tr%E1%BA%AFng%20%C4%90en%20B%E1%BA%A1c/7%20(1).png?raw=true'),
(52, 34, 'Xanh Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Xanh%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Xanh%20%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Xanh%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Xanh%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(53, 34, 'Đỏ Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/3%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(54, 35, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3j6CEz39256ttsRfjbF9.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3j6CEz39256ttsRfjbF9.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3j6CEz39256ttsRfjbF9.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3j6CEz39256ttsRfjbF9.png?raw=true'),
(55, 35, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/7%20(1).png?raw=true'),
(56, 36, 'Đen Bạc', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20B%E1%BA%A1c/1%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20B%E1%BA%A1c/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20B%E1%BA%A1c/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20B%E1%BA%A1c/7.png?raw=true'),
(57, 37, 'Xanh Dương', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20D%C6%B0%C6%A1ng/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20D%C6%B0%C6%A1ng/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20D%C6%B0%C6%A1ng/4.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20D%C6%B0%C6%A1ng/6.png?raw=true'),
(58, 37, 'Xanh Nhám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20X%C3%A1m/PVQlDvkZorRuHGRDA0Rs.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20X%C3%A1m/PVQlDvkZorRuHGRDA0Rs.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20X%C3%A1m/PVQlDvkZorRuHGRDA0Rs.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20X%C3%A1m/PVQlDvkZorRuHGRDA0Rs.png?raw=true'),
(59, 38, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/4mvfY4O7TXBSDullbfAZ.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/4mvfY4O7TXBSDullbfAZ.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/4mvfY4O7TXBSDullbfAZ.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/4mvfY4O7TXBSDullbfAZ.png?raw=true'),
(60, 39, 'Đỏ Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20Tr%E1%BA%AFng%20%C4%90en/7.png?raw=true'),
(61, 40, 'Bạc Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/7.png?raw=true'),
(62, 40, 'Trắng Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/7%20(1).png?raw=true'),
(63, 40, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(64, 41, 'Bạc Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/B%E1%BA%A1c%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/B%E1%BA%A1c%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/B%E1%BA%A1c%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/B%E1%BA%A1c%20%C4%90en/7%20(1).png?raw=true'),
(65, 41, 'Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/7.png?raw=true'),
(66, 41, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en/7.png?raw=true'),
(67, 42, 'Trắng Xám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20X%C3%A1m/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20X%C3%A1m/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20X%C3%A1m/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20X%C3%A1m/6.png?raw=true'),
(68, 42, 'Đen Xám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90en%20X%C3%A1m/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90en%20X%C3%A1m/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90en%20X%C3%A1m/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90en%20X%C3%A1m/6.png?raw=true'),
(69, 42, 'Đỏ Xám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20X%C3%A1m/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20X%C3%A1m/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20X%C3%A1m/5%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20X%C3%A1m/5%20(1).png?raw=true'),
(70, 43, 'Xanh', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/Xanh/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/Xanh/3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/Xanh/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/Xanh/6.png?raw=true');
INSERT INTO `mau_san_pham` (`ma_hinh_anh`, `ma_san_pham`, `mau_sac`, `anh_1`, `anh_2`, `anh_3`, `anh_4`) VALUES
(71, 43, 'Xám', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/X%C3%A1m/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/X%C3%A1m/3%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/X%C3%A1m/5.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Th%E1%BB%83%20Thao/X%C3%A1m/7.png?raw=true'),
(72, 44, 'Bạc Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/B%E1%BA%A1c%20%C4%90en/0.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/B%E1%BA%A1c%20%C4%90en/0.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/B%E1%BA%A1c%20%C4%90en/0.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/B%E1%BA%A1c%20%C4%90en/0.png?raw=true'),
(73, 44, 'Đỏ Đen', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/%C4%90%E1%BB%8F%20%C4%90en/0%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/%C4%90%E1%BB%8F%20%C4%90en/0%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/%C4%90%E1%BB%8F%20%C4%90en/0%20(1).png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/%C4%90%E1%BB%8F%20%C4%90en/0%20(1).png?raw=true'),
(74, 45, 'Đỏ Xanh Trắng', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/CBR1000RR-R%20Fireblade%20SP%202024/%C4%90%E1%BB%8F%20Xanh%20Tr%E1%BA%AFng/1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/CBR1000RR-R%20Fireblade%20SP%202024/%C4%90%E1%BB%8F%20Xanh%20Tr%E1%BA%AFng/19.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/CBR1000RR-R%20Fireblade%20SP%202024/%C4%90%E1%BB%8F%20Xanh%20Tr%E1%BA%AFng/19.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/CBR1000RR-R%20Fireblade%20SP%202024/%C4%90%E1%BB%8F%20Xanh%20Tr%E1%BA%AFng/9.png?raw=true'),
(75, 46, 'Xanh Đen Mờ', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20M%E1%BB%9D/11.jpg?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20M%E1%BB%9D/12.jpg?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20M%E1%BB%9D/8.jpg?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20M%E1%BB%9D/edit_fsg.jpg?raw=true'),
(76, 46, 'Xám Đen Mờ', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en%20M%E1%BB%9D/sym_2304247283_1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en%20M%E1%BB%9D/sym_2304247302_1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en%20M%E1%BB%9D/sym_2304247309_1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en%20M%E1%BB%9D/sym_2304247314_1.png?raw=true'),
(77, 46, 'Đen Mờ', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20M%E1%BB%9D/1_1gsvb.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20M%E1%BB%9D/7_1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20M%E1%BB%9D/7_1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20M%E1%BB%9D/7_1.png?raw=true'),
(78, 46, 'Đỏ', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F/dsf.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F/h_tg.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F/h_tg.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F/h_tg.png?raw=true'),
(79, 47, 'Đỏ Đen Trắng', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Suzuki/Straria%20F150/%C4%90%E1%BB%8F%20%C4%90en%20Tr%E1%BA%AFng/Satria_360_Image_PC_1.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Suzuki/Straria%20F150/%C4%90%E1%BB%8F%20%C4%90en%20Tr%E1%BA%AFng/Satria_360_Image_PC_2.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Suzuki/Straria%20F150/%C4%90%E1%BB%8F%20%C4%90en%20Tr%E1%BA%AFng/Satria_360_Image_PC_3.png?raw=true', 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Suzuki/Straria%20F150/%C4%90%E1%BB%8F%20%C4%90en%20Tr%E1%BA%AFng/Satria_360_Image_PC_5.png?raw=true'),
(80, 48, 'Trắng', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng/Exciter-155-White-smartkey-002-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng/Exciter-155-White-smartkey-004-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng/Exciter-155-White-smartkey-006-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng/Exciter-155-White-smartkey-008-1024x860.webp'),
(81, 48, 'Vàng', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/V%C3%A0ng/Exciter-155-RC-DLX-Reddish-Yellow-002-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/V%C3%A0ng/Exciter-155-RC-DLX-Reddish-Yellow-004-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/V%C3%A0ng/Exciter-155-RC-DLX-Reddish-Yellow-006-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/V%C3%A0ng/Exciter-155-RC-DLX-Reddish-Yellow-008-1024x860.webp'),
(82, 48, 'Đen Bạc', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90en%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Black-002-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90en%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Black-004-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90en%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Black-006-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90en%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Black-008-1024x860.webp'),
(83, 48, 'Đỏ Bạc', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Red-002-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Red-004-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Red-006-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20B%E1%BA%A1c/Exciter-155-RC-DLX-Mat-Red-008-1024x860.webp'),
(84, 48, 'Đỏ Đen', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/Exciter-155-Mat-Red-smartkey-002-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/Exciter-155-Mat-Red-smartkey-004-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/Exciter-155-Mat-Red-smartkey-006-1024x860.webp', 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/%C4%90%E1%BB%8F%20%C4%90en/Exciter-155-Mat-Red-smartkey-008-1024x860.webp');

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
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `refresh_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`ma_nguoi_dung`, `ten_dang_nhap`, `mat_khau`, `ho_ten`, `tuoi`, `gioi_tinh`, `email`, `so_dien_thoai`, `dia_chi`, `vai_tro`, `trang_thai`, `ngay_tao`, `refresh_token`) VALUES
(1, 'leductu_t67@hus.edu.vn', '123456', 'Lê Đức Tú', 20, 'Nam', 'leductu_t67@hus.edu.vn', '0965814070', 'Ha Noi', 'Admin', 'HoatDong', '2024-12-03 06:52:53', NULL),
(2, 'levungocanh_t67@hus.edu.vn', '123456', 'Lê Vũ Ngọc Anh', 20, 'Nam', 'levungocanh_t67@hus.edu.vn', '0965814070', 'Vinh Phuc', 'Admin', 'HoatDong', '2024-12-03 06:52:53', NULL),
(3, 'letu19082004@gmail.com', '123456', 'Lê Đức Tú 1', 40, 'Nữ', 'letu19082004@gmail.com', '0965814070', 'Ha Noi', 'Admin', 'HoatDong', '2024-12-03 06:52:53', NULL),
(4, 'ldt19082004@gmail.com', '123456', 'Lê Đức Tú 2', 18, 'Nam', 'ldt19082004@gmail.com', '0965814070', 'Ha Noi', 'Admin', 'HoatDong', '2024-12-03 06:52:53', NULL),
(5, 'luongduythai_t67@hus.edu.vn', '123456', 'Lường Duy Thái', 17, 'Nữ', 'luongduythai_t67@hus.edu.vn', '0965814070', 'Hoa Binh', 'User', 'HoatDong', '2024-12-03 06:52:53', NULL),
(6, 'dohungdang_t67@hus.edu.vn', '123456', 'Đỗ Hùng Đăng', 30, 'Nam', 'dohungdang_t67@hus.edu.vn', '0965814070', 'Ha Noi', 'User', 'HoatDong', '2024-12-03 06:52:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `phan_hoi`
--

CREATE TABLE `phan_hoi` (
  `ma_phan_hoi` int(11) NOT NULL,
  `ma_danh_gia` int(11) NOT NULL,
  `ma_nguoi_dung` int(11) NOT NULL,
  `noi_dung` text DEFAULT NULL,
  `ngay_tao` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `phan_hoi`
--

INSERT INTO `phan_hoi` (`ma_phan_hoi`, `ma_danh_gia`, `ma_nguoi_dung`, `noi_dung`, `ngay_tao`) VALUES
(1, 1, 5, 'Tốt không ạ', '2025-01-05 14:07:43'),
(2, 1, 4, 'Cũng Được', '2025-01-05 14:07:43');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham`
--

CREATE TABLE `san_pham` (
  `ma_san_pham` int(11) NOT NULL,
  `ma_loai_xe` int(11) NOT NULL,
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
(1, 2, 'SH125i Phiên bản Cao Cấp', 'Honda', 81775637.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-03 19:35:13'),
(2, 2, 'SH125i Phiên bản Thể Thao', 'Honda', 8344727.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1.png?raw=true', '2025-01-03 19:37:54'),
(3, 2, 'SH125i Phiên bản Tiêu Chuẩn', 'Honda', 73921091.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-03 19:38:54'),
(4, 2, 'SH125i Phiên bản Đặc Biệt', 'Honda', 82953818.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20125i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1.png?raw=true', '2025-01-03 19:41:42'),
(5, 2, 'SH160i Phiên bản Cao Cấp', 'Honda', 100490000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-03 19:43:19'),
(6, 2, 'SH160i Phiên bản Thể Thao', 'Honda', 102190000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1%20(1).png?raw=true', '2025-01-03 19:54:02'),
(7, 2, 'SH160i Phiên bản Tiêu Chuẩn', 'Honda', 92490000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-03 19:55:16'),
(8, 2, 'SH160i Phiên bản Đặc Biệt', 'Honda', 102190000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20160i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1.png?raw=true', '2025-01-03 19:56:27'),
(9, 2, 'SH350i Cao Cấp', 'Honda', 151190000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-03 19:58:09'),
(10, 2, 'SH350i Thể Thao', 'Honda', 152690000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/1.png?raw=true', '2025-01-03 19:59:12'),
(11, 2, 'SH350i Đặc Biệt', 'Honda', 152190000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/SH/SH%20350i%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/X%C3%A1m%20%C4%90en/1.png?raw=true', '2025-01-03 20:00:17'),
(12, 2, 'Air Blade 125 Cao Cấp', 'Honda', 42502909.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/1.png?raw=true', '2025-01-03 20:06:48'),
(13, 2, 'Air Blade 125 Thể Thao', 'Honda', 43618109.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', '2025-01-03 20:06:48'),
(14, 2, 'Air Blade 125 Tiêu Chuẩn', 'Honda', 42012000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-03 20:06:48'),
(15, 2, 'Air Blade 125 Đặc Biệt', 'Honda', 43190182.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20V%C3%A0ng/12.png?raw=true', '2025-01-03 20:06:48'),
(16, 2, 'Air Blade 160 Cao Cấp', 'Honda', 57190000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Cao%20C%E1%BA%A5p/B%E1%BA%A1c%20Xanh%20%C4%90en/1.png?raw=true', '2025-01-03 20:06:48'),
(17, 2, 'Air Blade 160 Thể Thao', 'Honda', 58390000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90%E1%BB%8F%20%C4%90en/1.png?raw=true', '2025-01-03 20:06:48'),
(18, 2, 'Air Blade 160 Tiêu  Chuẩn', 'Honda', 56690000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/1.png?raw=true', '2025-01-03 20:06:48'),
(19, 2, 'Air Blade 160 Đặc Biệt', 'Honda', 57890000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Air%20Blade/160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20V%C3%A0ng/1.png?raw=true', '2025-01-03 20:06:48'),
(20, 2, 'Vario 125 Thể Thao', 'Honda', 41226545.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20Th%E1%BB%83%20Thao/Xanh%20%C4%90en/1.png?raw=true', '2025-01-04 16:54:32'),
(21, 2, 'Vario 125 Đặc Biệt', 'Honda', 40735637.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20125%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/1%20(1).png?raw=true', '2025-01-04 16:55:22'),
(22, 2, 'Vario 160 Cao Cấp', 'Honda', 52490000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Cao%20C%E1%BA%A5p/Xanh%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-04 16:56:42'),
(23, 2, 'Vario 160 Thể Thao', 'Honda', 56490000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-04 16:57:33'),
(24, 2, 'Vario 160 Tiêu Chuẩn', 'Honda', 51990000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-04 16:58:11'),
(25, 2, 'Vario 160 Đặc Biệt', 'Honda', 55990000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vario/Vario%20160%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90%E1%BB%8F%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-04 16:59:20'),
(26, 2, 'Vison Cao Cấp', 'Honda', 32979273.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Cao%20C%E1%BA%A5p/Xanh%20%C4%90en/1.png?raw=true', '2025-01-04 17:01:02'),
(27, 2, 'Vison Cổ Điển', 'Honda', 36612000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/C%E1%BB%95%20%C4%90i%E1%BB%83n/V%C3%A0ng%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-04 17:01:56'),
(28, 2, 'Vison Thể Thao', 'Honda', 36612000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Th%E1%BB%83%20Thao/X%C3%A1m%20%C4%90en/1.png?raw=true', '2025-01-04 17:02:44'),
(29, 2, 'Vison Tiêu Chuẩn', 'Honda', 31310182.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-04 17:03:35'),
(30, 2, 'Vison Đặc Biệt', 'Honda', 34353818.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Vison/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/N%C3%A2u%20%C4%90en/1.png?raw=true', '2025-01-04 17:04:43'),
(31, 1, 'Wave Alpha 110 Tiêu Chuẩn', 'Honda', 17859273.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20Ti%C3%AAu%20Chu%E1%BA%A9n/Tr%E1%BA%AFng/1.png?raw=true', '2025-01-04 17:07:30'),
(32, 1, 'Wave Alpha 110 Đặc Biệt', 'Honda', 18742909.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/110%20%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20Nh%C3%A1m/1.png?raw=true', '2025-01-04 17:09:26'),
(33, 1, 'Wave Alpha Phiên Bản Cổ Điển', 'Honda', 18939273.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20Alpha/C%E1%BB%95%20%C4%90i%E1%BB%83n/Xanh/1.png?raw=true', '2025-01-04 17:10:39'),
(34, 1, 'Wave RSX Thể Thao', 'Honda', 25566545.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Th%E1%BB%83%20Thao/Tr%E1%BA%AFng%20%C4%90en%20B%E1%BA%A1c/1.png?raw=true', '2025-01-04 17:13:14'),
(35, 1, 'Wave RSX Tiêu Chuẩn', 'Honda', 22032000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/Ti%C3%AAu%20Chu%E1%BA%A9n/%C4%90en/3j6CEz39256ttsRfjbF9.png?raw=true', '2025-01-04 17:14:20'),
(36, 1, 'Wave RSX Đặc Biệt', 'Honda', 23602909.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Wave%20RSX/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en%20B%E1%BA%A1c/1%20(1).png?raw=true', '2025-01-04 17:15:05'),
(37, 1, 'Super Cup Tiêu Chuẩn', 'Honda', 86292000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/Ti%C3%AAu%20Chu%E1%BA%A9n/Xanh%20D%C6%B0%C6%A1ng/1.png?raw=true', '2025-01-04 17:16:59'),
(38, 1, 'Super Cup Đặc Biệt', 'Honda', 87273818.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Super%20Cup/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/%C4%90en/4mvfY4O7TXBSDullbfAZ.png?raw=true', '2025-01-04 17:17:49'),
(39, 3, 'Winner X Thể Thao', 'Honda', 50560000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Th%E1%BB%83%20Thao/%C4%90%E1%BB%8F%20Tr%E1%BA%AFng%20%C4%90en/1.png?raw=true', '2025-01-04 17:20:20'),
(40, 3, 'Winner X Tiêu Chuẩn', 'Honda', 46160000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/Ti%C3%AAu%20Chu%E1%BA%A9n/B%E1%BA%A1c%20%C4%90en/1.png?raw=true', '2025-01-04 17:21:13'),
(41, 3, 'Winner X Đặc Biệt', 'Honda', 50060000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Winer%20X/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/B%E1%BA%A1c%20%C4%90en/1.png?raw=true', '2025-01-04 17:22:05'),
(42, 6, 'ICON e Cao Cấp', 'Honda', 29000000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng%20X%C3%A1m/1.png?raw=true', '2025-01-04 17:28:28'),
(43, 6, 'ICON e Đặc Biệt', 'Honda', 29000000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Icon%20e/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/B%E1%BA%A1c%20Nh%C3%A1m/1.png?raw=true', '2025-01-04 17:29:53'),
(44, 5, 'Gold Wing', 'Honda', 1231500000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/Gold%20Wing%202024/B%E1%BA%A1c%20%C4%90en/0.png?raw=true', '2025-01-04 17:32:20'),
(45, 5, 'CBR1000RR-R Fireblade SP 2024', 'Honda', 1050500000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Honda/CBR1000RR-R%20Fireblade%20SP%202024/%C4%90%E1%BB%8F%20Xanh%20Tr%E1%BA%AFng/1.png?raw=true', '2025-01-04 17:33:31'),
(46, 2, 'Elite 50 Phiên Bản Đặc Biệt', 'SYM', 23600000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/SYM/Elite/%C4%90%E1%BA%B7c%20Bi%E1%BB%87t/Xanh%20%C4%90en%20M%E1%BB%9D/8.jpg?raw=true', '2025-01-04 17:37:24'),
(47, 3, 'Suzuki Straria 150', 'Suzuki', 48490000.00, 'https://github.com/CiuTuVoi/Motorcycle-sales-website-project/blob/Leader/%E1%BA%A2nh/Suzuki/Straria%20F150/%C4%90%E1%BB%8F%20%C4%90en%20Tr%E1%BA%AFng/Satria_360_Image_PC_3.png?raw=true', '2025-01-04 17:39:28'),
(48, 3, 'EXCITER 155 Phiên Bản Cao Cấp', 'Yamaha', 50600000.00, 'https://raw.githubusercontent.com/CiuTuVoi/Motorcycle-sales-website-project/refs/heads/Leader/%E1%BA%A2nh/Yamaha/Exciter%20155/Cao%20C%E1%BA%A5p/Tr%E1%BA%AFng/Exciter-155-White-smartkey-002-1024x860.webp', '2025-01-04 17:41:57');

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
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `gio_hang`
--

CREATE TABLE `gio_hang` (
    `ma_gio_hang` INT AUTO_INCREMENT PRIMARY KEY,
    `ma_nguoi_dung` INT NOT NULL,
    `ma_san_pham` INT NOT NULL,
    `so_luong` INT DEFAULT 1,
    `ngay_them` timestamp NOT NULL DEFAULT current_timestamp(),
    FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(ma_nguoi_dung),
    FOREIGN KEY (ma_san_pham) REFERENCES san_pham(ma_san_pham)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham_khuyen_mai`
--

INSERT INTO `gio_hang` (`ma_nguoi_dung`, `ma_san_pham`, `so_luong`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(4, 10, 1);


-- --------------------------------------------------------

--
-- Table structure for table `thong_bao`
--

CREATE TABLE thong_bao (
  ma_thong_bao int(11) NOT NULL,
  ma_nguoi_dung int(11) NOT NULL,
  noi_dung text DEFAULT NULL,
  da_doc enum('đã đọc','chưa đọc') DEFAULT 'chưa đọc',
  loai_thong_bao enum('Riengtu', 'Khuyenmai') NOT NULL DEFAULT 'Riengtu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `thong_bao`
INSERT INTO thong_bao (ma_thong_bao, ma_nguoi_dung, noi_dung, da_doc, loai_thong_bao) VALUES
(1, 4, 'Dơn Hàng của bạn đã được sử lý', 'đã đọc', 'Riengtu'),
(2, 4, 'Bạn đã thanh toán thành công', 'đã đọc', 'Riengtu'),
(3, 4, 'Cảm ơn bạn đã ủng hộ', 'đã đọc', 'Riengtu'),
(5, 5, 'Đơn Hàng của bạn đang được sử lý', 'chưa đọc', 'Riengtu'),
(6, 4, 'Đơn hàng của bạn đang được sử lý', 'chưa đọc', 'Riengtu');


-- --------------------------------------------------------

--
-- Table structure for table `thong_so_ky_thuat`
--

CREATE TABLE `thong_so_ky_thuat` (
  `ma_thong_so` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
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
(3, 3, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(4, 4, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(5, 5, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(6, 6, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(7, 8, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(8, 8, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(9, 9, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(10, 10, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(11, 11, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(12, 12, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(13, 13, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(14, 14, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(15, 15, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(16, 16, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(17, 17, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(18, 18, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(19, 19, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(20, 20, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(21, 21, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(22, 22, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(23, 23, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(24, 24, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(25, 25, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(26, 26, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(27, 27, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(28, 28, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(29, 29, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(30, 30, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(31, 31, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(32, 32, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(33, 33, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(34, 34, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(35, 35, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(36, 36, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(37, 37, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(38, 38, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(39, 39, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(40, 40, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(41, 41, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(42, 42, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(43, 43, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(44, 44, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(45, 45, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(46, 46, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(47, 47, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1'),
(48, 48, '133kg', '2.090mm x 739mm x 1.', '1.353mm', '799mm', '146mm', '7 lít', 'Trước: 100/80-16M/C50P', 'Sau: 120/80-16M/C60P', 'Ống lồng, giảm chấn thủy lực', 'Lò xo trụ, giảm chấn thủy lực', 'PGM-FI, xăng, 4 kỳ, 1 xy-lanh, làm mát bằng dung d', '12,4kW/8.500 vòng/phút', '0,9 lít khi rã máy', '2,37 lít/100km', 'Vô cấp, điều khiển tự động', 'Điện', '14,8N.m/6.500 vòng/phút', '156,9cm³', '60,0mm x 55,5mm', '12,0:1');

--
-- Indexes for dumped tables
--

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
  ADD KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  ADD KEY `fk_don_hang` (`ma_san_pham`);

--
-- Indexes for table `kho_hang`
--
ALTER TABLE `kho_hang`
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
  ADD PRIMARY KEY (`ma_hinh_anh`),
  ADD KEY `ma_san_pham` (`ma_san_pham`);

--
-- Indexes for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`ma_nguoi_dung`);

--
-- Indexes for table `phan_hoi`
--
ALTER TABLE `phan_hoi`
  ADD PRIMARY KEY (`ma_phan_hoi`),
  ADD KEY `fk_danh_gia_phan_hoi` (`ma_danh_gia`),
  ADD KEY `fk_nguoi_dung_phan_hoi` (`ma_nguoi_dung`);

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
-- Indexes for table `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD PRIMARY KEY (`ma_thong_bao`),
  ADD KEY `fk_thong_bao` (`ma_nguoi_dung`);

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
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  MODIFY `ma_khuyen_mai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `lich_su_giao_dich`
--
ALTER TABLE `lich_su_giao_dich`
  MODIFY `ma_giao_dich` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loai_xe`
--
ALTER TABLE `loai_xe`
  MODIFY `ma_loai_xe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `ma_nguoi_dung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `thong_so_ky_thuat`
--
ALTER TABLE `thong_so_ky_thuat`
  MODIFY `ma_thong_so` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Constraints for dumped tables
--

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
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`),
  ADD CONSTRAINT `fk_don_hang` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`);

--
-- Constraints for table `kho_hang`
--
ALTER TABLE `kho_hang`
  ADD CONSTRAINT `kho_hang_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`);

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
-- Constraints for table `phan_hoi`
--
ALTER TABLE `phan_hoi`
  ADD CONSTRAINT `fk_danh_gia_phan_hoi` FOREIGN KEY (`ma_danh_gia`) REFERENCES `danh_gia` (`ma_danh_gia`),
  ADD CONSTRAINT `fk_nguoi_dung_phan_hoi` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`);

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
-- Constraints for table `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD CONSTRAINT `fk_thong_bao` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`);

--
-- Constraints for table `thong_so_ky_thuat`
--
ALTER TABLE `thong_so_ky_thuat`
  ADD CONSTRAINT `thong_so_ky_thuat_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;