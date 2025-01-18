import { useState, useEffect } from "react";
import "./order.scss";
import { GridColDef } from "@mui/x-data-grid";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Cookies from "js-cookie";
import DataTableOrder from "../../components/dataTableOrder/DataTableOrder";

const columns: GridColDef[] = [
  { field: "ma_nguoi_dung", headerName: "ID Người dùng", width: 150 },
  { field: "ma_san_pham", headerName: "ID Sản phẩm", width: 150 },
  { field: "so_luong", headerName: "Số lượng", width: 150 },
  { field: "don_gia", headerName: "Đơn giá", width: 150, type: "number" },
  { field: "tong_tien", headerName: "Tổng tiền", width: 150, type: "number" },
  { field: "trang_thai", headerName: "Trạng thái", width: 150 },
  { field: "ngay_tao", headerName: "Ngày tạo", width: 200, type: "string" },
];

const Order = () => {
  const [orders, setOrders] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const token = Cookies.get("access_token");
    if (!token) {
      navigate("/login");
    }
  }, [navigate]);

  useEffect(() => {
    // Fetch warehouse data from the API
    axios
      .get("http://localhost:8000/donhang_all", {
        headers: {
          "Authorization": `Bearer ${Cookies.get("access_token")}`,
        },
      })
      .then((response) => {
        setOrders(response.data);
        setIsLoading(false);
      })
      .catch((err) => {
        setError("Lỗi khi tải đơn hàng: " + err.message);
        setIsLoading(false);
      });
  }, []);

  return (
    <div className="order">
      <div className="info">
        <h1>Đơn hàng</h1>
      </div>
      {isLoading ? (
        <p>Loading...</p>
      ) : error ? (
        <p>{error}</p>
      ) : (
        <DataTableOrder
          slug="donhang"
          columns={columns}
          rows={orders}
        />
      )}
    </div>
  );
};

export default Order;
