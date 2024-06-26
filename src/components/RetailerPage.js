import Retailer from "./Retailer";
import RetailerInfoForm from "./RetailerInfoForm";
import { useState } from "react";
import Button from "./Button";
import Signup from "./Signup";
import Login from "./Login";
import login from './images/login.png';
import signup from './images/signup.png';
import ReatailerTable from "./RetailerTable";
import './dhanashri.css';
const RetailerPage = () => {
    const [userStatus, setUserStatus] = useState(false);
    const [bp, setbp] = useState(false);
    const [isSignup, setSignup] = useState(false);
    const [isLogin, setLogin] = useState(false);
    const [userLogin, setUserLogin] = useState(false);
    const handleRetailerSignup = () => {
        setSignup(true);
        setbp(false);
    }
    const handleRetailerLogin = () => {
        setLogin(true);
    }
    const handlebp = () => {
        setbp(true);

    }
    const handleUserSignup = () => {
        setUserStatus(true);
        setSignup(false);
    }
    return (
        <div>

            {(((!userStatus && !isSignup) || bp) && !isLogin) && <div>
                <div className="signupimg">
                    <img src={signup} />
                </div>
                <div className="signup">
                    <Button onclick={handleRetailerSignup} content="SignUp" />
                </div>
            </div>


            }
            {/* <div className="sigimg"><img src={login} /></div> */}
            {(((!isLogin || !userLogin) && !userStatus && !isSignup) || bp) ? 
            <div>
                <div className="loginimg">
                    <img src={login} />
                </div>
            <div className="login_d"><Button onclick={handleRetailerLogin} content="Login" /> </div>
            </div>
             : <div></div>}
            {/* {(!isLogin && !isSignup ) && (!userStatus && (!userLogin && !bp))&& <Button onclick={handleRetailerLogin} content = "Login" />} */}
            {/* {!isLogin && bp && <div>Retailer account form the email-id already exists</div>} */}
            {(isSignup && !isLogin) && <Signup checkSignup={handleUserSignup} checkbp={handlebp} />}
            {isLogin && <Login />}
            {userLogin &&
                <ReatailerTable />
            }

            {userStatus && !bp && !isSignup && <Retailer />}
        </div>
    );
}
export default RetailerPage;