const express = require("express")
const cors = require("cors");
const app = express();
app.use(cors());
app.use(express.urlencoded({ extended: false }));
const jsonParser = express.json();
app.use(jsonParser);


app.post('/add',(req,res)=>{
    res.json(req.body);
    console.log(req.body);
})


app.listen((5000),()=>{
console.log("Conned to port 5000");
});