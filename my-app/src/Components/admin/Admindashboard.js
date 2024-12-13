import React from "react";
import { Admin, Resource } from "react-admin";
import dataProvider from "./dataProvider"; // Kết nối API
import ProductList from "./ProductList"; // Hiển thị danh sách sản phẩm
import ProductEdit from "./ProductEdit"; // Chỉnh sửa sản phẩm
import ProductCreate from "./ProductCreate"; // Tạo sản phẩm mới
import "./Admindashboard.scss";
const AdminDashboard = () => {
  return (
    <Admin dataProvider={dataProvider}>
      <Resource
        name="admin"
        list={ProductList}
        edit={ProductEdit}
        create={ProductCreate}
      />
    </Admin>
  );
};

export default AdminDashboard;
