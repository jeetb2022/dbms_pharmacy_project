import RetailerInfoForm from "./RetailerInfoForm";
import { useState, useEffect } from "react";
import './Table.css';
import axios from "axios";
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
            {isLogined && <table>
                <tbody>

                    <tr>
                        <th>Id</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Phone Number</th>
                        <th>ShopName</th>
                        <th>ShopAddress</th>

                    </tr>
                    {
                        retailerData.map((data) => {
                            return (
                                <tr key={data.ret_id}>
                                    {/* <td><input type="checkbox" id={data.ret_id}></input></td> */}
                                    <td>{data.ret_id}</td>
                                    <td>{data.ret_fname}</td>
                                    <td>{data.ret_lname}</td>
                                    <td>{data.ret_phone_number}</td>
                                    <td>{data.ret_shopname}</td>
                                    <td>{data.ret_shop_address}</td>
                                    {/* <td><button  id={data._id} onClick={checkboxUpdateHandler}>Update</button></td>
                <td><button id={data._id} onClick={checkboxDeleteHandler}>Delete</button></td> */}
                                </tr>
                            )

                        })
                    }
                </tbody>

            </table>}


        </div>
    );
}
export default Retailer;