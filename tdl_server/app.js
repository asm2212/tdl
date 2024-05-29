const express = require("express");
const bodyParser = require("body-parser");
const userRouter = require("./routes/userRoute.js");
const tdlRouter = require("./routes/tdlRoute.js");

const app = express();

app.use(bodyParser.json());
app.use("/user", userRouter);
app.use("/tdl", tdlRouter);


module.exports = app;
