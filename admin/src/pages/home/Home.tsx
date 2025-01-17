import { useEffect } from "react";
import { useNavigate } from "react-router-dom"; // Import useNavigate thay vì useHistory
import "./home.scss";
import ChartBox from "../../components/chartBox/ChartBox";
import TopBox from "../../components/topBox/TopBox";
import {
  barChartBoxRevenue,
  barChartBoxVisit,
  chartBoxConversion,
  chartBoxProduct,
  chartBoxRevenue,
  chartBoxUser,
} from "../../data";
import BarChartBox from "../../components/barChartBox/BarChartBox";
import PieChartBox from "../../components/pieChartBox/PieChartBox";
import BigChartBox from "../../components/bigChartBox/BigChartBox";
import Cookies from "js-cookie";

const Home = () => {
  const navigate = useNavigate(); // Sử dụng useNavigate thay vì useHistory

  useEffect(() => {
    const token = Cookies.get("access_token")
    if (!token) {
      navigate("/login"); // Chuyển hướng đến trang login nếu không có token
    }
  }, [navigate]); // Lưu ý rằng bạn cần thêm navigate vào dependency array

  return (
    <div className="home">
      <div className="box box1">
        <TopBox />
      </div>
      <div className="box box2">
        <ChartBox {...chartBoxUser} />
      </div>
      <div className="box box3">
        <ChartBox {...chartBoxProduct} />
      </div>
      <div className="box box4">
        <PieChartBox />
      </div>
      <div className="box box5">
        <ChartBox {...chartBoxConversion} />
      </div>
      <div className="box box6">
        <ChartBox {...chartBoxRevenue} />
      </div>
      <div className="box box7">
        <BigChartBox />
      </div>
      <div className="box box8">
        <BarChartBox {...barChartBoxVisit} />
      </div>
      <div className="box box9">
        <BarChartBox {...barChartBoxRevenue} />
      </div>
    </div>
  );
};

export default Home;
