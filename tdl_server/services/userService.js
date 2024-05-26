const UserModel = require("../model/userModel");
const bcrypt = require('bcrypt');

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
}

module.exports = UserService;
