    import './App.scss';

    import Home from './Components/Home/Home';
    import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
    import Login from './Components/Home/Login/Login';
    import Register from './Components/Home/Register';
    import Honda from './Components/Home/ListProduct/ListProduct';
    import More from './Components/Home/ViewProduct/ViewProduct';
    import Header from './Components/Home/Header/Header';
    import Footer from './Components/Home/Footer/Footer';
    function App() {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Home/>} />
                <Route path="/login" element={<Login />} />
                <Route path = "/register" element={<Register/>}/>
                <Route path = "/honda" element = {<Honda/>}/>
                <Route path = "/readmore" element = {<More/>}/>
                <Route path = "/header" element = {<Header/>}/>
                <Route path = "/footer" element = {<Footer/>}/>
            </Routes>
        </Router>
    );
    };
    export default App;
