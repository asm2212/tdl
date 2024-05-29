const con = require("../config/db");
const UserModel = require("../model/userModel");
const mongoose = require("mongoose");
const {Schema} = mongoose;

const tdlSchema = new Schema (
    {
        userId: {
            type: Schema.Types.ObjectId,
            ref: UserModel.modelName 
        },
        title: {
            type: String,
            required: true
        },
        description: {
            type: String,
            required: true
        },

    },
    {
        timestamps: true
    }
);

const tdlModel = con.model("tdl",tdlSchema);
module.exports = tdlModel;
