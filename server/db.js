const Pool = require('pg').Pool;
require('dotenv').config()
const {Client} = require('pg');

// const pass = toString(process.env.pass);
const pool = new Pool({
    user : "postgres",
    password : process.env.pass,
    host:"localhost",
    port : 5432,
    database : "test"
});

module.exports = pool; 