const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;
const path = require('path');

app.use(cors());
app.use(express.json());

// Serve the frontend HTML/CSS/JS files directly from this backend server
app.use(express.static(path.join(__dirname, '../frontend')));


// Database connection configuration
// Use Environment Variables for cloud deployment (e.g. Render, Heroku) or default to local credentials
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'password', 
  database: process.env.DB_NAME || 'BusReservationDB',
  port: process.env.DB_PORT || 3306
};

// Route to execute raw SQL (For demonstration of queries)
// Note: In a real production app, executing raw SQL from the frontend is insecure,
// but for a DBMS project to test DQL/Joins/Views, this is the easiest bridge.
app.post('/api/query', async (req, res) => {
  const { sql, params } = req.body;
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute(sql, params || []);
    await connection.end();
    res.json(rows);
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ error: error.message });
  }
});

// API endpoint to get distinct cities for dropdowns
app.get('/api/cities', async (req, res) => {
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute('SELECT DISTINCT source AS city FROM routes UNION SELECT DISTINCT destination AS city FROM routes ORDER BY city');
    await connection.end();
    res.json(rows);
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ error: error.message });
  }
});

// API endpoint to search schedules
app.get('/api/search', async (req, res) => {
  const { source, destination } = req.query;
  try {
    const connection = await mysql.createConnection(dbConfig);
    const sql = `
      SELECT s.schedule_id, b.bus_type, b.capacity, r.source, r.destination, s.departure_time, s.arrival_time, s.fare
      FROM schedules s
      INNER JOIN routes r ON s.route_id = r.route_id
      INNER JOIN buses b ON s.bus_id = b.bus_id
      WHERE r.source = ? AND r.destination = ? AND s.departure_time > CURRENT_TIMESTAMP
      ORDER BY s.departure_time ASC
    `;
    const [rows] = await connection.execute(sql, [source, destination]);
    await connection.end();
    res.json(rows);
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ error: error.message });
  }
});

// API endpoint to book a ticket
app.post('/api/book', async (req, res) => {
  const { schedule_id, passenger_name, passenger_email } = req.body;
  try {
    const connection = await mysql.createConnection(dbConfig);
    
    // Simplistic approach: Create a new passenger record, then book a random seat
    const insertPassengerSql = `INSERT INTO passengers (first_name, last_name, email, phone) VALUES (?, ?, ?, ?)`;
    const randomPhone = '99' + Math.floor(10000000 + Math.random() * 90000000); // Dummy phone
    const [passengerResult] = await connection.execute(insertPassengerSql, [passenger_name, 'Guest', passenger_email, randomPhone]);
    const passenger_id = passengerResult.insertId;

    // Book a random seat
    const seat_number = Math.floor(Math.random() * 40) + 1;
    const insertBookingSql = `INSERT INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (?, ?, ?, 'Confirmed')`;
    await connection.execute(insertBookingSql, [passenger_id, schedule_id, seat_number]);

    await connection.end();
    res.json({ success: true, message: 'Booking successful!', seat_number });
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Backend Bridge running at http://localhost:${port}`);
  console.log(`Make sure you have run the 'bus_reservation.sql' script in MySQL first!`);
});
