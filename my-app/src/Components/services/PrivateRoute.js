import React from "react";
import { Navigate } from "react-router-dom";

function PrivateRoute({ element }) {
  const isAdmin = localStorage.getItem("isAdmin");

  return isAdmin ? element : <Navigate to="/login" />;
}

export default PrivateRoute;
