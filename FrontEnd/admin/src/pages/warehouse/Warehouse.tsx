import { useState, useEffect } from "react";
import "./warehouse.scss";
import { GridColDef } from "@mui/x-data-grid";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Cookies from "js-cookie";
import DataTableWarehouse from "../../components/dataTableWarehouse/DataTableWarehouse";

const columns: GridColDef[] = [
  { field: "ma_san_pham", headerName: "IDP", width: 100 },
  { field: "so_luong", headerName: "Số lượng", width: 150 },
];

const Warehouse = () => {
  const [products, setProducts] = useState<any[]>([]); // Store the fetched data
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
      .get("http://localhost:8000/khohang", {
        headers: {
          "Authorization": `Bearer ${Cookies.get("access_token")}`,
        },
      })
      .then((response) => {
        setProducts(response.data);
        setIsLoading(false);
      })
      .catch((err) => {
        setError("Lỗi khi tải kho hàng: " + err.message);
        setIsLoading(false);
      });
  }, []);

  return (
    <div className="warehouse">
      <div className="info">
        <h1>Kho hàng</h1>
      </div>
      {isLoading ? (
        <p>Loading...</p>
      ) : error ? (
        <p>{error}</p>
      ) : (
        <DataTableWarehouse
          slug="khohang"
          columns={columns}
          rows={products}
          getRowId={(row) => row.ma_san_pham}
        />
      )}
    </div>
  );
};

export default Warehouse;
