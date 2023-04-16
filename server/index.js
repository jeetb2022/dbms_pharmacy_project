const express = require("express")
const cors = require("cors");
require('dotenv').config()
const client  = require('./db');
const app = express();
app.use(cors());
app.use(express.urlencoded({ extended: false }));
const jsonParser = express.json();
app.use(jsonParser);



app.post('/add',async(req,res)=>{
    const query = await client.query(
        "INSERT INTO person (id,name) VALUES($1,$2) RETURNING *",
        [req.body.intern_id,req.body.intern_name]
        );
        res.json(query.rows[0]);
})
app.get('/add',async(req,res)=>{
    const query = await client.query(
        "SELECT * FROM person;"
        );
        res.json(query.rows);
})

app.get('/add/:id',async(req,res)=>{
    const req_id = req.params.id;
    const query = await client.query(
        "SELECT * FROM person WHERE name=$1",[
            req_id
        ]
        );
        res.json(query.rows);
})



app.listen((8080),()=>{
console.log("Conned to port 5000");
});