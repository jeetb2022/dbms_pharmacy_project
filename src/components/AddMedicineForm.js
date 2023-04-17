import { useState } from "react";
import axios from "axios";
import './AddMedicineForm.css'
const AddMedicineFrom = (props)=>{
    const handleSubmit =  (event) => {
        event.preventDefault();
          clickHandler();
      }  
      const clickHandler = () => {
        props.onCancel();
      }
        const [name, setName] = useState("");
        const nameChangeHandler = (ele) => {
          setName(ele.target.value);
        };
        const [quantity, setQuantity] = useState("");
        const quantityChangeHandler = (ele) => {
          setQuantity(ele.target.value);
        };
        const [price, setPrice] = useState("");
        const priceChangeHandler = (ele) => {
          setPrice(ele.target.value);
        };
        const [x, setx] = useState("");
        const xChangeHandler = (ele) => {
          setx(ele.target.value);
        };
    return (
        <div>
        <div className="backdrop" onClick={clickHandler}>
        </div>
        <div className="box">
          <h1>Add Medicine</h1>
          <form onSubmit={handleSubmit}>
            <label className="box-inside">
              Medicine Name:<br></br>
              <input type="text" name="name" value={name} onChange={nameChangeHandler} />
            <br></br>
            </label>
            <label className="box-inside">
              Wholesaler Name:<br></br>
              <input type="text" name="name" value={name} onChange={nameChangeHandler} />
            <br></br>
            </label>
            <label className="box-inside">
              Medicine Quantity:<br></br>
              <input type="text" name="Quantity" value={quantity} onChange={quantityChangeHandler} />
              <br></br>
            </label >
            <label className="box-inside">
              Price:<br></br>
              <input type="number" name="Price" value={price} onChange={priceChangeHandler} />
            </label >
            <br></br>
            <label className="box-inside">
              x :<br></br>
              <input type="text" name="x" value={x} onChange={xChangeHandler} />
            </label >
            <br></br>
             <button style={{ margin: "8px" }} type='submit' >ADD</button> 
          </form>
        </div>
      </div>
    );
};
export default AddMedicineFrom;