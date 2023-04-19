import Button from './Button';
import './forms.css';
import axios from 'axios';
import { useState } from 'react';
const RetailerInfoForm = () => {
    
    const submitHandler = (event) => {
        event.preventDefault();
        axios.post('http://localhost:5000/retailInfo',{
            f_name : fname,
            l_name : lname,
            shopname : shopname,
            shopaddress : shopaddress,
            phone : phone
        });
    }
    const [fname,setFname]= useState('');
    const fnameChangeHandler = (ele) => {
        setFname(ele.target.value);
    }
    const [lname,setLname]= useState('');
    const lnameChangeHandler = (ele) => {
        setLname(ele.target.value);
    }
    const [shopname,setShopname]= useState('');
    const shopnameChangeHandler = (ele) => {
        setShopname(ele.target.value);
    }
    const [shopaddress,setShopaddress]= useState('');
    const shopaddressChangeHandler = (ele) => {
        setShopaddress(ele.target.value);
    }
    const [phone, setPhone] = useState('');
    const phoneChangeHandler = (ele) => {
      setPhone(ele.target.value);
    };
    return (

        <div className='body'>
            <div class="login">
                <h2>Retailers Information</h2>
                <form id="login"  method="post" onSubmit={submitHandler} >
                    <label for="fname">First Name:</label><br></br>
                    <input type="text" id="fname" name="firstname" placeholder="Your name" onChange={fnameChangeHandler} />
                    <br></br>
                    <label for="fname">Last Name:</label><br></br>
                    <input type="text" id="fname" name="lastname" placeholder="Your name" onChange={lnameChangeHandler} />
                    <br></br>
                    <label for="pnum">Phone Number:</label><br></br>
                    <input type="text" id="pnum" name="pnum" placeholder="number" onChange={phoneChangeHandler} />
                    <br></br>
                    <label for="adr"><i class="add"></i> Shop Name:</label><br></br>
                    <input type="text" id="adr" name="name" placeholder="name" onChange={shopnameChangeHandler} />
                    <br></br>
                    <label for="adr"><i class="add"></i> Shop Address:</label><br></br>
                    <input type="text" id="adr" name="address" placeholder="address"onChange={shopaddressChangeHandler} />
                    <br></br>
                    <button style={{ margin: "8px" }} type='submit' onSubmit={submitHandler}>ADD</button>
                </form>
            </div>
        </div>
    );
}

export default RetailerInfoForm;