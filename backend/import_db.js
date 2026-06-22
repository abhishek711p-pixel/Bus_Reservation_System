const fs = require('fs');
const mysql = require('mysql2/promise');

async function importDb() {
  try {
    const dbConfig = {
      host: 'localhost',
      user: 'root',
      password: 'password',
      multipleStatements: true
    };
    const connection = await mysql.createConnection(dbConfig);
    const sql = fs.readFileSync('../database/bus_reservation.sql', 'utf8');
    await connection.query(sql);
    console.log("Database imported successfully!");
    await connection.end();
  } catch (error) {
    console.error("Error importing database:", error.message);
  }
}

importDb();
