import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import UserApp from "./App"; // Import file App.js
import AdminApp from "../../../admin/src/App"; // Import file App.tsx (Admin)

function MainApp() {
  return (
    <Router>
      <Routes>
        {/* Giao diện người dùng */}
        <Route path="/*" element={<UserApp />} />

        {/* Giao diện admin */}
        <Route path="/admin/*" element={<AdminApp />} />
      </Routes>
    </Router>
  );
}

export default MainApp;
