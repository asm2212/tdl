const mongoose = require("mongoose");
const con = require("../config/db.js");

const {Schema} = mongoose;

const userSchema = new Schema({
    email: {
        type: String,
        lowercase: true,
        unique: true,
        required:true
    },
    password:{
      type: String,
      required:true
    }
})

const UserModel = con.model("User", userSchema);

module.exports = UserModel;