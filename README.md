# Online Bus Reservation System

## Overview
The Online Bus Reservation System is a full-stack, database-driven web application built for a Database Management Systems (DBMS) Capstone Project. It uses a **MySQL** database to strictly enforce relational constraints and model complex real-world transit data across 7 distinct tables (Passengers, Buses, Routes, Schedules, Conductors, Bookings, and Payments). A **Node.js/Express** backend acts as a secure API bridge, connecting the database to an interactive **HTML/CSS/JS** frontend. 

The system is loaded with realistic dummy records and successfully implements mandatory syllabus constraints, including advanced multi-table joins, subqueries, indexing, and data aggregation.

## Features
- **Relational Database Design**: Normalized schema with proper primary/foreign key constraints (`ON DELETE CASCADE` / `ON DELETE SET NULL`).
- **Comprehensive Datasets**: Automatically generated robust dataset including 200 passengers, 100 buses, 100 schedules, and 250 bookings.
- **Advanced SQL Implementation**: Features Views, Correlated & Non-Correlated Subqueries, Joins, and Aggregation logic (`GROUP BY`, `HAVING`).
- **Secure Backend Bridge**: Express.js server querying MySQL locally, keeping database credentials hidden from the frontend.
- **Interactive UI**: A sleek, user-friendly web interface to instantly test and view real-time database queries (e.g., viewing confirmed passengers, active schedules).

## Tech Stack
- **Database**: MySQL 
- **Backend**: Node.js, Express.js, `mysql2` package
- **Frontend**: HTML5, CSS3, Vanilla JavaScript

## Project Structure
```text
bus-reservation-system/
│
├── backend/
│   ├── package.json       # Node.js dependencies
│   └── server.js          # Express.js server & API routes
│
├── database/
│   └── bus_reservation.sql # Complete SQL schema, dummy data, and advanced queries
│
├── frontend/
│   ├── index.html         # User Interface
│   ├── style.css          # UI Styling
│   └── script.js          # Client-side logic for fetching data from the API
│
└── generate_sql.py        # Python script used to seed large volumes of dummy data
```

## Prerequisites
To run this project locally, you will need:
- **MySQL Server** installed and running.
- **Node.js** and **npm** installed.

## Setup Instructions

### 1. Database Setup
1. Open your MySQL client (e.g., MySQL Workbench, Command Line, or phpMyAdmin).
2. Run the `bus_reservation.sql` script located in the `database/` folder. This script will automatically:
   - Create the `BusReservationDB` database.
   - Set up all tables and relationships.
   - Insert hundreds of dummy records.
   - Create views and indexes.

### 2. Backend Setup
1. Open a terminal and navigate to the backend folder:
   ```bash
   cd bus-reservation-system/backend
   ```
2. Install the required Node.js dependencies:
   ```bash
   npm install express mysql2 cors
   ```
3. Open `server.js` and verify the database connection credentials match your local MySQL server:
   ```javascript
   const dbConfig = {
     host: 'localhost',
     user: 'root',        // Change if different
     password: 'password', // Ensure this matches your MySQL root password
     database: 'BusReservationDB'
   };
   ```
4. Start the backend server:
   ```bash
   node server.js
   ```
   The server will start on `http://localhost:3000`.

### 3. Accessing the Application
Since the backend Express server statically serves the frontend, simply open your web browser and navigate to:
**http://localhost:3000**

You can now click the buttons in the UI to dynamically query your local MySQL database!
