import Retailer from "./Retailer";
import RetailerInfoForm from "./RetailerInfoForm";
import { useState } from "react";
import Button from "./Button";
import Signup from "./Signup";
const RetailerPage =()=>{
    const [userStatus,setUserStatus]=useState(false);
    const [bp,setbp]=useState(false);
    const [isSignup,setSignup]=useState(false);
    const handleRetailerSignup = ()=>{
        setSignup(true);
        setbp(false);
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

        {((!userStatus && !isSignup) || bp )&&<div> 
            <Button onclick={handleRetailerSignup} content = "SignUp" />
            {/* <Button onclick={handleRetailer} content = "Login" /> */}
            </div>

}
{bp && <div>retailer account form the email-id already exists</div>}
{isSignup && <Signup checkSignup={handleUserSignup} checkbp = {handlebp}/> }

        {userStatus && !bp && !isSignup && <Retailer />}
        </div>
    );
}
export default RetailerPage;