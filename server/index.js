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

app.post('/addMeds',async(req,res)=>{
        res.json(req.body);
        console.log(req.body);
        
})
app.post('/retailInfo',async(req,res)=>{
        console.log(req.body);
        let dataArray =[];
        
        const query = await client.query(
            "INSERT INTO retailer_details (ret_fname, ret_lname,ret_shopname,ret_shop_address, ret_phone_number,ret_email,ret_password) VALUES($1,$2,$3,$4,$5,$6,$7) RETURNING *",
            [...req.body,'jeet@gmail.com','jeetjeet']
            );
            // fname, lname,shopname,shopaddress, phone

            res.json(req.body);
})

app.get('/add/:id',async(req,res)=>{
    const req_id = req.params.id;
    const query = await client.query(
        "SELECT * FROM wholesaler_details WHERE w_fname=$1",[
            req_id
        ]
        );
        res.json(query.rows);
    })

app.listen((5000),()=>{
console.log("Conned to port 5000");
});