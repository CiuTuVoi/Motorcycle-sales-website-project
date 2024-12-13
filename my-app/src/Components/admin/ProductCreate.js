import React from "react";
import { Create, SimpleForm, TextInput, NumberInput } from "react-admin";

const ProductCreate = (props) => {
  return (
    <Create {...props}>
      <SimpleForm>
        <TextInput source="name" label="Tên sản phẩm" />
        <NumberInput source="price" label="Giá" />
        <TextInput source="category" label="Danh mục" />
      </SimpleForm>
    </Create>
  );
};

export default ProductCreate;
