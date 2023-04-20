import Button from './Button';
import './forms.css';
import { useState } from 'react';
const Login = () => {
    const [retailerData, setRetailerData] = useState([]);
    fetch('http://localhost:5000/api/retailData')
    .then((res) => res.json())
    .then((jsonres) => setRetailerData(jsonres));
    const [email, setemail] = useState('');
    const emailchangeHandler = (ele) => {
        setemail(ele.target.value);
    }
    const [pass, setpass] = useState('');
    const passchangeHandler = (ele) => {
        setpass(ele.target.value);
    }
    const submitHandler = async (event) => {
        event.preventDefault();
        try {
            // await axios.post('http://localhost:5000/', { email: email,password : pass });
        } catch (error) {
            console.log('errrr mf');
            // window.location.replace('http://localhost:3000/');
        }
    }
    return (
        <div className='body'>

            <div className="login">
                <h2>Login Page</h2>
                <form id="login" method="post">
                    <label><b>Email:
                    </b>
                    </label>
                    <br></br>
                    <input type="email" name="Uname" id="Uname" placeholder="Email"onChange={emailchangeHandler} />
                    <br></br>
                    <label><b>Password:
                    </b>
                    </label>
                    <input type="Password" name="Pass" id="Pass" placeholder="Password" onChange={passchangeHandler} />
                   <br></br>
                    <button style={{ margin: "8px" }} type='submit' >ADD</button>
                </form>
            </div>
        </div>
    );
}

export default Login;