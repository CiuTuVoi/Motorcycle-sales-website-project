import DataTable from "../../components/dataTable/DataTable";
import "./users.scss";
import { GridColDef } from "@mui/x-data-grid";
import Add from "../../components/add/Add";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
// import { userRows } from "../../data";

const columns: GridColDef[] = [
  // { field: "id", headerName: "ID", width: 90 },
  // {
  //   field: "img",
  //   headerName: "Avatar",
  //   width: 100,
  //   renderCell: (params) => {
  //     return <img src={params.row.img || "/noavatar.png"} alt="" />;
  //   },
  // },
  // {
  //   field: "firstName",
  //   type: "string",
  //   headerName: "First name",
  //   width: 150,
  // },
  // {
  //   field: "lastName",
  //   type: "string",
  //   headerName: "Last name",
  //   width: 150,
  // },
  // {
  //   field: "email",
  //   type: "string",
  //   headerName: "Email",
  //   width: 200,
  // },
  // {
  //   field: "phone",
  //   type: "string",
  //   headerName: "Phone",
  //   width: 200,
  // },
  // {
  //   field: "createdAt",
  //   headerName: "Created At",
  //   width: 200,
  //   type: "string",
  // },
  // {
  //   field: "verified",
  //   headerName: "Verified",
  //   width: 150,
  //   type: "boolean",
  // },
  { field: "ma_nguoi_dung", headerName: "ID", width: 90 },
  {
    field: "ho_ten",
    headerName: "Họ Tên",
    width: 150,
    type: "string",
  },
  {
    field: "tuoi",
    headerName: "Tuổi",
    width: 100,
    type: "number",
  },
  {
    field: "gioi_tinh",
    headerName: "Giới Tính",
    width: 100,
    type: "string",
  },
  {
    field: "email",
    headerName: "Email",
    width: 200,
    type: "string",
  },
  {
    field: "dia_chi",
    headerName: "Địa Chỉ",
    width: 250,
    type: "string",
  },
  {
    field: "so_dien_thoai",
    headerName: "Số Điện Thoại",
    width: 150,
    type: "string",
  },
  {
    field: "vai_tro",
    headerName: "Vai Trò",
    width: 100,
    type: "string",
  },
  {
    field: "trang_thai",
    headerName: "Trạng Thái",
    width: 150,
    type: "string",
  },
  {
    field: "ngay_tao",
    headerName: "Ngày Tạo",
    width: 200,
    type: "date",
  },
];

const Users = () => {
  const [open, setOpen] = useState(false);

  {
    /* Test api */
  }

  const { isLoading, data } = useQuery({
    queryKey: ["allusers"],
    queryFn: () =>
      fetch("http://localhost:8800/api/users").then((res) => res.json()),
  });

  return (
    <div className="users">
      <div className="info">
        <h1>Users</h1>
        <button onClick={() => setOpen(true)}>Add New User</button>
      </div>
      {/* <DataTable slug="users" columns={columns} rows={userRows} />*/}

      {/* Test api */}

      {isLoading ? (
        "Loading..."
      ) : (
        <DataTable slug="users" columns={columns} rows={data} />
      )}
      {open && <Add slug="user" columns={columns} setOpen={setOpen} />}
    </div>
  );
};

export default Users;
