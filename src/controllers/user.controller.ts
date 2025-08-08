import { Request, Response } from "express";
import { UserService } from "../services/user.service";

const getAll = async (_req: Request, res: Response) => {
  try {
    const users = UserService.findAll();
    res.status(200).json(users);
  } catch (error) {
    console.error("Error getting users: ", error);
    res.status(500).json({ message: "Failed to get users" });
  }
};

export const UserController = { getAll };
