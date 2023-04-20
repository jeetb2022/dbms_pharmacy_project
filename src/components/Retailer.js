import RetailerInfoForm from "./RetailerInfoForm";
import { useState, useEffect } from "react";
import './Table.css';
import axios from "axios";
import ReatailerTable from "./RetailerTable";
const Retailer = () => {
    const [retailerData, setRetailerData] = useState([]);
    // useEffect(() => {
       
     fetch('http://localhost:5000/api/retailData')
            .then((res) => res.json())
            .then((jsonres) => setRetailerData(jsonres));
    // }, []);
    const [isLogined, setLoginStatus] = useState(false);
    const handleLogin = () => {
        setLoginStatus(true);
    }
    return (
        <div>

            {!isLogined && <RetailerInfoForm isLogined={handleLogin} />}
            {isLogined && <ReatailerTable />}


        </div>
    );
}
export default Retailer;