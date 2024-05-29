const express = require("express");
const bodyParser = require("body-parser");
const userRouter = require("./routes/userRoute.js");
const tdlRouter = require("./routes/userRoute.js");

const app = express();

app.use(bodyParser.json());
app.use("/",userRouter);
app.use("/",tdlRouter);

module.exports = app;