-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2024 at 07:14 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `loai_xe`
--

CREATE TABLE `loai_xe` (
  `ma_loai_xe` int(11) NOT NULL,
  `loai_xe` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `san_pham_khuyen_mai`
--

CREATE TABLE `san_pham_khuyen_mai` (
  `ma_san_pham` int(11) NOT NULL,
  `ma_khuyen_mai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `thong_so_ky_thuat`
--

CREATE TABLE `thong_so_ky_thuat` (
  `ma_thong_so` int(11) NOT NULL,
  `ma_san_pham` int(11) DEFAULT NULL,
  `khoi_luong` varchar(10) DEFAULT NULL,
  `do_cao_yen` varchar(10) DEFAULT NULL,
  `kich_thuoc_DRC` varchar(50) DEFAULT NULL,
  `khoang_cach_truc_banh_xe` varchar(10) DEFAULT NULL,
  `dung_tich_xang` varchar(10) DEFAULT NULL,
  `kich_thuoc_lop_truoc` varchar(50) DEFAULT NULL,
  `kich_thuoc_lop_sau` varchar(50) DEFAULT NULL,
  `loai_dong_co` varchar(50) DEFAULT NULL,
  `cong_suat_toi_da` varchar(50) DEFAULT NULL,
  `dung_tich_nhot_may` varchar(50) DEFAULT NULL,
  `dung_tich_nhien_lieu` varchar(50) DEFAULT NULL,
  `loai_truyen_dong` varchar(50) DEFAULT NULL,
  `he_thong_khoi_dong` varchar(55) DEFAULT NULL,
  `moment_cuc_dai` varchar(50) DEFAULT NULL,
  `duong_kinh_x_hanh_trinh_pit_tong` varchar(50) DEFAULT NULL,
  `ty_so_nen` varchar(50) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `ma_chi_tiet` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don_hang` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kho_hang`
--
ALTER TABLE `kho_hang`
  MODIFY `ma_kho` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `khuyen_mai`
--
ALTER TABLE `khuyen_mai`
  MODIFY `ma_khuyen_mai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lich_su_giao_dich`
--
ALTER TABLE `lich_su_giao_dich`
  MODIFY `ma_giao_dich` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loai_xe`
--
ALTER TABLE `loai_xe`
  MODIFY `ma_loai_xe` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `ma_nguoi_dung` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `ma_san_pham` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `thong_so_ky_thuat`
--
ALTER TABLE `thong_so_ky_thuat`
  MODIFY `ma_thong_so` int(11) NOT NULL AUTO_INCREMENT;

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
