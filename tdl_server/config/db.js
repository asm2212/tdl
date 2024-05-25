const mongoose = require("mongoose");


const con = mongoose.connect("mongodb://127.0.0.1:27017/tdl", {
  
})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Failed to connect to MongoDB:', err));

module.exports = con;