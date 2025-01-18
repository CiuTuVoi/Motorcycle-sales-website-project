import React, { useState } from "react";
import "./dataTableWarehouse.scss";
import { DataGrid, GridColDef, GridToolbar } from "@mui/x-data-grid";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import Cookies from "js-cookie";

type Props = {
  columns: GridColDef[];
  rows: object[];
  slug: string;
  getRowId?: (row: any) => any;
};

const DataTableWarehouse = (props: Props) => {
  const queryClient = useQueryClient();

  const [editMode, setEditMode] = useState<{ id: string; quantity: number } | null>(null);
  const [so_luong_moi, setNewQuantity] = useState<number>(0);

  const updateQuantityMutation = useMutation({
    mutationFn: (params: { ma_san_pham: number; so_luong_moi: number }) => {
      return fetch(`http://localhost:8000/khohang/${params.ma_san_pham}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${Cookies.get("access_token")}`,
        },
        body: JSON.stringify({ ma_san_pham: params.ma_san_pham,so_luong: params.so_luong_moi }),
      });
      
    },
    onSuccess: () => {
      window.location.reload();
      setEditMode(null);
    },
  });
  console.log({ so_luong: so_luong_moi });


  const deleteProductMutation = useMutation({
    mutationFn: (ma_san_pham: number) => {
      return fetch(`http://localhost:8000/khohang/${ma_san_pham}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${Cookies.get("access_token")}`,
        },
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries([`all${props.slug}`]);
    },
  });

  const handleEdit = (id: string, quantity: number) => {
    if (editMode && editMode.id === id) {
      setEditMode(null);
    } else {
      setEditMode({ id, quantity });
      setNewQuantity(quantity);
    }
  };

  const handleSave = (id: string) => {
    updateQuantityMutation.mutate({
      ma_san_pham: Number(id), 
      so_luong_moi: so_luong_moi,
    });
  };

  const handleCancel = () => {
    setEditMode(null);
  };

  const handleDelete = (id: string) => {
      deleteProductMutation.mutate(Number(id));
  };

  const handleEnterPress = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && editMode) {
      handleSave(editMode.id); 
    }
  };

  const actionColumn: GridColDef = {
    field: "action",
    headerName: "Action",
    width: 180,
    renderCell: (params) => {

      return (
        <div className="action">
          <div
            className="editIcon"
            onClick={() => handleEdit(params.row.ma_san_pham, params.row.so_luong)}
          >
            <img src="/pencil.svg" alt="Edit" />
          </div>
          {editMode && editMode.id === params.row.ma_san_pham && (
            <div className="edit-popup">
              <input
                type="number"
                value={so_luong_moi}
                onChange={(e) => setNewQuantity(Number(e.target.value))}
                min="1"
                onKeyDown={handleEnterPress} 
              />
              <button onClick={() => handleSave(params.row.ma_san_pham)}>Save</button>
              <button onClick={handleCancel}>Cancel</button>
            </div>
          )}
          <div
            className="deleteIcon"
            onClick={() => handleDelete(params.row.ma_san_pham)}
          >
            <img src="/delete.svg" alt="Delete" />
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

export default DataTableWarehouse;
