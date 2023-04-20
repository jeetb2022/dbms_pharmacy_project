import './Button.css'
const Button = (props)=>{
const handleClick = ()=>{
    props.onclick();
}
    return (
        <button className='button_medicine' onClick={handleClick}>{props.content}</button>
    );
}
export default Button;