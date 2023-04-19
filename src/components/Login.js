const Login =()=>{
    const submitHnadler =()=>{

    }
return (
    <form id="login" method="post" action="/loginAsRetailer" >
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
        <input type="button" name="log" id="log" value="Log In Here" />
        <br></br>
        <input type="checkbox" id="check" />
        <span>Remember me</span>
        
    </form>
);
}

export default Login;