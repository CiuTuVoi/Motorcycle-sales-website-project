import React, { useEffect, useState } from "react";
import "./Promotions.scss"; // Đường dẫn SCSS

const Promotions = () => {
  const [promotion1, setPromotion1] = useState(null); // Chỉ cần một khuyến mãi

  useEffect(() => {
    fetch("http://127.0.0.1:8000/khuyenmai")
      .then((response) => response.json())
      .then((data) => {
        // Tìm khuyến mãi có mã là 1
        const promo1 = data.find((item) => item.ma_khuyen_mai === 1);
        setPromotion1(promo1); // Lưu lại khuyến mãi này
      })
      .catch((error) => console.error("Error fetching promotions:", error));
  }, []);

  if (!promotion1) {
    return <p>Đang tải dữ liệu...</p>;
  }

  return (
    <div className="promotion-banner">
      <h1>Chi Tiết Khuyến Mãi</h1>
      <div>
        <h3>{promotion1.ten_khuyen_mai}</h3>
        <p>{promotion1.mo_ta}</p>
        <p className="discount">Giảm: {promotion1.muc_giam}%</p>
        <p>
          Từ {promotion1.ngay_bat_dau} đến {promotion1.ngay_ket_thuc}
        </p>
      </div>
    </div>
  );
};

export default Promotions;
