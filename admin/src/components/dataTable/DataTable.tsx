// import { Link } from "react-router-dom";
import "./dataTable.scss";
import { DataGrid, GridColDef, GridToolbar } from "@mui/x-data-grid";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import Cookies from "js-cookie";

type Props = {
  columns: GridColDef[];
  rows: object[];
  slug: string;
  getRowId?: (row: any) => any;
};

const DataTable = (props: Props) => {
  const queryClient = useQueryClient();

  const lockMutation = useMutation({
    mutationFn: (params: { userId: number }) => {
      return fetch(`http://localhost:8000/users/${params.userId}/status`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${Cookies.get("access_token")}`, 
        },
        body: JSON.stringify({ status_update: "BiKhoa" }),
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries([`all${props.slug}`]);
    },
  });

  const unlockMutation = useMutation({
    mutationFn: (params: { userId: number }) => {
      return fetch(`http://localhost:8000/users/${params.userId}/status`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${Cookies.get("access_token")}`, 
        },
        body: JSON.stringify({ status_update: "HoatDong" }), 
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries([`all${props.slug}`]); // Lấy lại dữ liệu sau khi thay đổi
    },
  });

  const roleMutation = useMutation({
    mutationFn: (params: { userId: number; newRole: string }) => {
      return fetch(`http://localhost:8000/users/${params.userId}/role`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${Cookies.get("access_token")}`,
        },
        body: JSON.stringify({ role_update: params.newRole }),
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries([`all${props.slug}`]);
    },
  });

  const handleLock = (userId: number) => {
    lockMutation.mutate({ userId });
  };

  const handleUnlock = (userId: number) => {
  unlockMutation.mutate({ userId });
};

  const handleRoleChange = (userId: number, role: string) => {
    roleMutation.mutate({ userId, newRole: role });
  };

  const actionColumn: GridColDef = {
    field: "action",
    headerName: "Action",
    width: 140,
    renderCell: (params) => {
      const isLocked = params.row.trang_thai === "BiKhoa";

      return (
        <div className="action">
          {/* <Link to={`/${props.slug}/${params.row.ma_nguoi_dung}`}>
            <img src="/view.svg" alt="" />
          </Link> */}
          <div
            className={`lock ${isLocked ? "locked" : ""}`}
            onClick={() => handleLock(params.row.ma_nguoi_dung)}
          >
            <img src="/lock.svg" alt="" />
          </div>
          <div
          className={`unlock ${!isLocked ? "unlocked" : ""}`}
          onClick={() => handleUnlock(params.row.ma_nguoi_dung)}
        >
          <img src="/unlock.svg" alt="" />
        </div>
          <div
            className="upRole"
            onClick={() => handleRoleChange(params.row.ma_nguoi_dung, "Admin")}
          >
            <img src="/uprole.svg" alt="" />
          </div>
          <div
            className="downRole"
            onClick={() => handleRoleChange(params.row.ma_nguoi_dung, "User")}
          >
            <img src="/downrole.svg" alt="" />
          </div>
        </div>
      );
    },
  };

  return (
    <div className="dataTable">
      <DataGrid
        className="dataGrid"
        rows={props.rows}
        columns={[...props.columns, actionColumn]}
        initialState={{
          pagination: {
            paginationModel: {
              pageSize: 10,
            },
          },
        }}
        slots={{ toolbar: GridToolbar }}
        slotProps={{
          toolbar: {
            showQuickFilter: true,
            quickFilterProps: { debounceMs: 500 },
          },
        }}
        pageSizeOptions={[5]}
        disableRowSelectionOnClick
        disableColumnFilter
        disableDensitySelector
        disableColumnSelector
        getRowId={props.getRowId}
      />
    </div>
  );
};

export default DataTable;
