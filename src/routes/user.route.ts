import express from "express";
import { UserController } from "../controllers/user.controller";

const userRoute = express.Router();

userRoute.get("/", UserController.getAll);

export default userRoute;
