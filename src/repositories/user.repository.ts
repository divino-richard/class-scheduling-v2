import pool from "../config/db";

async function findAll() {
  const result = await pool.query("SELECT * FROM user");
  return result.rows;
}

export const UserRepository = { findAll };
