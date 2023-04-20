import axios from 'axios';
import Button from './Button';
import './forms.css';
import { useState } from 'react';
    const Login = (props) => {
    const [email, setemail] = useState('');
    const emailchangeHandler = (ele) => {
        setemail(ele.target.value);
    }
    const [error,setError] = useState(false);
    const [pass, setpass] = useState('');
    const passchangeHandler = (ele) => {
        setpass(ele.target.value);
    }
    const submitHandler = async (event) => {
        event.preventDefault();
        // await axios.post('http://localhost:5000/checklogin', { email: email,password : pass });
        try {
            await axios.post('http://localhost:5000/checklogin', { email: email,password : pass });
            await props.onlogin();
        } catch (error) {
            console.log('errrr mf');
            event.preventDefault();
            setError(true);
        }
    }
    return (
        <div className='body'>
            {error && <div style={{padding:'10px', color:'red',fontSize:'20px'}}>Password or Email-id for Wholesaler is incorrect!</div>}
            <div className="login">
                <h2>Login Page</h2>
                <form id="login" method="post" onSubmit={submitHandler}>
                    <label><b>Email:
                    </b>
                    </label>
                    <br></br>
                    <input type="email" name="Uname" id="Uname" value={email} placeholder="Email" onChange={emailchangeHandler} />
                    <br></br>
                    <label><b>Password:
                    </b>
                    <br></br>
                    </label>
                    <input type="Password" name="Pass" id="Pass" value={pass} placeholder="Password" onChange={passchangeHandler} />
                   <br></br>
                    <button style={{ margin: "8px" }} type='submit' >ADD</button>
                </form>
            </div>
        </div>
    );
}

export default Login;