import { Request, Response } from "express";

const getAll = async (_req: Request, res: Response) => {
  try {
    res.status(200).json({ message: "Get users successful" });
  } catch (error) {
    console.error("Error getting users: ", error);
    res.status(500).json({ message: "Failed to get users" });
  }
};

export const UserController = { getAll };
