import Retailer from "./Retailer";
import RetailerInfoForm from "./RetailerInfoForm";
import { useState } from "react";
import Button from "./Button";
import Signup from "./Signup";
import Login from "./Login";
import ReatailerTable from "./RetailerTable";
const RetailerPage =()=>{
    const [userStatus,setUserStatus]=useState(false);
    const [bp,setbp]=useState(false);
    const [isSignup,setSignup]=useState(false);
    const [isLogin,setLogin]=useState(false);
    const [userLogin,setUserLogin]=useState(false);
    const handleRetailerSignup = ()=>{
        setSignup(true);
        setbp(false);
    }
    const handleRetailerLogin = ()=>{
        setLogin(true);
    }
    const handlebp = ()=>{
        setbp(true);
         
    }
    const   handleUserSignup = ()=>{
        setUserStatus(true);
        setSignup(false);
    }
    return(
        <div>

        {(((!userStatus && !isSignup) || bp) && !isLogin)&&<div> 
            <Button onclick={handleRetailerSignup} content = "SignUp" />
            </div>

}
{(((!isLogin || !userLogin) && !userStatus )|| bp) ? <Button onclick={handleRetailerLogin} content = "Login" /> : <div>jeet </div>}
{/* {(!isLogin && !isSignup ) && (!userStatus && (!userLogin && !bp))&& <Button onclick={handleRetailerLogin} content = "Login" />} */}
{/* {!isLogin && bp && <div>Retailer account form the email-id already exists</div>} */}
{isSignup && !isLogin && <Signup checkSignup={handleUserSignup} checkbp = {handlebp} /> }
{isLogin && <Login /> }
{userLogin && 
<ReatailerTable />
}

        {userStatus && !bp && !isSignup && <Retailer />} 
        </div>
    );
}
export default RetailerPage;