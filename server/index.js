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
app.get('/api/retailData',async(req,res)=>{
    const req_id = req.params.id;
    const query = await client.query(
        "SELECT * FROM retailer_details"
        );
        res.json(query.rows);
    })

app.post('/checksignup',async(req,res)=>{
    console.log(req.body.email);
    try {
         const query = await client.query(
            "INSERT INTO retailer_email_id (ret_email,ret_password)VALUES($1,$2)",[
                req.body.email,'dndj'
            ]
            );
            res.json(req.body);
    } catch (error) {
        res.status(404).json('ERRor mf');
        console.log(error);
    }
})
app.post('/checklogin',async(req,res)=>{
    console.log(req.body.email);
    console.log(req.body.password);
    // try {
        const query = await client.query(
            "SELECT check_retailer_login_credentials($1,$2)",[
                req.body.email,req.body.password
            ]
            );
            console.log(query.rows[0].check_retailer_login_credentials);
            if(query.rows[0].check_retailer_login_credentials === true){
                res.json(req.body);
            }
            else{
                res.status(404).json('errror mf');
            }
})

app.listen((5000),()=>{
console.log("Conned to port 5000");
});