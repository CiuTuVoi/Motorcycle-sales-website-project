import { useState, useEffect } from "react";
import "./Products.scss";
import DataTableProducts from "../../components/dataTableProducts/DataTableProducts";
import Add from "../../components/add/Add";
import { GridColDef } from "@mui/x-data-grid";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Cookies from "js-cookie";

const columns: GridColDef[] = [
  { field: "ma_san_pham", headerName: "IDP", width: 1 },
  {
    field: "ma_loai_xe",
    headerName: "Mã Loại Xe",
    type: "number",
    width: 90,
  },
  {
    field: "anh_dai_dien",
    headerName: "Ảnh Đại Diện",
    width: 150,
    renderCell: (params) => (
      <img src={params.value} alt="Product" style={{ width: "100px", height: "auto" }} />
    ),
  },
  {
    field: "ten_san_pham",
    type: "string",
    headerName: "Tên Sản Phẩm",
    width: 250,
  },
  {
    field: "hang_xe",
    type: "string",
    headerName: "Hãng Xe",
    width: 80,
  },
  {
    field: "gia",
    type: "number",
    headerName: "Giá",
    width: 110,
  },
  {
    field: "gia_khuyen_mai",
    type: "number",
    headerName: "Giá Khuyến Mãi",
    width: 120,
  },
  {
    field: "ngay_tao",
    headerName: "Ngày Tạo",
    width: 160,
    type: "string",
  },
];

const Products = () => {
  const [open, setOpen] = useState(false);
  const [products, setProducts] = useState<any[]>([]); 
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
    axios
      .get("http://localhost:8000/products/1")
      .then((response) => {
        setProducts(response.data);
        setIsLoading(false); 
      })
      .catch((err) => {
        setError("Lỗi khi tải sản phẩm: " + err.message);
        setIsLoading(false);
      });
  }, []); 

  return (
    <div className="products">
      <div className="info">
        <h1>Products</h1>
        <button onClick={() => setOpen(true)}>Thêm sản phẩm</button>
      </div>
      {isLoading ? (
        <p>Loading...</p>
      ) : error ? (
        <p>{error}</p>
      ) : ( 
        <DataTableProducts 
          slug="products" 
          columns={columns} 
          rows={products} 
          getRowId={(row) => row.ma_san_pham}
        />
      )}

      {open && <Add slug="product" columns={columns} setOpen={setOpen} />}
    </div>
  );
};

export default Products;
