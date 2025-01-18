import { Link } from "react-router-dom";
import "./dataTableProducts.scss";
import { DataGrid, GridColDef, GridToolbar } from "@mui/x-data-grid";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import Cookies from "js-cookie";

type Props = {
  columns: GridColDef[];
  rows: object[];
  slug: string;
  getRowId?: (row: any) => any;
};

const DataTableProducts = (props: Props) => {
  const queryClient = useQueryClient();

  // API mutation cho các thao tác liên quan đến sản phẩm
  const deleteMutation = useMutation({
    mutationFn: (params: { productId: number }) => {
      return fetch(`http://localhost:8000/products/${params.productId}`, {
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

  const handleDelete = (productId: number) => {
    deleteMutation.mutate({productId});
  };

  const actionColumn: GridColDef = {
    field: "action",
    headerName: "Action",
    width: 70,
    renderCell: (params) => {
      return (
        <div className="action">
          <Link to={`/${props.slug}/${params.row.id}`}>
            <img src="/view.svg" alt="" />
          </Link>
          <div className="delete" onClick={() => handleDelete(params.row.ma_san_pham)}>
            <img src="/delete.svg" alt="delete" />
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

export default DataTableProducts;
