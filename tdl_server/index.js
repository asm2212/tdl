const app = require("./app.js");
const db = require("./config/db.js");
const UserModel = require("./model/userModel.js");

const port = 3000;



app.listen(port, () => {
  console.log(`Server running at ${port}`);
});