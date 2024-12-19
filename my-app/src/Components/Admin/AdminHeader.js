import React from 'react';
import { Link } from 'react-router-dom';

function AdminHeader() {
  return (
    <header>
      <div className="logo">
        <h1>Admin Dashboard</h1>
      </div>
      <nav>
        <ul>
          <li><Link to="/admin/dashboard">Dashboard</Link></li>
          <li><Link to="/admin/manage-product">Manage Products</Link></li>
          <li><Link to="/admin/manage-order">Manage Orders</Link></li>
          <li><Link to="/admin/manage-user">Manage Users</Link></li>
        </ul>
      </nav>
    </header>
  );
}

export default AdminHeader;
