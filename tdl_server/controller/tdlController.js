const TdlService = require("../services/tdlService");
exports.createTdl = async(req,res,next)=> {
    try {
        const {userId,title,description} = req.body;
        const tdl = await TdlService.createTdl(userId,title,description);
        res.json(tdl);
    } catch (err) {
        return res.status(500).json({ message: err.message });
    }
}
exports.getTdl = async(req,res,next)=> {
    try {
        const {userId} = req.body;
        const tdl = await TdlService.getTdl(userId);
        res.json(tdl);

    } catch (err) {
        return res.status(500).json({ message: err.message });
    }

exports.deleteTdl = async(req,res,next) => {
    try {
        const {userId} = req.body;
        const tdl = await TdlService.deleteTdl(userId);
        res.json(tdl);
    } catch (err) {
        return res.status(500).json({ message: err.message });
    }
}
}