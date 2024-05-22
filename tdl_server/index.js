const express = require("express");
const mongoose = require("mongoose");
const todoRoutes = require("./routes/todos.js");

const app = express();
const port = 3000;


mongoose.connect("mongodb://127.0.0.1:27017/tdl", {
  
})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Failed to connect to MongoDB:', err));

app.use(express.json());

app.use("/todos",todoRoutes)

app.listen(port, () => {
  console.log(`Server running at ${port}`);
});
