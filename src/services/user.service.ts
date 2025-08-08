import { UserRepository } from "../repositories/user.repository";

async function findAll() {
  return await UserRepository.findAll();
}
export const UserService = { findAll };
