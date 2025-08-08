import express from "express";
import userRoute from "./routes/user.route";
import dotenv from "dotenv";

const app = express();

dotenv.config();

const port = process.env.PORT || 3000;

app.use("/users", userRoute);

app.get("/health", (req, res) => {
  res.send("App is running....");
});

app.listen(port, () => {
  return console.log(`Express is listening at http://localhost:${port}`);
});
