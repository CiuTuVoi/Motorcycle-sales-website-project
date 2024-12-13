import React from "react";
import { Edit, SimpleForm, TextInput, NumberInput } from "react-admin";

const ProductEdit = (props) => {
  return (
    <Edit {...props}>
      <SimpleForm>
        <TextInput source="name" label="Tên sản phẩm" />
        <NumberInput source="price" label="Giá" />
        <TextInput source="category" label="Danh mục" />
      </SimpleForm>
    </Edit>
  );
};

export default ProductEdit;
