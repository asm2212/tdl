const con = require("../config/db");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const tdlSchema = new Schema(
    {
        userId: {
            type: Schema.Types.ObjectId,
            ref: "User" 
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

const tdlModel = con.model("Tdl", tdlSchema);
module.exports = tdlModel;
