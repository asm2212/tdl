const UserService = require("../services/userService.js");

const bcrypt = require('bcrypt');

exports.register = async(req, res, next) => {
    try {
        const { email, password } = req.body;
        const duplicate = await UserService.getUserByEmail(email); 
        if (duplicate) {
            return res.status(400).json({ message: 'User already exists' });
        }
        const successResponse = await UserService.userRegister(email, password);
        res.json(successResponse);
    } catch (error) {
        res.status(500).json({ message: error.message });
        next(error);
    }
};

exports.login = async(req, res, next) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).json({ message: 'Please enter email and password' });
        }
        let user = await UserService.checkUser(email);
        if (!user) {
            return res.status(400).json({ message: 'User does not exist' });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Incorrect password' });
        }
      
        res.json({ message: 'Login successful' });
    } catch (error) {
        res.status(500).json({ message: error.message });
        next(error);
    }
};
