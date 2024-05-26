const mongoose = require("mongoose");

const con = mongoose.createConnection("mongodb://127.0.0.1:27017/tdl", {
    
});

con.once('open',() =>{
    console.log("connected to mongodb");
});

con.on('error',(error) => {
    console.error("mongodb connection error:",error);
});

module.exports = con;