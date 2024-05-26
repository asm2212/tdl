const mongoose = require("mongoose");

const con = mongoose.createConnection("mongodb://127.0.0.1:27017/tdl", {
  
});

module.exports = con;