const express = require("express");
const Todo = require("../model/Todo.js");


const router = express.Router();

router.get("/",async(req,res) => {
    try {
        const todos = await Todo.find();
        res.json(todos); 
    } catch (error) {
       res.status(500).json({message: error.message});
    }
});

router.post("/create",async(req,res)=> {
    const todo = new Todo(
        {
            title: req.body.title,
            description: req.body.description,
            completed: req.body.completed,
        });
        try {
            const newTodo = await todo.save();
            res.status(201).json(newTodo);
        } catch (error) {
            res.status(400).json({message: error.message});
        }
});


router.get('/:id', getTodo, (req, res) => {
    res.json(res.todo);
  });
  

router.put("/:id", getTodo, async(req,res) => {
    if(req.body.title != null){
        res.todo.title = req.body.title;
    }
    if(req.body.description != null){
        res.todo.description = req.body.description;
    }
    if(req.body.completed != null){
        res.todo.completed = req.body.completed;
    }
    try {
        const updatedTodo = await res.todo.save();
        res.json(updatedTodo);
    } catch (error) {
        res.status(400).json({message: error.message});
    }
});

router.delete('/:id', getTodo, async (req, res) => {
    try {
      await res.todo.deleteOne();
      res.json({ message: 'Todo deleted' });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  });

async function getTodo(req, res, next) {
    let todo;
    try {
      todo = await Todo.findById(req.params.id);
      if (todo == null) {
        return res.status(404).json({ message: 'Cannot find todo' });
      }
    } catch (err) {
      return res.status(500).json({ message: err.message });
    }
    res.todo = todo;
    next();
  }
  
module.exports = router;