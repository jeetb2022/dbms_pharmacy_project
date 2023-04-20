import axios from 'axios';
import Button from './Button';
import './forms.css';
import { useState } from 'react';
const Signup = (props) => {
    const [email, setemail] = useState('');
    const emailchangeHandler = (ele) => {
        setemail(ele.target.value);
    }
    const [pass, setpass] = useState('');
    const passchangeHandler = (ele) => {
        setpass(ele.target.value);
    }
    const [error,setErrorStatus]=useState(false);
    const submitHandler = async (event) => {
        event.preventDefault();
        try {
            await axios.post('http://localhost:5000/checksignup', { email: email });
          await  props.checkSignup();
        } catch (error) {
            console.log('errrr mf');
            event.preventDefault();
            setErrorStatus(true);
            // await props.checkbp();
            // await  props.checkSignup();
            // window.location.replace('http://localhost:3000/');
        }
    }


return (
    <div className='body'>
        <div class="login">
            <h2>Signup Page</h2>
            <form id="login" method="post" onSubmit={submitHandler}>
                <label><b>Email:
                </b>
                </label>
                <input type="email" name="Uname" id="Uname" placeholder="Email" onChange={emailchangeHandler} />
                <br></br>
                <label><b>Password:
                </b>
                </label>
                <input type="Password" name="Pass" id="Pass" placeholder="Password" onChange={passchangeHandler} />
                <br></br>
                <label><b>Repeat Password:
                </b>
                </label>
                <input type="Password" name="Pass" id="Pass" placeholder="Password" />
                <br></br>
                <button style={{ margin: "8px" }} type='submit' >SignUp</button>                        <br></br>
            </form>
        </div>
        {error && <div style={{padding:'10px'}}>Retailer account form the email-id already exists</div>}
    </div>
);

}

export default Signup;