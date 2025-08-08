import { prisma } from "../config/db";

async function findAll() {
  return await prisma.user.findMany();
}

export const UserService = { findAll };
