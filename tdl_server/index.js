const app = require("./app.js");
const db = require("./config/db.js");
const todoRoutes = require("./routes/todos.js");
const UserModel = require("./model/userModel.js");


const port = 3000;




app.use("/todos",todoRoutes);
app.use("/todos/create",todoRoutes);


app.listen(port, () => {
  console.log(`Server running at ${port}`);
});
