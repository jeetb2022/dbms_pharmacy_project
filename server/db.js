const Pool = require('pg').Pool;
require('dotenv').config()

// const pass = toString(process.env.pass);
const pool = new Pool({
    user : "postgres",
    password : process.env.pass,
    host:"localhost",
    port : 5432,
    database : "DBByJeet"
});

module.exports = pool; 