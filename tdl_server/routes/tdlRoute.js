const express = require("express");
const tdlController = require("../controller/tdlController");

const tdlRouter = express.Router();

tdlRouter.post("/createTdl", tdlController.createTdl);
tdlRouter.get("/getTdl", tdlController.getTdl);
tdlRouter.delete("/deleteTdl", tdlController.deleteTdl);

module.exports = tdlRouter;
