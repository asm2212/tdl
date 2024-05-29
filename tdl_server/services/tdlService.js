const tdlModel = require("../model/tdlModel");

class TdlService{
    static async createTdl(userId,title,description){
        try {
            const createTdl = new tdlModel({userId,title,description});
            return await createTdl.save();
        } catch (error) {
            throw error;
        }
    }
}

module.exports = TdlService;