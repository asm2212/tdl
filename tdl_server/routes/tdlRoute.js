const tdlRouter = require("express").Router();
const tdlController = require("../controller/tdlController");

tdlRouter.post("/createTdl", tdlController.createTdl);
tdlRouter.get("/getTdl", tdlController.getTdl);
tdlRouter.delete("/deleteTdl",tdlController.deleteTdl);

module.exports = tdlRouter;