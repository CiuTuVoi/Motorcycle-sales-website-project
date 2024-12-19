import React from 'react';

function Dashboard() {
  return (
    <div>
      <h2>Dashboard</h2>
      <div className="stats">
        <div className="stat-item">
          <h3>Total Products</h3>
          <p>50</p>
        </div>
        <div className="stat-item">
          <h3>Total Orders</h3>
          <p>120</p>
        </div>
        <div className="stat-item">
          <h3>Total Users</h3>
          <p>200</p>
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
