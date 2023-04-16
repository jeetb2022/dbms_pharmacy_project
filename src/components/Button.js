import './Button.css'
const Button = (props)=>{

    return (
        <button className='button_medicine' onClick={()=>{props.onclick()}}>{props.content}</button>
    );
}
export default Button;