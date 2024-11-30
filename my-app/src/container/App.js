
    import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
    import Home from '../Components/Home/Homepage/Home';
    import Login from '../Components/Home/Login/Login';
    import Register from '../Components/Home/Register/Register';
    import ListProduct from '../Components/Home/ListProduct/ListProduct';
    import  ViewProduct from  '../Components/Home/ViewProduct/ViewProduct';
    import Header from '../Components/Home/Header/Header';
    import Footer from '../Components/Home/Footer/Footer';
    import './App.scss';
    function App() {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Home/>} />
                <Route path="/login" element={<Login />} />
                <Route path = "/register" element={<Register/>}/>
                <Route path = "/listProduct" element = {<ListProduct/>}/>
                <Route path = "/viewProduct" element = {<ViewProduct/>}/>
                <Route path = "/header" element = {<Header/>}/>
                <Route path = "/footer" element = {<Footer/>}/>
            </Routes>
        </Router>
    );
    };
    export default App;
