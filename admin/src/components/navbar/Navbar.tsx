import "./navbar.scss";

const Navbar = () => {
  return (
    <div className="navbar">
      <div className="logo">
        <img src="logo.svg" alt="" />
        <span>Admin</span>
      </div>
      <div className="icons">
        <img src="/search.svg" alt="" className="icon" />
        <img src="/app.svg" alt="" className="icon" />
        <img src="/expand.svg" alt="" className="icon" />
        <div className="notification">
          <img src="/notifications.svg" alt="" />
          <span>1</span>
        </div>
        <div className="user">
          <img
            src="https://scontent.fthd1-1.fna.fbcdn.net/v/t39.30808-6/472263006_475292452282652_7625874161035027382_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeH1ksGZSuqUnbMjDtpXsJXLJGH6XeqwTs4kYfpd6rBOzjJe6C3A2aD7HUxa_6oEv-X_CHEnXPeX2--BR9APiShW&_nc_ohc=cDIeUiICXl8Q7kNvgECtWKp&_nc_zt=23&_nc_ht=scontent.fthd1-1.fna&_nc_gid=AyM8kLn0OJFzniLbHvuSRWx&oh=00_AYBoL1_a_LeZcAyFo7qyJneAxFbN6abKxx_y0_DUEAomgQ&oe=678036BE"
            alt=""
          />
          <span>Đăng</span>
        </div>
        <img src="/setting.svg" alt="" className="icon" />
      </div>
    </div>
  );
};

export default Navbar;
