import React from 'react';
import { Link } from 'react-router-dom';

function AdminSidebar() {
  return (
    <aside>
      <ul>
        <li><Link to="/admin/dashboard">Dashboard</Link></li>
        <li><Link to="/admin/manage-product">Manage Products</Link></li>
        <li><Link to="/admin/manage-order">Manage Orders</Link></li>
        <li><Link to="/admin/manage-user">Manage Users</Link></li>
      </ul>
    </aside>
  );
}

export default AdminSidebar;
