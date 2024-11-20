    import './App.scss';

    import Home from './Composnets/Home/Home';
    import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
    import Login from './Composnets/Home/Login';
    import Register from './Composnets/Home/Register';
    import Honda from './Composnets/Home/honda';
    import More from './Composnets/Home/readmore'


    function App() {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/login" element={<Login />} />
                <Route path = "/register" element={<Register/>}/>
                <Route path = "/honda" element = {<Honda/>}/>
                <Route path = "/readmore" element = {<More/>}/>
            </Routes>
        </Router>
    );
    };
    export default App;
