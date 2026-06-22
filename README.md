# Online Bus Reservation System

## Overview
The Online Bus Reservation System is a full-stack, database-driven web application built for a Database Management Systems (DBMS) Capstone Project. It uses a **MySQL** database to strictly enforce relational constraints and model complex real-world transit data across 7 distinct tables (Passengers, Buses, Routes, Schedules, Conductors, Bookings, and Payments). A **Node.js/Express** backend acts as a secure API bridge, connecting the database to an interactive **HTML/CSS/JS** frontend. 

The application is built as a **two-sided platform**:
1. **Client Portal (`client.html`)**: A premium, glassmorphism-styled booking interface for customers to search routes and book tickets using a seamless multi-step wizard.
2. **Business/Employee Dashboard (`employee.html`)**: An administrative portal for business owners and employees to run advanced analytical SQL queries (Joins, Aggregations, Subqueries) on live company data.

## Features
- **Premium Client UI**: Modern glassmorphism UI with custom interactive dropdowns, animated UI elements, and responsive booking cards.
- **Dynamic Multi-Step Booking**: Customers can select up to 6 tickets at once, dynamically generating passenger entry forms, followed by a sleek checkout process.
- **Relational Database Design**: Normalized schema with proper primary/foreign key constraints (`ON DELETE CASCADE` / `ON DELETE SET NULL`).
- **Automated Data Seeding**: Includes a powerful Python script (`generate_sql.py`) that instantly seeds the database with over 90,000 lines of robust, randomized dummy data (including schedules for all upcoming months).
- **Advanced SQL Implementation**: Features Views, Correlated & Non-Correlated Subqueries, Joins, and Aggregation logic (`GROUP BY`, `HAVING`) heavily utilized in the business dashboard.
- **Secure Backend Bridge**: Express.js server querying MySQL locally, keeping database credentials hidden from the frontend.

## Tech Stack
- **Database**: MySQL 
- **Backend**: Node.js, Express.js, `mysql2` package
- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Data Generation**: Python (`datetime`, `random`)

## Project Structure
```text
bus-reservation-system/
│
├── backend/
│   ├── package.json       # Node.js dependencies
│   ├── server.js          # Express.js server & API routes
│   └── import_db.js       # Utility to import SQL files directly via Node
│
├── database/
│   └── bus_reservation.sql # Complete SQL schema, dummy data, and advanced queries
│
├── frontend/
│   ├── index.html         # Landing page to choose Client or Employee portal
│   ├── client.html        # Premium customer booking interface
│   ├── client.js          # Client-side booking logic
│   ├── employee.html      # Business/Employee analytical dashboard
│   ├── employee.js        # Logic for executing advanced DBMS queries
│   └── style.css          # Comprehensive global stylesheet (Glassmorphism, animations)
│
└── generate_sql.py        # Python script used to seed large volumes of realistic dummy data
```

## Prerequisites
To run this project locally, you will need:
- **MySQL Server** installed and running.
- **Node.js** and **npm** installed.
- *(Optional)* **Python 3** if you wish to regenerate the dummy database.

## Setup Instructions

### 1. Database Setup
1. Open your MySQL client (e.g., MySQL Workbench, Command Line, or phpMyAdmin).
2. Run the `bus_reservation.sql` script located in the `database/` folder. This script will automatically:
   - Create the `BusReservationDB` database.
   - Set up all tables and relationships.
   - Insert thousands of dummy records.
   - Create views and indexes.

*(Alternatively, you can run `cd backend && node import_db.js` to import the database automatically if your MySQL user allows it).*

### 2. Backend Setup
1. Open a terminal and navigate to the backend folder:
   ```bash
   cd backend
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

You will land on the portal selection page. From there, you can navigate to the **Client Portal** to book tickets, or the **Employee Dashboard** to view business analytics!

## GitHub Repository
This project is open-source and maintained on GitHub. Feel free to fork the repository, submit pull requests, or use it as a foundation for learning Database Management Systems and Full-Stack web development. 

Contributions and feature requests to enhance the booking flow or add new analytical queries to the business dashboard are always welcome!
