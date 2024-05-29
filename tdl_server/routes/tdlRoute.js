const tdlRouter = require("express").Router();
const tdlController = require("../controller/tdlController");

tdlRouter.post("/createTdl", tdlController.createTdl);
tdlRouter.get("/getTdl", tdlController.getTdl);

module.exports = tdlRouter;