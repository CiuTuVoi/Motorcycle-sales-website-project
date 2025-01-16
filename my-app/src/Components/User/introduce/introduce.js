import React from "react";
import { useSelector, useDispatch } from "react-redux";
import Header from "../Header/Header";
import Footers from "../Footer/Footer";
import './introduce.scss'

const Cart = () => {
  const cart = useSelector((state) => state.cart);
  const dispatch = useDispatch();

  const calculateTotal = () => {
    return cart
      .reduce((total, item) => total + item.gia * item.quantity, 0)
      .toLocaleString();
  };

  // Default image for invalid or missing URLs
  const defaultImage = "/images/default.png";

  return (
    <div>
      <Header />
      <div className="detail-introduce">
        <p>
          Chào mừng bạn đến với [Tên trang web], nơi cung cấp các giải pháp mua
          bán xe toàn diện, nhanh chóng và đáng tin cậy. Tại đây, chúng tôi tự
          hào mang đến cho bạn: Đa dạng các dòng xe: Từ xe mới, xe đã qua sử
          dụng đến các mẫu xe cao cấp, phù hợp với mọi nhu cầu và ngân sách.
          Thông tin minh bạch: Mọi xe đều được kiểm định chất lượng và cung cấp
          thông tin chi tiết về nguồn gốc, tình trạng và giá cả. Giao dịch dễ
          dàng: Hỗ trợ khách hàng từ việc tư vấn chọn xe, thủ tục vay mua xe,
          đến việc giao xe tận nơi. Dịch vụ hậu mãi chuyên nghiệp: Bảo hành, bảo
          dưỡng và tư vấn kỹ thuật để bạn hoàn toàn yên tâm sau khi mua xe. Hãy
          cùng khám phá và tìm chiếc xe lý tưởng cho bạn ngay hôm nay! Với [Tên
          trang web], hành trình tìm kiếm chiếc xe mơ ước chưa bao giờ dễ dàng
          đến thế. Liên hệ ngay để nhận tư vấn miễn phí và các ưu đãi hấp dẫn!
        </p>
      </div>

      <Footers />
    </div>
  );
};

export default Cart;
