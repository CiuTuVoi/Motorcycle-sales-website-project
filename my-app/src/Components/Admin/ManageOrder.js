import React, { useState } from 'react';

function ManageOrder() {
  const [orders, setOrders] = useState([
    { id: 1, customer: 'John Doe', product: 'Yamaha R1', status: 'Pending' },
    { id: 2, customer: 'Jane Smith', product: 'Honda CBR1000RR', status: 'Shipped' },
    // Add more orders here
  ]);

  return (
    <div>
      <h2>Manage Orders</h2>
      <table>
        <thead>
          <tr>
            <th>Customer</th>
            <th>Product</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {orders.map((order) => (
            <tr key={order.id}>
              <td>{order.customer}</td>
              <td>{order.product}</td>
              <td>{order.status}</td>
              <td>
                <button>View</button>
                <button>Update Status</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default ManageOrder;
