import { GridColDef } from "@mui/x-data-grid";
import "./add.scss";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import Cookies from "js-cookie";
import React, { useState } from "react";

type Props = {
  slug: string;
  columns: GridColDef[];
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
};

const Add = (props: Props) => {
  const [formValues, setFormValues] = useState({
    ten_san_pham: "",
    ma_loai_xe: "",
    hang_xe: "",
    gia: "",
    gia_khuyen_mai: "",
    anh_dai_dien: "",
  });

  const queryClient = useQueryClient();

  const addProduct = useMutation({
    mutationFn: (newProduct: typeof formValues) => {
      return fetch("http://localhost:8000/products", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${Cookies.get("access_token")}`,
        },
        body: JSON.stringify(newProduct),
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries([`all${props.slug}`]);
    },
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
  
    setFormValues({
      ...formValues,
      [name]: name === "ma_loai_xe" || name === "gia" || name === "gia_khuyen_mai"
        ? value === "" ? "" : Number(value) // Chuyển đổi sang số
        : value,
    });
  };

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    console.log("Dữ liệu gửi đi:", formValues);
    addProduct.mutate(formValues);
    props.setOpen(false);
  };

  return (
    <div className="add">
      <div className="modal">
        <span className="close" onClick={() => props.setOpen(false)}>
          X
        </span>
        <h1>Add new {props.slug}</h1>
        <form onSubmit={handleSubmit}>
        <div className="item">
            <label>Mã loại xe</label>
            <input
              type="number"
              name="ma_loai_xe"
              value={formValues.ma_loai_xe}
              onChange={handleChange}
              placeholder="Mã loại xe"
            />
          </div>
          <div className="item">
            <label>Ảnh đại diện</label>
            <input
              type="text"
              name="anh_dai_dien"
              value={formValues.anh_dai_dien}
              onChange={handleChange}
              placeholder="URL ảnh đại diện"
            />
          </div>
          <div className="item">
            <label>Tên sản phẩm</label>
            <input
              type="text"
              name="ten_san_pham"
              value={formValues.ten_san_pham}
              onChange={handleChange}
              placeholder="Tên sản phẩm"
            />
          </div>
          <div className="item">
          <label>Hãng Xe:</label>
          <input
            type="text"
            name="hang_xe"
            value={formValues.hang_xe}
            onChange={handleChange}
            placeholder="Hãng xe"
            />
          </div>
          <div className="item">
            <label>Giá</label>
            <input
              type="number"
              name="gia"
              value={formValues.gia}
              onChange={handleChange}
              placeholder="Giá sản phẩm"
            />
          </div>
          <div className="item">
            <label>Giá khuyến mãi</label>
            <input
              type="number"
              name="gia_khuyen_mai"
              value={formValues.gia_khuyen_mai}
              onChange={handleChange}
              placeholder="Giá khuyến mãi"
            />
          </div>
          <button type="submit">Gửi</button>
        </form>
      </div>
    </div>
  );
};

export default Add;
