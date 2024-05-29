const tdlModel = require("../model/tdlModel");

class TdlService {
    static async createTdl(userId, title, description) {
        try {
            const createTdl = new tdlModel({ userId, title, description });
            return await createTdl.save();
        } catch (error) {
            throw error;
        }
    }

    static async getUserTdl(userId) {
        try {
            const userTdl = await tdlModel.find({ userId });
            return userTdl;
        } catch (error) {
            throw error;
        }
    }

    static async deleteTdl(id) {
        try {
            const deleteTdl = await tdlModel.findByIdAndDelete(id);
            return deleteTdl;
        } catch (error) {
            throw error;
        }
    }
}

module.exports = TdlService;
