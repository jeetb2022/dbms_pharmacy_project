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

// ALTER TABLE retailer_details DROP COLUMN r_email;
// ALTER TABLE retailer_email_id DROP CONSTRAINT retailer_email_id_pkey;
// CREATE OR REPLACE FUNCTION _retailer_email_exists()
// RETURNS TRIGGER AS $$
// BEGIN 
//     IF EXISTS (SELECT 1 FROM retailer_email_id WHERE r_email = NEW.r_email) THEN
//         RAISE EXCEPTION 'retailer account form the email-id already exists';
//     END IF;
//     RETURN NEW;
// END;
// $$ LANGUAGE plpgsql;

// CREATE TRIGGER _enforce_r_email_check
// BEFORE INSERT ON retailer_email_id
//     FOR EACH ROW EXECUTE FUNCTION _retailer_email_exists();
// ALTER TABLE retailer_details ADD COLUMN r_email VARCHAR;
app.listen((5000),()=>{
console.log("Conned to port 5000");
});