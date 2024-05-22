// const todo = require("../routes/todos.js")
// async function getTodo(req,res,next) {
//     let todo;
//     try {
//         todo = await Todo.findById(req.params.id);
//         if(todo = null){
//             return res.status(404).json({
//                 message: 'Todo not found'
//             });
//         } 
//     } catch (error) {
//         return res.status(500).json({
//             error: error
//         });    
//     }
//     res.todo = todo;
//     next();
// }