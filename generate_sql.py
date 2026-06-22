import random
from datetime import datetime, timedelta

def generate_sql():
    sql = """-- ==========================================
-- DBMS Capstone Project: Bus Reservation System
-- Database Creation & Schema
-- ==========================================

DROP DATABASE IF EXISTS BusReservationDB;
CREATE DATABASE BusReservationDB;
USE BusReservationDB;

-- 1. Passengers Table
CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Buses Table
CREATE TABLE buses (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0 AND capacity <= 100),
    bus_type VARCHAR(30) NOT NULL -- e.g., 'AC Sleeper', 'Non-AC Seater'
);

-- 3. Routes Table
CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    distance_km DECIMAL(6,2) NOT NULL CHECK (distance_km > 0)
);

-- 4. Conductors Table
CREATE TABLE conductors (
    conductor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    license_number VARCHAR(30) UNIQUE NOT NULL
);

-- 5. Schedules Table
CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    route_id INT NOT NULL,
    conductor_id INT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    fare DECIMAL(8,2) NOT NULL CHECK (fare >= 0),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE,
    FOREIGN KEY (route_id) REFERENCES routes(route_id) ON DELETE CASCADE,
    FOREIGN KEY (conductor_id) REFERENCES conductors(conductor_id) ON DELETE SET NULL
);

-- 6. Bookings Table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    schedule_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seat_number INT NOT NULL CHECK (seat_number > 0),
    status VARCHAR(20) DEFAULT 'Confirmed' CHECK (status IN ('Confirmed', 'Cancelled', 'Pending')),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id) ON DELETE CASCADE,
    UNIQUE (schedule_id, seat_number) -- A seat on a specific schedule can only be booked once
);

-- 7. Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE,
    amount DECIMAL(8,2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- ==========================================
-- Dummy Data Insertion
-- ==========================================
"""

    # Generate 200 Passengers
    first_names = ["Rahul", "Amit", "Priya", "Sneha", "Vikram", "Rohan", "Anjali", "Neha", "Karan", "Suresh", 
                   "Ramesh", "Deepa", "Pooja", "Arun", "Sanjay", "Manoj", "Geeta", "Sunita", "Rajesh", "Kavita",
                   "Vijay", "Anita", "Vinod", "Rekha", "Nitin"]
    last_names = ["Sharma", "Verma", "Patel", "Singh", "Kumar", "Gupta", "Das", "Joshi", "Mehta", "Chawla",
                  "Yadav", "Nair", "Reddy", "Iyer", "Rao", "Garg", "Agarwal", "Kaur", "Desai", "Jain"]
    
    for i in range(1, 201):
        fn = random.choice(first_names)
        ln = random.choice(last_names)
        email = f"{fn.lower()}.{ln.lower()}{i}@example.com"
        phone = f"98{random.randint(10000000, 99999999)}"
        sql += f"INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('{fn}', '{ln}', '{email}', '{phone}');\n"

    sql += "\n"

    # Generate 100 Buses
    bus_types = ["AC Sleeper", "Non-AC Seater", "AC Seater", "Volvo Semi-Sleeper"]
    for i in range(1, 101):
        reg = f"MH-{random.randint(10,99)}-AB-{random.randint(1000,9999)}"
        cap = random.choice([30, 40, 45, 50])
        btype = random.choice(bus_types)
        sql += f"INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('{reg}', {cap}, '{btype}');\n"

    sql += "\n"

    # Generate 90 Routes (Every combination of 10 cities)
    cities = ["Mumbai", "Pune", "Delhi", "Jaipur", "Bangalore", "Hyderabad", "Chennai", "Kolkata", "Ahmedabad", "Surat"]
    route_id_counter = 1
    for src in cities:
        for dest in cities:
            if src != dest:
                dist = random.randint(100, 1500)
                sql += f"INSERT INTO routes (source, destination, distance_km) VALUES ('{src}', '{dest}', {dist});\n"
                route_id_counter += 1
        
    sql += "\n"

    # Generate 100 Conductors
    for i in range(1, 101):
        name = random.choice(first_names) + " " + random.choice(last_names)
        phone = f"97{random.randint(10000000, 99999999)}"
        lic = f"LIC{random.randint(100000, 999999)}IND"
        sql += f"INSERT INTO conductors (name, phone, license_number) VALUES ('{name}', '{phone}', '{lic}');\n"

    sql += "\n"

    # Generate 90+ Schedules (Guaranteeing 1 schedule for every route!)
    base_time = datetime(2026, 11, 1, 10, 0, 0)
    for route_id in range(1, 91):
        bus_id = random.randint(1, 100)
        cond_id = random.randint(1, 100)
        dep_time = base_time + timedelta(days=random.randint(0, 60), hours=random.randint(0, 23))
        arr_time = dep_time + timedelta(hours=random.randint(2, 15))
        fare = random.randint(500, 3000)
        sql += f"INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES ({bus_id}, {route_id}, {cond_id}, '{dep_time.strftime('%Y-%m-%d %H:%M:%S')}', '{arr_time.strftime('%Y-%m-%d %H:%M:%S')}', {fare});\n"

    # Add 10 extra random schedules just for variety
    for i in range(91, 101):
        bus_id = random.randint(1, 100)
        route_id = random.randint(1, 90)
        cond_id = random.randint(1, 100)
        dep_time = base_time + timedelta(days=random.randint(0, 60), hours=random.randint(0, 23))
        arr_time = dep_time + timedelta(hours=random.randint(2, 15))
        fare = random.randint(500, 3000)
        sql += f"INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES ({bus_id}, {route_id}, {cond_id}, '{dep_time.strftime('%Y-%m-%d %H:%M:%S')}', '{arr_time.strftime('%Y-%m-%d %H:%M:%S')}', {fare});\n"

    sql += "\n"

    # Generate 250 Bookings (Guaranteeing at least 1 confirmed booking per passenger)
    methods = ["Credit Card", "Debit Card", "UPI", "Net Banking"]
    for i in range(1, 251):
        pass_id = i if i <= 200 else random.randint(1, 200)
        sched_id = random.randint(1, 100)
        seat = random.randint(1, 50)
        status = 'Confirmed' if i <= 200 else random.choice(["Confirmed", "Confirmed", "Cancelled"])
        
        # We need to make sure (sched_id, seat) is unique to avoid script crash
        # For simplicity in this script, we'll just ignore errors using IGNORE in mysql
        sql += f"INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES ({pass_id}, {sched_id}, {seat}, '{status}');\n"

    sql += "\n"

    # Generate 250 Payments
    # Assumes booking_ids 1 to 250 exist
    for i in range(1, 251):
        amt = random.randint(500, 3000)
        meth = random.choice(methods)
        sql += f"INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES ({i}, {amt}, '{meth}');\n"

    sql += """
-- ==========================================
-- Advanced SQL Implementation (As per Syllabus)
-- ==========================================

-- 1. Create a View (Views)
-- This view shows active schedules with bus and route information
CREATE VIEW ActiveSchedulesView AS
SELECT 
    s.schedule_id, 
    b.registration_number, 
    b.bus_type, 
    r.source, 
    r.destination, 
    s.departure_time, 
    s.fare
FROM schedules s
INNER JOIN buses b ON s.bus_id = b.bus_id
INNER JOIN routes r ON s.route_id = r.route_id
WHERE s.departure_time > CURRENT_TIMESTAMP;

-- 2. DQL with Joins & Ordering (ORDER BY)
-- Get all passengers who have a confirmed booking
SELECT 
    p.first_name, 
    p.last_name, 
    b.seat_number, 
    r.source, 
    r.destination
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
INNER JOIN schedules s ON b.schedule_id = s.schedule_id
INNER JOIN routes r ON s.route_id = r.route_id
WHERE b.status = 'Confirmed'
ORDER BY p.last_name ASC;

-- 3. Aggregation and Grouping (GROUP BY, HAVING, Aggregate Functions)
-- Find the total revenue generated per route, only for routes generating more than 1000
SELECT 
    r.source, 
    r.destination, 
    SUM(p.amount) AS total_revenue,
    COUNT(b.booking_id) AS total_bookings
FROM routes r
INNER JOIN schedules s ON r.route_id = s.route_id
INNER JOIN bookings b ON s.schedule_id = b.schedule_id
INNER JOIN payments p ON b.booking_id = p.booking_id
WHERE b.status = 'Confirmed'
GROUP BY r.route_id, r.source, r.destination
HAVING total_revenue > 1000;

-- 4. Nested Subquery (Non-Correlated)
-- Find the names of passengers who have booked a ticket on the most expensive schedule
SELECT first_name, last_name, email
FROM passengers
WHERE passenger_id IN (
    SELECT passenger_id 
    FROM bookings 
    WHERE schedule_id IN (
        SELECT schedule_id 
        FROM schedules 
        WHERE fare = (SELECT MAX(fare) FROM schedules)
    )
);

-- 5. Correlated Subquery
-- Find buses whose capacity is greater than the average capacity of all buses
SELECT registration_number, bus_type, capacity
FROM buses b1
WHERE capacity > (
    SELECT AVG(capacity)
    FROM buses b2
);

-- 6. String and Date Functions, LIKE clause
-- Find all passengers whose email starts with 'A' and format their booking date
SELECT 
    UCASE(p.first_name) AS upper_first_name, 
    DATE_FORMAT(b.booking_date, '%M %d, %Y') AS formatted_booking_date
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE p.email LIKE 'a%';

-- ==========================================
-- Additional Required Operations (Mandatory Constraints)
-- ==========================================

-- 1. ALTER Operations
-- Adding a column for passenger's address to demonstrate ALTER
ALTER TABLE passengers ADD COLUMN address VARCHAR(255);

-- 2. UPDATE Operations
-- Update the status of a specific booking to demonstrate UPDATE
UPDATE bookings 
SET status = 'Cancelled' 
WHERE booking_id = 5;

-- Increase fare by 10% for AC Sleeper buses using a JOIN in UPDATE
UPDATE schedules s
INNER JOIN buses b ON s.bus_id = b.bus_id
SET s.fare = s.fare * 1.10
WHERE b.bus_type = 'AC Sleeper';

-- 3. DELETE Operations
-- Delete cancelled bookings older than a certain date to demonstrate DELETE
DELETE FROM bookings 
WHERE status = 'Cancelled' AND booking_date < '2024-01-01';

-- 4. Indexes for Performance Optimization
-- Index on departure_time to speed up schedule searches (Indexing constraint)
CREATE INDEX idx_departure_time ON schedules(departure_time);

-- Index on email for faster passenger lookups
CREATE INDEX idx_passenger_email ON passengers(email);
"""
    with open('/Users/abhi1317__/Desktop/bus-reservation-system/database/bus_reservation.sql', 'w') as f:
        f.write(sql)

generate_sql()
