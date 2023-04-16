import './App.css';
import { useState } from 'react';
import AddMedicineFrom from './components/AddMedicineForm';
import Button from './components/Button';
const  App = ()=> {
  const [formIsVisible, setFormVisibitlity] = useState(true);
  const handleClick = () => {
    setFormVisibitlity(!formIsVisible);
  }
  return (
    <div className="App">
     <h1>DBMS database</h1>
     <h2>Hello Shefali</h2>
     <h3>By Jeet Bhadaniya, Het Prajapati, Kushal Patel, Dhanashri Wala</h3>
     <Button onclick={handleClick} content = "Add Medicines"></Button>
     {formIsVisible && <AddMedicineFrom onCancel={handleClick} />}
    </div>
  );
}

export default App;
