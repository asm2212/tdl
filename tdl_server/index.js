const express = require("express");
const mongoose = require("mongoose");

const app = express();
const port = 3000;

mongoose.connect("mongodb://localhost:27017/tdl", {
  
});

mongoose.connect("mongodb://localhost:27017/tdl", {
  
})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Failed to connect to MongoDB:', err));

app.use(express.json());

app.listen(port, () => {
  console.log(`Server running at ${port}`);
});
