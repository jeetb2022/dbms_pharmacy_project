const Button = (props)=>{

    return (
        <button onClick={()=>{props.onclick()}}>{props.content}</button>
    );
}
export default Button;