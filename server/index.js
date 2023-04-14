const express = require("express")
const cors = require("cors");
require('dotenv').config()
const pool  = require('./db');
const app = express();
app.use(cors());
app.use(express.urlencoded({ extended: false }));
const jsonParser = express.json();
app.use(jsonParser);


app.post('/add',(req,res)=>{
    res.json(req.body);
    console.log(req.body);
    const data = pool.query(
        "INSERT INTO person (id) VALUES($1)",
        [req.body.intern_id]
    );
})



app.listen((5000),()=>{
console.log("Conned to port 5000");
});