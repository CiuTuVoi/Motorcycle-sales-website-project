import React from 'react';
import { Admin, Resource } from 'react-admin';
import simpleRestProvider from 'ra-data-simple-rest';

const dataProvider = simpleRestProvider('http://localhost:3000');

const productsResource = Resource({
    name: 'products',
    list: () => <div>Product List</div>, // Thay thế bằng component danh sách
});

const AdminPage = () => (
    <Admin dataProvider={dataProvider} resources={[productsResource]} />
);

export default AdminPage;
