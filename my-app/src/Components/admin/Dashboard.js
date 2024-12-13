import React from "react";
import { Card, CardContent, Typography } from "@material-ui/core";

const Dashboard = () => {
  return (
    <div>
      <Card>
        <CardContent>
          <Typography variant="h5">Dashboard</Typography>
          <Typography>
            Quản lý sản phẩm, người dùng, và đơn hàng ở đây.
          </Typography>
        </CardContent>
      </Card>
    </div>
  );
};

export default Dashboard;
