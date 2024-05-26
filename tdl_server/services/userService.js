const UserModel = require("../model/userModel");

class UserService {
    static async userRegister(email,password){
        try {
            const createUser = new UserModel({email,password});
            return await createUser.save();
        } catch (error) {
        }
     
    }
}

module.exports = UserService;