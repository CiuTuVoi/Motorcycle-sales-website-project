-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2024 at 01:24 PM
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
-- Database: `ban_xe`
--

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `ma_chi_tiet` int(11) NOT NULL,
  `ma_don_hang` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
  `so_luong` int(11) NOT NULL,
  `gia` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`ma_chi_tiet`, `ma_don_hang`, `ma_san_pham`, `so_luong`, `gia`) VALUES
(1, 1, 1, 1, 71000000.00),
(2, 2, 2, 1, 47000000.00),
(3, 3, 4, 1, 37000000.00);

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `ma_danh_gia` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
  `ma_khach_hang` int(11) NOT NULL,
  `so_sao` int(11) DEFAULT NULL CHECK (`so_sao` between 1 and 5),
  `nhan_xet` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`ma_danh_gia`, `ma_san_pham`, `ma_khach_hang`, `so_sao`, `nhan_xet`, `ngay_tao`) VALUES
(1, 1, 1, 5, 'Xe chạy rất êm và tiết kiệm xăng.', '2024-11-16 10:49:15'),
(2, 2, 2, 4, 'Xe mạnh mẽ nhưng giá hơi cao.', '2024-11-16 10:49:15'),
(3, 4, 3, 5, 'Xe điện rất tốt, bảo vệ môi trường.', '2024-11-16 10:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `danh_muc`
--

CREATE TABLE `danh_muc` (
  `ma_danh_muc` int(11) NOT NULL,
  `ten_danh_muc` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danh_muc`
--

INSERT INTO `danh_muc` (`ma_danh_muc`, `ten_danh_muc`, `mo_ta`, `ngay_tao`) VALUES
(1, 'Xe Honda', 'Các loại xe máy từ thương hiệu Honda', '2024-11-16 10:48:35'),
(2, 'Xe Yamaha', 'Các loại xe máy từ thương hiệu Yamaha', '2024-11-16 10:48:35'),
(3, 'Xe Suzuki', 'Các loại xe máy từ thương hiệu Suzuki', '2024-11-16 10:48:35'),
(4, 'Xe Điện', 'Các loại xe máy điện và xe đạp điện', '2024-11-16 10:48:35'),
(5, 'Xe 50cc', 'Các loại xe máy 50cc phù hợp cho học sinh', '2024-11-16 10:48:35');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `ma_don_hang` int(11) NOT NULL,
  `ma_khach_hang` int(11) NOT NULL,
  `tong_tien` decimal(15,2) NOT NULL,
  `trang_thai` enum('Dang_xu_ly','Hoan_thanh','Da_huy') DEFAULT 'Dang_xu_ly',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`ma_don_hang`, `ma_khach_hang`, `tong_tien`, `trang_thai`, `ngay_tao`) VALUES
(1, 1, 71000000.00, 'Hoan_thanh', '2024-11-16 10:49:15'),
(2, 2, 47000000.00, 'Dang_xu_ly', '2024-11-16 10:49:15'),
(3, 3, 37000000.00, 'Hoan_thanh', '2024-11-16 10:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `khach_hang`
--

CREATE TABLE `khach_hang` (
  `ma_khach_hang` int(11) NOT NULL,
  `ten_khach_hang` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) NOT NULL,
  `dia_chi` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khach_hang`
--

INSERT INTO `khach_hang` (`ma_khach_hang`, `ten_khach_hang`, `email`, `so_dien_thoai`, `dia_chi`, `ngay_tao`) VALUES
(1, 'Nguyễn Văn A', 'nguyenvana@example.com', '0912345678', 'Hà Nội', '2024-11-16 10:49:15'),
(2, 'Trần Thị B', 'tranthib@example.com', '0987654321', 'TP. Hồ Chí Minh', '2024-11-16 10:49:15'),
(3, 'Lê Hoàng C', 'lehoangc@example.com', '0911223344', 'Đà Nẵng', '2024-11-16 10:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `khuyen_mai`
--

CREATE TABLE `khuyen_mai` (
  `ma_khuyen_mai` int(11) NOT NULL,
  `ten_khuyen_mai` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `muc_giam` decimal(5,2) DEFAULT NULL,
  `ngay_bat_dau` date NOT NULL,
  `ngay_ket_thuc` date NOT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khuyen_mai`
--

INSERT INTO `khuyen_mai` (`ma_khuyen_mai`, `ten_khuyen_mai`, `mo_ta`, `muc_giam`, `ngay_bat_dau`, `ngay_ket_thuc`, `ngay_tao`) VALUES
(1, 'Giảm giá hè 2024', 'Giảm giá 5% cho các dòng xe máy', 5.00, '2024-06-01', '2024-08-31', '2024-11-16 10:49:15'),
(2, 'Black Friday', 'Giảm giá 10% cho các dòng xe tay ga', 10.00, '2024-11-25', '2024-11-30', '2024-11-16 10:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `ma_nguoi_dung` int(11) NOT NULL,
  `ten_dang_nhap` varchar(255) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `ho_ten` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `vai_tro` enum('Admin','NhanVien') DEFAULT 'NhanVien',
  `trang_thai` enum('HoatDong','BiKhoa') DEFAULT 'HoatDong',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`ma_nguoi_dung`, `ten_dang_nhap`, `mat_khau`, `ho_ten`, `email`, `so_dien_thoai`, `vai_tro`, `trang_thai`, `ngay_tao`) VALUES
(1, 'admin', 'hashed_password_1', 'Nguyễn Quản Trị', 'admin@example.com', '0901234567', 'Admin', 'HoatDong', '2024-11-16 10:49:15'),
(2, 'nhanvien1', 'hashed_password_2', 'Trần Nhân Viên', 'nhanvien1@example.com', '0907654321', 'NhanVien', 'HoatDong', '2024-11-16 10:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung_quyen`
--

CREATE TABLE `nguoi_dung_quyen` (
  `ma` int(11) NOT NULL,
  `ma_nguoi_dung` int(11) NOT NULL,
  `ma_quyen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nguoi_dung_quyen`
--

INSERT INTO `nguoi_dung_quyen` (`ma`, `ma_nguoi_dung`, `ma_quyen`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `phan_quyen`
--

CREATE TABLE `phan_quyen` (
  `ma_quyen` int(11) NOT NULL,
  `ten_quyen` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `phan_quyen`
--

INSERT INTO `phan_quyen` (`ma_quyen`, `ten_quyen`, `mo_ta`) VALUES
(1, 'QuanLySanPham', 'Quản lý thông tin sản phẩm'),
(2, 'QuanLyDonHang', 'Quản lý đơn hàng'),
(3, 'XemBaoCao', 'Xem báo cáo doanh thu'),
(4, 'QuanLyKhuyenMai', 'Quản lý chương trình khuyến mãi');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham`
--

CREATE TABLE `san_pham` (
  `ma_san_pham` int(11) NOT NULL,
  `ma_danh_muc` int(11) NOT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `hang_xe` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `gia` decimal(15,2) NOT NULL,
  `gia_khuyen_mai` decimal(15,2) DEFAULT NULL,
  `ton_kho` int(11) DEFAULT 0,
  `bao_hanh` int(11) DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham`
--

INSERT INTO `san_pham` (`ma_san_pham`, `ma_danh_muc`, `ten_san_pham`, `hang_xe`, `mo_ta`, `gia`, `gia_khuyen_mai`, `ton_kho`, `bao_hanh`, `anh_dai_dien`, `ngay_tao`) VALUES
(1, 1, 'Honda SH Mode 2024', 'Honda', 'Dòng xe tay ga cao cấp', 73000000.00, 71000000.00, 10, 24, 'shmode2024.jpg', '2024-11-16 10:49:15'),
(2, 2, 'Yamaha Exciter 155', 'Yamaha', 'Xe côn tay mạnh mẽ', 47000000.00, NULL, 15, 12, 'exciter155.jpg', '2024-11-16 10:49:15'),
(3, 3, 'Suzuki Raider 150', 'Suzuki', 'Dòng xe côn tay thể thao', 49000000.00, 47000000.00, 8, 12, 'raider150.jpg', '2024-11-16 10:49:15'),
(4, 4, 'VinFast Klara S', 'VinFast', 'Xe máy điện hiện đại, tiết kiệm năng lượng', 39000000.00, 37000000.00, 20, 24, 'klaras.jpg', '2024-11-16 10:49:15'),
(5, 5, 'SYM Galaxy 50cc', 'SYM', 'Xe máy 50cc nhỏ gọn', 21000000.00, 20000000.00, 25, 12, 'galaxy50cc.jpg', '2024-11-16 10:49:15');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham_khuyen_mai`
--

CREATE TABLE `san_pham_khuyen_mai` (
  `ma` int(11) NOT NULL,
  `ma_san_pham` int(11) NOT NULL,
  `ma_khuyen_mai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham_khuyen_mai`
--

INSERT INTO `san_pham_khuyen_mai` (`ma`, `ma_san_pham`, `ma_khuyen_mai`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 2),
(4, 4, 2);

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
  ADD KEY `ma_khach_hang` (`ma_khach_hang`);

--
-- Indexes for table `danh_muc`
--
ALTER TABLE `danh_muc`
  ADD PRIMARY KEY (`ma_danh_muc`);

--
-- Indexes for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`ma_don_hang`),
  ADD KEY `ma_khach_hang` (`ma_khach_hang`);

--
-- Indexes for table `khach_hang`
--
ALTER TABLE `khach_hang`
  ADD PRIMARY KEY (`ma_khach_hang`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  ADD PRIMARY KEY (`ma_khuyen_mai`);

--
-- Indexes for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`ma_nguoi_dung`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `nguoi_dung_quyen`
--
ALTER TABLE `nguoi_dung_quyen`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `ma_nguoi_dung` (`ma_nguoi_dung`),
  ADD KEY `ma_quyen` (`ma_quyen`);

--
-- Indexes for table `phan_quyen`
--
ALTER TABLE `phan_quyen`
  ADD PRIMARY KEY (`ma_quyen`),
  ADD UNIQUE KEY `ten_quyen` (`ten_quyen`);

--
-- Indexes for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`ma_san_pham`),
  ADD KEY `ma_danh_muc` (`ma_danh_muc`);

--
-- Indexes for table `san_pham_khuyen_mai`
--
ALTER TABLE `san_pham_khuyen_mai`
  ADD PRIMARY KEY (`ma`),
  ADD KEY `ma_san_pham` (`ma_san_pham`),
  ADD KEY `ma_khuyen_mai` (`ma_khuyen_mai`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `ma_chi_tiet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `danh_muc`
--
ALTER TABLE `danh_muc`
  MODIFY `ma_danh_muc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `khach_hang`
--
ALTER TABLE `khach_hang`
  MODIFY `ma_khach_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  MODIFY `ma_khuyen_mai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `ma_nguoi_dung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nguoi_dung_quyen`
--
ALTER TABLE `nguoi_dung_quyen`
  MODIFY `ma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `phan_quyen`
--
ALTER TABLE `phan_quyen`
  MODIFY `ma_quyen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `ma_san_pham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `san_pham_khuyen_mai`
--
ALTER TABLE `san_pham_khuyen_mai`
  MODIFY `ma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`ma_don_hang`) REFERENCES `don_hang` (`ma_don_hang`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`) ON DELETE CASCADE;

--
-- Constraints for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`) ON DELETE CASCADE,
  ADD CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`ma_khach_hang`) REFERENCES `khach_hang` (`ma_khach_hang`) ON DELETE CASCADE;

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_khach_hang`) REFERENCES `khach_hang` (`ma_khach_hang`) ON DELETE CASCADE;

--
-- Constraints for table `nguoi_dung_quyen`
--
ALTER TABLE `nguoi_dung_quyen`
  ADD CONSTRAINT `nguoi_dung_quyen_ibfk_1` FOREIGN KEY (`ma_nguoi_dung`) REFERENCES `nguoi_dung` (`ma_nguoi_dung`) ON DELETE CASCADE,
  ADD CONSTRAINT `nguoi_dung_quyen_ibfk_2` FOREIGN KEY (`ma_quyen`) REFERENCES `phan_quyen` (`ma_quyen`) ON DELETE CASCADE;

--
-- Constraints for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`ma_danh_muc`) REFERENCES `danh_muc` (`ma_danh_muc`) ON DELETE CASCADE;

--
-- Constraints for table `san_pham_khuyen_mai`
--
ALTER TABLE `san_pham_khuyen_mai`
  ADD CONSTRAINT `san_pham_khuyen_mai_ibfk_1` FOREIGN KEY (`ma_san_pham`) REFERENCES `san_pham` (`ma_san_pham`) ON DELETE CASCADE,
  ADD CONSTRAINT `san_pham_khuyen_mai_ibfk_2` FOREIGN KEY (`ma_khuyen_mai`) REFERENCES `khuyen_mai` (`ma_khuyen_mai`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
