const UserService = require("../services/userService.js");

exports.register = async(req,res,next) => {
    try {
        const {email,password} = req.body;

        const successResponse = await UserService.userRegister(email,password);
        res.json(successResponse);
    } catch (error) {
        res.status(500).json({message: error.message});
    }
}
