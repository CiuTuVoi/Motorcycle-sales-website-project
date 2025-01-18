import DataTable from "../../components/dataTable/DataTable";
import "./users.scss";
import { GridColDef } from "@mui/x-data-grid";
import { useState, useEffect } from "react";
import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "react-router-dom";
import Cookies from "js-cookie";

const columns: GridColDef[] = [
  { field: "ma_nguoi_dung", headerName: "ID", width: 1 },
  {
    field: "ho_ten",
    headerName: "Họ Tên",
    width: 150,
    type: "string",
  },
  {
    field: "tuoi",
    headerName: "Tuổi",
    width: 50,
    type: "number",
  },
  {
    field: "gioi_tinh",
    headerName: "Giới Tính",
    width: 77,
    type: "string",
  },
  {
    field: "email",
    headerName: "Email",
    width: 230,
    type: "string",
  },
  {
    field: "so_dien_thoai",
    headerName: "Số Điện Thoại",
    width: 120,
    type: "string",
  },
  {
    field: "dia_chi",
    headerName: "Địa Chỉ",
    width: 100,
    type: "string",
  },
  {
    field: "role",
    headerName: "Vai Trò",
    width: 70,
    type: "string",
  },
  {
    field: "trang_thai",
    headerName: "Trạng Thái",
    width: 100,
    type: "string",
  },
];

const Users = () => {
  const [users, setUsers] = useState<any[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    const token = Cookies.get("access_token");
    if (!token) {
      navigate("/login");
    }
  }, [navigate]);

  const { isLoading} = useQuery({
    queryKey: ["allusers"],
    queryFn: async () => {
      const response = await fetch("http://127.0.0.1:8000/users/me", {
        headers: {
          Authorization: `Bearer ${Cookies.get("access_token")}`,
        },
      });

      if (!response.ok) {
        throw new Error("Failed to fetch users");
      }

      return response.json();
    },
    onSuccess: (data) => {
      setUsers(data);
    },
  });

  return (
    <div className="users">
      <div className="info">
        <h1>Users</h1>
      </div>

      {isLoading ? (
        "Loading..."
      ) : (
        <DataTable
          slug="users"
          columns={columns}
          rows={users}
          getRowId={(row) => row.ma_nguoi_dung}
        />
      )}
    </div>
  );
};

export default Users;
