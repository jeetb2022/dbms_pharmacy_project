import Button from './Button';
import './forms.css';
const Signup = () => {
    const submitHandler = () => {

    }
    return (
        <div className='body'>
            <div class="login">
                <h2>Signup Page</h2>
                <form id="login"  method="post" action="/signupAsRetailer" >
                    <label><b>Email:
                    </b>
                    </label>
                    <input type="email" name="Uname" id="Uname" placeholder="Email" />
                    <br></br>
                        <label><b>Password:
                        </b>
                        </label>
                        <input type="Password" name="Pass" id="Pass" placeholder="Password" />
                        <br></br>
                        <label><b>Repeat Password:
                        </b>
                        </label>
                        <input type="Password" name="Pass" id="Pass" placeholder="Password" />
                        <br></br>
                        <input type="button" name="log" id="log" value="Signup Here" />
                        <br></br>
                        </form>
                        </div>
                    </div>
                    );
}

                    export default Signup;