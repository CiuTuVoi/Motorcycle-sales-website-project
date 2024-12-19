import React, { useState } from 'react';

function ManageProduct() {
  const [products, setProducts] = useState([
    { id: 1, name: 'Yamaha R1', price: 20000 },
    { id: 2, name: 'Honda CBR1000RR', price: 22000 },
    // Add more products here
  ]);

  return (
    <div>
      <h2>Manage Products</h2>
      <button>Add New Product</button>
      <table>
        <thead>
          <tr>
            <th>Product Name</th>
            <th>Price</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {products.map((product) => (
            <tr key={product.id}>
              <td>{product.name}</td>
              <td>{product.price}</td>
              <td>
                <button>Edit</button>
                <button>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default ManageProduct;
