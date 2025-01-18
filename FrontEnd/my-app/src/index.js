import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './container/App';
import reportWebVitals from './container/reportWebVitals.js';
import { Provider } from "react-redux"; // Import Provider từ react-redux
import store from "./Components/User/redux/store.js"; // Import Redux store

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    {/* Bọc ứng dụng trong Provider để kết nối với Redux store */}
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>
);

// Nếu bạn muốn đo lường hiệu suất ứng dụng, sử dụng hàm log hoặc gửi kết quả đến endpoint phân tích
reportWebVitals();
