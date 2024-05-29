const tdlRouter = require("express").Router();
const tdlController = require("../controller/tdlController");

tdlRouter.post("/createTdl", tdlController.createTdl);