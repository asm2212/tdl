const userRouter = require("express").Router();
const userController = require("../controller/userController");

userRouter.post("/register", userController.register);

module.exports = userRouter;