import './App.css';
import { useState } from 'react';
import AddMedicineFrom from './components/AddMedicineForm';
import Button from './components/Button';
import Login from './components/Login';
import Signup from './components/Signup';
import RetailerInfoForm from './components/RetailerInfoForm';
import Retailer from './components/Retailer';
import retimg from './components/images/photor.png';
import whimg from './components/images/photow.png';
import RetailerPage from './components/RetailerPage';
import './components/dhanashri.css'
const  App = ()=> {
  const [formIsVisible, setFormVisibitlity] = useState(true);
  const [RetailerFormIsVisible, setRetailerFormIsVisible] = useState(false);

  const handleClick = () => {
    setFormVisibitlity(!formIsVisible);
  }
  const handleRetailer = () => {
    setRetailerFormIsVisible(!RetailerFormIsVisible);
  }
  return (
    <div className="App">
     {/* <h1>DBMS database</h1>
     <h2>Hello Shefali</h2>
     <h3>By Jeet Bhadaniya, Het Prajapati, Kushal Patel, Dhanashri Wala</h3>
     <Button onclick={handleClick} content = "Add Medicines"></Button> */}
     {formIsVisible && <AddMedicineFrom onCancel={handleClick} />}
     {!RetailerFormIsVisible &&<div>
      <div className='retimg'>
<img src={retimg} alt='logo'></img>
</div>
<div className='whimg'>
<img src={whimg} alt='logo'></img>
</div>
      <div className='retailer' onClick={handleRetailer}> <Button onclick={handleRetailer} content = "Retailer"/></div>
     </div> }
     {!RetailerFormIsVisible && <div className='wholesaler'> <Button onclick={handleClick} content = "Wholesaler"/></div>}
     {RetailerFormIsVisible && <RetailerPage />}
     
    </div>
   
  );
}

export default App;
