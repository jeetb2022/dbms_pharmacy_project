import Button from './Button';
import './forms.css';
const Login = () => {
    const submitHandler = () => {

    }
    return (
        <div className='body'>

            <div className="login">
                <h2>Login Page</h2>
                <form id="login" method="post" action="/loginAsRetailer" >
                    <label><b>Email:
                    </b>
                    </label>
                    <br></br>
                    <input type="email" name="Uname" id="Uname" placeholder="Email" />
                    <br></br>
                    <label><b>Password:
                    </b>
                    </label>
                    <input type="Password" name="Pass" id="Pass" placeholder="Password" />
                   <br></br>
                    <button style={{ margin: "8px" }} type='submit' >ADD</button>
                </form>
            </div>
        </div>
    );
}

export default Login;