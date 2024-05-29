const UserModel = require("../model/userModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

class UserService {
    static async userRegister(email, password) {
        try {
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);
            const createUser = new UserModel({ email, password: hashedPassword });
            return await createUser.save();
        } catch (error) {
            throw new Error('Error registering user');
        }
    }

    static async getUserByEmail(email) {
        try {
            const user = await UserModel.findOne({ email });
            return user;
        } catch (error) {
            throw new Error('Error getting user by email');
        }
    }

    static async checkUser(email) {
        try {
            const user = await UserModel.findOne({ email });
            return user;
        } catch (error) {
            throw new Error('Error checking user');
        }
    }
}

module.exports = UserService;
