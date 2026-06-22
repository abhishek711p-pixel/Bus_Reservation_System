-- ==========================================
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
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Chawla', 'vijay.chawla1@example.com', '9854256524');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Patel', 'kavita.patel2@example.com', '9893631661');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rekha', 'Singh', 'rekha.singh3@example.com', '9872521015');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Desai', 'pooja.desai4@example.com', '9824243144');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Nair', 'priya.nair5@example.com', '9830362079');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Patel', 'anjali.patel6@example.com', '9849764858');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Agarwal', 'pooja.agarwal7@example.com', '9828534796');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Desai', 'kavita.desai8@example.com', '9899200578');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Desai', 'anita.desai9@example.com', '9833470354');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Chawla', 'rajesh.chawla10@example.com', '9835176655');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Iyer', 'sunita.iyer11@example.com', '9855085295');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Kumar', 'vijay.kumar12@example.com', '9845689620');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Nair', 'rajesh.nair13@example.com', '9837363109');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Agarwal', 'arun.agarwal14@example.com', '9897456918');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Yadav', 'nitin.yadav15@example.com', '9881084688');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Gupta', 'deepa.gupta16@example.com', '9870381052');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Nair', 'anjali.nair17@example.com', '9816675235');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Patel', 'arun.patel18@example.com', '9821284010');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Rao', 'pooja.rao19@example.com', '9852838239');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Jain', 'sunita.jain20@example.com', '9812024362');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Chawla', 'anita.chawla21@example.com', '9861669589');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Das', 'vikram.das22@example.com', '9827124398');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Nair', 'vinod.nair23@example.com', '9810647582');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Manoj', 'Sharma', 'manoj.sharma24@example.com', '9876873043');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Desai', 'nitin.desai25@example.com', '9851357057');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Nair', 'ramesh.nair26@example.com', '9899880791');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Jain', 'vinod.jain27@example.com', '9840092651');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Rao', 'vinod.rao28@example.com', '9817536697');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Neha', 'Verma', 'neha.verma29@example.com', '9853967734');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Rao', 'anita.rao30@example.com', '9872253305');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Chawla', 'rahul.chawla31@example.com', '9884636947');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sneha', 'Singh', 'sneha.singh32@example.com', '9874705033');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Manoj', 'Gupta', 'manoj.gupta33@example.com', '9826115135');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Neha', 'Das', 'neha.das34@example.com', '9899670543');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Sharma', 'nitin.sharma35@example.com', '9827822603');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Jain', 'ramesh.jain36@example.com', '9897762498');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Chawla', 'anita.chawla37@example.com', '9842176709');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Kaur', 'amit.kaur38@example.com', '9840384901');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Suresh', 'Das', 'suresh.das39@example.com', '9880407764');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Jain', 'rahul.jain40@example.com', '9852337272');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Garg', 'geeta.garg41@example.com', '9860215624');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Desai', 'vinod.desai42@example.com', '9894096036');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Gupta', 'rajesh.gupta43@example.com', '9841428577');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sanjay', 'Chawla', 'sanjay.chawla44@example.com', '9855484967');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Jain', 'deepa.jain45@example.com', '9869055789');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Suresh', 'Nair', 'suresh.nair46@example.com', '9816399946');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Mehta', 'kavita.mehta47@example.com', '9858493439');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Chawla', 'nitin.chawla48@example.com', '9816164738');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Verma', 'priya.verma49@example.com', '9814360036');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Verma', 'amit.verma50@example.com', '9818611951');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Patel', 'sunita.patel51@example.com', '9896242722');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Gupta', 'priya.gupta52@example.com', '9832001841');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Neha', 'Jain', 'neha.jain53@example.com', '9873192801');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Neha', 'Reddy', 'neha.reddy54@example.com', '9862984339');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Kumar', 'rahul.kumar55@example.com', '9842822234');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Verma', 'kavita.verma56@example.com', '9879085585');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Gupta', 'rohan.gupta57@example.com', '9882327253');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Karan', 'Agarwal', 'karan.agarwal58@example.com', '9887746233');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Yadav', 'arun.yadav59@example.com', '9849065703');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Patel', 'priya.patel60@example.com', '9821908171');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Suresh', 'Sharma', 'suresh.sharma61@example.com', '9871359595');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sanjay', 'Desai', 'sanjay.desai62@example.com', '9838147243');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Singh', 'anita.singh63@example.com', '9879593128');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Mehta', 'pooja.mehta64@example.com', '9821386291');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Verma', 'deepa.verma65@example.com', '9862642673');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Agarwal', 'arun.agarwal66@example.com', '9841481725');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Kaur', 'anjali.kaur67@example.com', '9816205235');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Das', 'ramesh.das68@example.com', '9834572112');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Joshi', 'rahul.joshi69@example.com', '9862370426');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Patel', 'sunita.patel70@example.com', '9880409786');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Joshi', 'nitin.joshi71@example.com', '9872194748');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Karan', 'Yadav', 'karan.yadav72@example.com', '9819896477');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Rao', 'vijay.rao73@example.com', '9881026683');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Manoj', 'Kumar', 'manoj.kumar74@example.com', '9872184763');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Reddy', 'amit.reddy75@example.com', '9894437092');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Gupta', 'pooja.gupta76@example.com', '9897795021');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rekha', 'Das', 'rekha.das77@example.com', '9812706352');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Mehta', 'vinod.mehta78@example.com', '9838289619');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Agarwal', 'deepa.agarwal79@example.com', '9879243576');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Reddy', 'arun.reddy80@example.com', '9887849635');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Iyer', 'arun.iyer81@example.com', '9886912395');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Patel', 'vikram.patel82@example.com', '9863421282');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Reddy', 'ramesh.reddy83@example.com', '9868317303');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Garg', 'rohan.garg84@example.com', '9887940944');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Kumar', 'arun.kumar85@example.com', '9881501941');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Singh', 'vinod.singh86@example.com', '9882091213');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Desai', 'kavita.desai87@example.com', '9886495837');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Das', 'geeta.das88@example.com', '9851478961');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Chawla', 'kavita.chawla89@example.com', '9894568672');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Yadav', 'vijay.yadav90@example.com', '9897481492');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Garg', 'ramesh.garg91@example.com', '9887713440');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Desai', 'vijay.desai92@example.com', '9838773373');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Iyer', 'geeta.iyer93@example.com', '9845671371');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sneha', 'Desai', 'sneha.desai94@example.com', '9897420441');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Manoj', 'Sharma', 'manoj.sharma95@example.com', '9817126621');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Chawla', 'anita.chawla96@example.com', '9896468616');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Das', 'kavita.das97@example.com', '9893529174');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Chawla', 'arun.chawla98@example.com', '9847723628');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Sharma', 'priya.sharma99@example.com', '9834450832');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sneha', 'Kaur', 'sneha.kaur100@example.com', '9812954063');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Reddy', 'arun.reddy101@example.com', '9844000416');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Verma', 'pooja.verma102@example.com', '9876430366');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Das', 'kavita.das103@example.com', '9824779354');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Manoj', 'Patel', 'manoj.patel104@example.com', '9896509973');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Verma', 'vinod.verma105@example.com', '9847306507');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Patel', 'vikram.patel106@example.com', '9812302305');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Chawla', 'anita.chawla107@example.com', '9892686302');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Sharma', 'ramesh.sharma108@example.com', '9854949957');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Sharma', 'vijay.sharma109@example.com', '9879085883');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Verma', 'anjali.verma110@example.com', '9831568982');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Jain', 'anjali.jain111@example.com', '9851945572');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Sharma', 'amit.sharma112@example.com', '9843960835');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Garg', 'anita.garg113@example.com', '9878805341');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Gupta', 'rajesh.gupta114@example.com', '9874021357');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Nair', 'ramesh.nair115@example.com', '9897390133');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Verma', 'anita.verma116@example.com', '9829750444');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Desai', 'rohan.desai117@example.com', '9824704097');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Chawla', 'geeta.chawla118@example.com', '9823240572');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Desai', 'vijay.desai119@example.com', '9830048154');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Desai', 'anita.desai120@example.com', '9812526756');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Gupta', 'rahul.gupta121@example.com', '9815634610');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Reddy', 'deepa.reddy122@example.com', '9870196972');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rekha', 'Verma', 'rekha.verma123@example.com', '9822784165');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Das', 'sunita.das124@example.com', '9886605512');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Reddy', 'rajesh.reddy125@example.com', '9867600392');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Garg', 'pooja.garg126@example.com', '9868596464');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sanjay', 'Garg', 'sanjay.garg127@example.com', '9817655160');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sneha', 'Desai', 'sneha.desai128@example.com', '9836415786');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Reddy', 'rajesh.reddy129@example.com', '9838710099');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Yadav', 'pooja.yadav130@example.com', '9818015702');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Iyer', 'rahul.iyer131@example.com', '9895320552');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Suresh', 'Agarwal', 'suresh.agarwal132@example.com', '9833784723');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Verma', 'geeta.verma133@example.com', '9834472273');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Reddy', 'anjali.reddy134@example.com', '9880436057');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Das', 'rohan.das135@example.com', '9813643957');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Kaur', 'pooja.kaur136@example.com', '9887419926');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Sharma', 'amit.sharma137@example.com', '9822995997');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sanjay', 'Yadav', 'sanjay.yadav138@example.com', '9892743020');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Nair', 'priya.nair139@example.com', '9858367265');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Desai', 'sunita.desai140@example.com', '9821120585');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Kaur', 'vikram.kaur141@example.com', '9837122272');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Reddy', 'vinod.reddy142@example.com', '9847745866');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Sharma', 'vikram.sharma143@example.com', '9894312639');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Neha', 'Iyer', 'neha.iyer144@example.com', '9882342359');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Garg', 'anjali.garg145@example.com', '9859743924');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Iyer', 'vijay.iyer146@example.com', '9810990701');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Pooja', 'Desai', 'pooja.desai147@example.com', '9845611232');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sneha', 'Singh', 'sneha.singh148@example.com', '9883608135');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Yadav', 'vikram.yadav149@example.com', '9862570813');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Iyer', 'kavita.iyer150@example.com', '9869419946');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Karan', 'Kaur', 'karan.kaur151@example.com', '9853891275');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Verma', 'deepa.verma152@example.com', '9816058859');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anjali', 'Garg', 'anjali.garg153@example.com', '9841129579');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Chawla', 'priya.chawla154@example.com', '9896968937');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Mehta', 'rohan.mehta155@example.com', '9860841887');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Gupta', 'rohan.gupta156@example.com', '9870515717');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sanjay', 'Nair', 'sanjay.nair157@example.com', '9879838761');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sneha', 'Kaur', 'sneha.kaur158@example.com', '9886698644');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Reddy', 'kavita.reddy159@example.com', '9855715019');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Chawla', 'ramesh.chawla160@example.com', '9848404646');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vinod', 'Garg', 'vinod.garg161@example.com', '9825600133');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rajesh', 'Patel', 'rajesh.patel162@example.com', '9828765012');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Kaur', 'amit.kaur163@example.com', '9831950846');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Gupta', 'nitin.gupta164@example.com', '9896656520');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Deepa', 'Desai', 'deepa.desai165@example.com', '9819943031');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Chawla', 'sunita.chawla166@example.com', '9815584348');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Singh', 'geeta.singh167@example.com', '9839052285');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Das', 'anita.das168@example.com', '9826908645');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Gupta', 'rahul.gupta169@example.com', '9885429836');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Chawla', 'vijay.chawla170@example.com', '9842031634');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rekha', 'Nair', 'rekha.nair171@example.com', '9883569840');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Rao', 'rohan.rao172@example.com', '9879264597');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Nitin', 'Rao', 'nitin.rao173@example.com', '9822173959');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Manoj', 'Nair', 'manoj.nair174@example.com', '9840972847');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Ramesh', 'Yadav', 'ramesh.yadav175@example.com', '9834505197');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rohan', 'Jain', 'rohan.jain176@example.com', '9837190356');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Neha', 'Nair', 'neha.nair177@example.com', '9899067890');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Sharma', 'anita.sharma178@example.com', '9841255737');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Arun', 'Jain', 'arun.jain179@example.com', '9879411480');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Rao', 'priya.rao180@example.com', '9812830340');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rekha', 'Yadav', 'rekha.yadav181@example.com', '9864702172');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Patel', 'vijay.patel182@example.com', '9859585867');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rekha', 'Rao', 'rekha.rao183@example.com', '9847414701');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Kumar', 'vijay.kumar184@example.com', '9855183722');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Agarwal', 'geeta.agarwal185@example.com', '9873160509');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Amit', 'Das', 'amit.das186@example.com', '9812156459');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Joshi', 'priya.joshi187@example.com', '9892012597');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Priya', 'Kaur', 'priya.kaur188@example.com', '9870553345');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Rao', 'sunita.rao189@example.com', '9848585257');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vijay', 'Kumar', 'vijay.kumar190@example.com', '9826793712');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Suresh', 'Yadav', 'suresh.yadav191@example.com', '9869812244');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Anita', 'Gupta', 'anita.gupta192@example.com', '9842782249');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Rahul', 'Desai', 'rahul.desai193@example.com', '9888690336');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Kumar', 'geeta.kumar194@example.com', '9860506818');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Sunita', 'Sharma', 'sunita.sharma195@example.com', '9834950941');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Geeta', 'Iyer', 'geeta.iyer196@example.com', '9890606840');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Gupta', 'kavita.gupta197@example.com', '9863494851');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Kavita', 'Das', 'kavita.das198@example.com', '9882157651');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Suresh', 'Singh', 'suresh.singh199@example.com', '9835662564');
INSERT INTO passengers (first_name, last_name, email, phone) VALUES ('Vikram', 'Nair', 'vikram.nair200@example.com', '9830117316');

INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-16-AB-4062', 40, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-52-AB-6678', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-58-AB-2028', 40, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-10-AB-4583', 50, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-56-AB-5683', 50, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-43-AB-7552', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-42-AB-3591', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-25-AB-6796', 40, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-34-AB-6714', 30, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-73-AB-1672', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-25-AB-7155', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-54-AB-6101', 30, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-97-AB-2671', 30, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-96-AB-6875', 30, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-53-AB-8532', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-32-AB-7183', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-90-AB-4486', 40, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-79-AB-5863', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-22-AB-2349', 40, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-65-AB-3722', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-87-AB-8708', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-84-AB-2569', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-92-AB-2365', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-76-AB-7891', 30, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-68-AB-8810', 45, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-97-AB-7060', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-90-AB-6678', 30, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-62-AB-5779', 30, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-30-AB-1311', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-71-AB-1632', 30, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-68-AB-6920', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-38-AB-9307', 40, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-98-AB-6940', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-31-AB-3733', 40, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-88-AB-1282', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-42-AB-9260', 50, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-17-AB-9183', 45, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-36-AB-2121', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-97-AB-7469', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-80-AB-9278', 50, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-18-AB-4542', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-52-AB-3970', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-32-AB-5695', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-96-AB-5595', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-14-AB-2398', 50, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-94-AB-9717', 45, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-78-AB-8590', 45, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-88-AB-4853', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-79-AB-2093', 30, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-26-AB-7818', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-84-AB-1157', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-79-AB-1348', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-44-AB-8236', 30, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-48-AB-3151', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-44-AB-9506', 40, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-63-AB-8917', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-19-AB-9999', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-94-AB-7193', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-17-AB-4570', 30, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-72-AB-1711', 45, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-93-AB-7239', 40, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-96-AB-2662', 45, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-95-AB-1239', 50, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-84-AB-6669', 40, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-26-AB-2130', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-45-AB-3387', 45, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-20-AB-7567', 40, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-15-AB-6153', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-72-AB-9187', 40, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-61-AB-6171', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-94-AB-3568', 40, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-41-AB-7579', 50, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-34-AB-3648', 45, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-90-AB-5616', 45, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-31-AB-9623', 30, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-63-AB-9193', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-87-AB-6266', 30, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-19-AB-3095', 45, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-83-AB-4339', 50, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-39-AB-2309', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-42-AB-4604', 30, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-13-AB-8547', 50, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-40-AB-8281', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-82-AB-7875', 45, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-80-AB-1177', 40, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-40-AB-8127', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-41-AB-3152', 45, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-80-AB-1064', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-35-AB-6073', 40, 'AC Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-11-AB-3966', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-75-AB-9882', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-62-AB-7688', 50, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-47-AB-9059', 30, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-24-AB-9935', 40, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-60-AB-3773', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-52-AB-9379', 45, 'Non-AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-59-AB-5321', 50, 'AC Seater');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-97-AB-4349', 50, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-56-AB-6462', 45, 'Volvo Semi-Sleeper');
INSERT INTO buses (registration_number, capacity, bus_type) VALUES ('MH-41-AB-9250', 45, 'AC Sleeper');

INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Pune', 228);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Delhi', 1352);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Jaipur', 1030);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Bangalore', 1199);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Hyderabad', 1304);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Chennai', 473);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Kolkata', 1356);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Ahmedabad', 346);
INSERT INTO routes (source, destination, distance_km) VALUES ('Mumbai', 'Surat', 1369);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Mumbai', 864);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Delhi', 1457);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Jaipur', 1276);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Bangalore', 663);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Hyderabad', 1409);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Chennai', 333);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Kolkata', 217);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Ahmedabad', 1393);
INSERT INTO routes (source, destination, distance_km) VALUES ('Pune', 'Surat', 685);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Mumbai', 193);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Pune', 400);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Jaipur', 908);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Bangalore', 388);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Hyderabad', 577);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Chennai', 1063);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Kolkata', 705);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Ahmedabad', 223);
INSERT INTO routes (source, destination, distance_km) VALUES ('Delhi', 'Surat', 1024);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Mumbai', 294);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Pune', 818);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Delhi', 1175);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Bangalore', 550);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Hyderabad', 591);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Chennai', 449);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Kolkata', 1006);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Ahmedabad', 547);
INSERT INTO routes (source, destination, distance_km) VALUES ('Jaipur', 'Surat', 1353);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Mumbai', 1023);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Pune', 1198);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Delhi', 1330);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Jaipur', 402);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Hyderabad', 273);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Chennai', 264);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Kolkata', 1168);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Ahmedabad', 1253);
INSERT INTO routes (source, destination, distance_km) VALUES ('Bangalore', 'Surat', 511);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Mumbai', 299);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Pune', 774);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Delhi', 233);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Jaipur', 234);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Bangalore', 1181);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Chennai', 703);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Kolkata', 1458);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Ahmedabad', 479);
INSERT INTO routes (source, destination, distance_km) VALUES ('Hyderabad', 'Surat', 1342);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Mumbai', 1370);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Pune', 703);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Delhi', 1317);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Jaipur', 785);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Bangalore', 187);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Hyderabad', 621);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Kolkata', 671);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Ahmedabad', 1226);
INSERT INTO routes (source, destination, distance_km) VALUES ('Chennai', 'Surat', 1001);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Mumbai', 612);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Pune', 575);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Delhi', 520);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Jaipur', 1311);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Bangalore', 1269);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Hyderabad', 777);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Chennai', 521);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Ahmedabad', 760);
INSERT INTO routes (source, destination, distance_km) VALUES ('Kolkata', 'Surat', 712);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Mumbai', 157);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Pune', 682);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Delhi', 378);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Jaipur', 376);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Bangalore', 1036);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Hyderabad', 1331);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Chennai', 906);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Kolkata', 1355);
INSERT INTO routes (source, destination, distance_km) VALUES ('Ahmedabad', 'Surat', 1044);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Mumbai', 1164);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Pune', 252);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Delhi', 788);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Jaipur', 690);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Bangalore', 1440);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Hyderabad', 1245);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Chennai', 937);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Kolkata', 1019);
INSERT INTO routes (source, destination, distance_km) VALUES ('Surat', 'Ahmedabad', 1486);

INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Singh', '9731375014', 'LIC980800IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Arun Reddy', '9746548971', 'LIC536309IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Garg', '9753801666', 'LIC672893IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Neha Agarwal', '9766803669', 'LIC456459IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Patel', '9710725386', 'LIC740882IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Kavita Iyer', '9786280729', 'LIC765763IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Das', '9775914735', 'LIC405172IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Mehta', '9753859427', 'LIC281236IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Geeta Rao', '9726774825', 'LIC349416IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Gupta', '9749255591', 'LIC954579IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Ramesh Mehta', '9771295405', 'LIC826956IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vikram Patel', '9794345893', 'LIC899246IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vikram Kumar', '9714720153', 'LIC504049IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Geeta Nair', '9744977678', 'LIC399067IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Karan Desai', '9714905590', 'LIC759312IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Nitin Jain', '9720792903', 'LIC767750IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Ramesh Patel', '9780577270', 'LIC409077IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Arun Gupta', '9773863350', 'LIC817744IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vijay Chawla', '9739527608', 'LIC564879IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Garg', '9758505092', 'LIC844103IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Ramesh Gupta', '9749827732', 'LIC885479IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Manoj Singh', '9771768401', 'LIC756680IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Deepa Chawla', '9723235099', 'LIC587718IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Arun Desai', '9730445102', 'LIC916561IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vikram Kaur', '9717777841', 'LIC123777IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sneha Mehta', '9729774150', 'LIC557939IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Yadav', '9761351609', 'LIC333782IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Karan Reddy', '9792098433', 'LIC963500IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Geeta Gupta', '9775002205', 'LIC488912IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sneha Chawla', '9768916709', 'LIC764172IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rahul Gupta', '9744194961', 'LIC553752IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Nair', '9797889965', 'LIC839607IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sneha Kumar', '9788929221', 'LIC492634IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Kumar', '9723706196', 'LIC213608IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rohan Agarwal', '9746137831', 'LIC239663IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Geeta Singh', '9770978683', 'LIC739295IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rahul Mehta', '9739945368', 'LIC698146IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Deepa Kumar', '9762425970', 'LIC835650IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rohan Verma', '9731209303', 'LIC500145IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Das', '9765557138', 'LIC595692IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rahul Garg', '9771260454', 'LIC575281IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vinod Agarwal', '9771591501', 'LIC557711IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Nitin Das', '9710134716', 'LIC490417IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vikram Patel', '9750856972', 'LIC126258IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Anjali Jain', '9730143737', 'LIC923438IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Kaur', '9719604252', 'LIC523606IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Karan Rao', '9749045023', 'LIC214989IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rekha Rao', '9726699921', 'LIC973501IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Geeta Iyer', '9768092648', 'LIC183628IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rohan Kumar', '9748341871', 'LIC513916IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sanjay Sharma', '9791060980', 'LIC243458IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Nair', '9770211279', 'LIC362519IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rekha Gupta', '9753017707', 'LIC599496IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Kavita Yadav', '9747338605', 'LIC615419IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Nitin Kumar', '9737974417', 'LIC634865IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Amit Desai', '9712420900', 'LIC628624IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rekha Verma', '9730324833', 'LIC295959IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rajesh Chawla', '9793358184', 'LIC940946IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rekha Desai', '9773263936', 'LIC397758IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Pooja Gupta', '9764517244', 'LIC735224IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Chawla', '9769710970', 'LIC540701IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Arun Desai', '9792722092', 'LIC599597IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Neha Chawla', '9788429150', 'LIC436480IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vinod Gupta', '9733893631', 'LIC887820IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Anita Desai', '9745295471', 'LIC554055IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rekha Singh', '9726740462', 'LIC287691IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Manoj Sharma', '9767187131', 'LIC616761IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Anita Rao', '9746163645', 'LIC241183IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Ramesh Das', '9768435725', 'LIC799655IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Anjali Gupta', '9784694563', 'LIC739580IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Pooja Sharma', '9718452649', 'LIC847194IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Neha Nair', '9724077697', 'LIC279259IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Neha Verma', '9769719359', 'LIC953820IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Ramesh Yadav', '9782722261', 'LIC735766IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Singh', '9743131841', 'LIC583833IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Anjali Iyer', '9747724808', 'LIC926435IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Iyer', '9750550638', 'LIC456559IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rahul Joshi', '9783106502', 'LIC803043IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Agarwal', '9757160888', 'LIC111237IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Suresh Jain', '9725850144', 'LIC386968IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Deepa Jain', '9779381582', 'LIC162338IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Pooja Sharma', '9725900685', 'LIC294845IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Pooja Agarwal', '9760547051', 'LIC442042IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Karan Joshi', '9776619219', 'LIC751943IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vijay Das', '9778707334', 'LIC274378IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Priya Jain', '9713695108', 'LIC150088IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Gupta', '9762900789', 'LIC446941IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Chawla', '9748579073', 'LIC544465IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rohan Yadav', '9781334081', 'LIC983845IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Desai', '9743616224', 'LIC562934IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Ramesh Kumar', '9763977927', 'LIC434774IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sunita Reddy', '9766544036', 'LIC998637IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vijay Kumar', '9777857237', 'LIC443429IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Deepa Jain', '9769901060', 'LIC704100IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Rekha Mehta', '9788856884', 'LIC272867IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Sanjay Garg', '9740105004', 'LIC837532IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Manoj Yadav', '9742401165', 'LIC918576IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Vijay Rao', '9797419166', 'LIC687023IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Neha Agarwal', '9734126134', 'LIC299630IND');
INSERT INTO conductors (name, phone, license_number) VALUES ('Nitin Iyer', '9715796520', 'LIC669295IND');

INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (20, 1, 77, '2026-12-08 10:00:00', '2026-12-08 21:00:00', 2855);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (69, 2, 60, '2026-11-14 05:00:00', '2026-11-14 20:00:00', 1022);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (100, 3, 92, '2026-11-08 19:00:00', '2026-11-09 01:00:00', 1710);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (85, 4, 35, '2026-12-16 08:00:00', '2026-12-16 11:00:00', 2665);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (56, 5, 41, '2026-12-24 05:00:00', '2026-12-24 11:00:00', 522);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (23, 6, 9, '2026-11-23 08:00:00', '2026-11-23 13:00:00', 641);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (79, 7, 89, '2026-12-14 16:00:00', '2026-12-15 07:00:00', 1254);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (84, 8, 94, '2026-12-02 11:00:00', '2026-12-02 15:00:00', 1229);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (40, 9, 88, '2026-11-09 01:00:00', '2026-11-09 08:00:00', 2705);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (92, 10, 72, '2026-11-05 10:00:00', '2026-11-05 16:00:00', 2688);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (88, 11, 81, '2026-12-30 23:00:00', '2026-12-31 01:00:00', 1456);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (35, 12, 72, '2026-12-15 03:00:00', '2026-12-15 13:00:00', 2322);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (37, 13, 17, '2026-11-11 15:00:00', '2026-11-12 04:00:00', 2390);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (95, 14, 55, '2026-11-08 17:00:00', '2026-11-09 01:00:00', 2429);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (2, 15, 60, '2026-11-07 13:00:00', '2026-11-07 15:00:00', 2747);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (12, 16, 55, '2026-12-07 18:00:00', '2026-12-07 21:00:00', 524);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (65, 17, 15, '2026-11-16 05:00:00', '2026-11-16 13:00:00', 2380);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (43, 18, 81, '2026-11-14 16:00:00', '2026-11-15 06:00:00', 871);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (62, 19, 2, '2026-11-09 18:00:00', '2026-11-10 09:00:00', 2704);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (53, 20, 73, '2026-11-30 00:00:00', '2026-11-30 02:00:00', 1810);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (42, 21, 45, '2026-11-04 19:00:00', '2026-11-05 04:00:00', 1529);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (62, 22, 47, '2026-11-23 19:00:00', '2026-11-23 22:00:00', 2889);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (55, 23, 82, '2026-11-17 23:00:00', '2026-11-18 01:00:00', 1813);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (88, 24, 50, '2026-11-08 01:00:00', '2026-11-08 15:00:00', 1040);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (60, 25, 88, '2026-12-09 21:00:00', '2026-12-09 23:00:00', 1189);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (19, 26, 47, '2026-11-27 02:00:00', '2026-11-27 16:00:00', 2052);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (54, 27, 10, '2026-12-24 15:00:00', '2026-12-25 04:00:00', 2189);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (47, 28, 98, '2026-11-20 16:00:00', '2026-11-20 22:00:00', 2052);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (4, 29, 68, '2026-11-22 17:00:00', '2026-11-23 03:00:00', 1735);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (52, 30, 33, '2026-11-24 13:00:00', '2026-11-24 18:00:00', 2035);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (58, 31, 88, '2026-12-06 08:00:00', '2026-12-06 18:00:00', 2622);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (19, 32, 44, '2026-11-13 20:00:00', '2026-11-14 07:00:00', 1333);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (20, 33, 56, '2026-11-25 22:00:00', '2026-11-26 10:00:00', 2200);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (28, 34, 64, '2026-12-05 03:00:00', '2026-12-05 05:00:00', 778);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (65, 35, 81, '2026-11-30 09:00:00', '2026-11-30 11:00:00', 1723);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (88, 36, 43, '2026-12-21 10:00:00', '2026-12-21 20:00:00', 2739);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (33, 37, 2, '2026-11-09 03:00:00', '2026-11-09 18:00:00', 1013);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (79, 38, 65, '2026-12-09 04:00:00', '2026-12-09 16:00:00', 1145);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (96, 39, 61, '2026-12-14 11:00:00', '2026-12-14 21:00:00', 1369);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (50, 40, 70, '2026-12-09 02:00:00', '2026-12-09 10:00:00', 655);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (61, 41, 7, '2026-12-18 01:00:00', '2026-12-18 11:00:00', 846);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (85, 42, 34, '2026-11-12 15:00:00', '2026-11-12 22:00:00', 556);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (94, 43, 39, '2026-12-23 00:00:00', '2026-12-23 05:00:00', 1599);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (60, 44, 45, '2026-11-10 17:00:00', '2026-11-11 03:00:00', 1904);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (36, 45, 79, '2026-11-17 10:00:00', '2026-11-18 00:00:00', 2355);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (22, 46, 83, '2026-12-24 12:00:00', '2026-12-25 02:00:00', 2401);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (85, 47, 34, '2026-12-17 07:00:00', '2026-12-17 20:00:00', 1149);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (43, 48, 7, '2026-12-21 11:00:00', '2026-12-21 19:00:00', 2473);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (91, 49, 13, '2026-11-25 19:00:00', '2026-11-25 23:00:00', 1333);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (77, 50, 71, '2026-11-10 18:00:00', '2026-11-11 04:00:00', 764);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (74, 51, 49, '2026-11-24 10:00:00', '2026-11-24 13:00:00', 1628);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (93, 52, 27, '2026-11-03 04:00:00', '2026-11-03 19:00:00', 1021);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (49, 53, 51, '2026-11-10 07:00:00', '2026-11-10 09:00:00', 1124);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (25, 54, 7, '2026-11-12 05:00:00', '2026-11-12 19:00:00', 945);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (20, 55, 81, '2026-12-20 17:00:00', '2026-12-21 08:00:00', 1448);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (39, 56, 87, '2026-12-02 12:00:00', '2026-12-03 03:00:00', 2666);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (15, 57, 23, '2026-11-12 21:00:00', '2026-11-13 10:00:00', 905);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (99, 58, 21, '2026-11-28 23:00:00', '2026-11-29 09:00:00', 1143);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (15, 59, 5, '2026-11-05 20:00:00', '2026-11-06 04:00:00', 2675);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (2, 60, 24, '2026-11-30 15:00:00', '2026-11-30 20:00:00', 2675);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (8, 61, 40, '2026-11-29 22:00:00', '2026-11-30 01:00:00', 2138);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (40, 62, 77, '2026-12-09 00:00:00', '2026-12-09 10:00:00', 1120);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (86, 63, 27, '2026-11-03 01:00:00', '2026-11-03 07:00:00', 1019);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (65, 64, 11, '2026-12-25 11:00:00', '2026-12-25 23:00:00', 1339);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (76, 65, 81, '2026-11-07 09:00:00', '2026-11-07 11:00:00', 1307);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (7, 66, 23, '2026-12-16 20:00:00', '2026-12-17 04:00:00', 2942);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (89, 67, 57, '2026-12-09 22:00:00', '2026-12-10 03:00:00', 1390);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (12, 68, 77, '2026-11-15 01:00:00', '2026-11-15 12:00:00', 695);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (4, 69, 30, '2026-12-20 05:00:00', '2026-12-20 19:00:00', 1287);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (44, 70, 33, '2026-11-20 07:00:00', '2026-11-20 14:00:00', 930);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (3, 71, 50, '2026-11-05 05:00:00', '2026-11-05 18:00:00', 2526);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (2, 72, 58, '2026-11-04 16:00:00', '2026-11-04 20:00:00', 1381);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (96, 73, 58, '2026-12-22 20:00:00', '2026-12-23 11:00:00', 2115);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (58, 74, 87, '2026-12-31 05:00:00', '2026-12-31 10:00:00', 2297);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (13, 75, 11, '2026-12-08 04:00:00', '2026-12-08 18:00:00', 568);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (96, 76, 12, '2026-12-12 22:00:00', '2026-12-13 06:00:00', 2413);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (61, 77, 90, '2026-12-21 04:00:00', '2026-12-21 10:00:00', 1133);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (8, 78, 53, '2026-11-03 03:00:00', '2026-11-03 15:00:00', 763);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (89, 79, 88, '2026-12-04 17:00:00', '2026-12-05 04:00:00', 2764);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (33, 80, 23, '2026-11-12 05:00:00', '2026-11-12 10:00:00', 1785);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (37, 81, 58, '2026-12-01 05:00:00', '2026-12-01 13:00:00', 2038);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (32, 82, 2, '2026-11-29 00:00:00', '2026-11-29 09:00:00', 1541);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (83, 83, 84, '2026-11-24 23:00:00', '2026-11-25 05:00:00', 571);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (93, 84, 84, '2026-11-11 21:00:00', '2026-11-12 02:00:00', 786);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (52, 85, 70, '2026-11-02 23:00:00', '2026-11-03 09:00:00', 2630);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (95, 86, 88, '2026-12-17 12:00:00', '2026-12-17 17:00:00', 1363);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (80, 87, 41, '2026-12-02 02:00:00', '2026-12-02 14:00:00', 2476);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (63, 88, 5, '2026-11-30 13:00:00', '2026-11-30 17:00:00', 1712);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (46, 89, 70, '2026-12-01 10:00:00', '2026-12-02 01:00:00', 2912);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (44, 90, 71, '2026-12-09 22:00:00', '2026-12-10 11:00:00', 626);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (90, 42, 91, '2026-11-14 01:00:00', '2026-11-14 14:00:00', 1326);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (57, 40, 49, '2026-12-13 00:00:00', '2026-12-13 11:00:00', 1057);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (76, 32, 60, '2026-12-02 22:00:00', '2026-12-03 09:00:00', 541);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (55, 24, 32, '2026-11-19 14:00:00', '2026-11-19 22:00:00', 1509);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (46, 64, 47, '2026-11-16 11:00:00', '2026-11-16 16:00:00', 2511);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (41, 1, 70, '2026-12-04 17:00:00', '2026-12-05 02:00:00', 2126);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (45, 24, 11, '2026-12-20 15:00:00', '2026-12-20 22:00:00', 807);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (67, 68, 13, '2026-12-05 05:00:00', '2026-12-05 10:00:00', 1569);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (1, 90, 80, '2026-12-15 15:00:00', '2026-12-15 20:00:00', 1582);
INSERT INTO schedules (bus_id, route_id, conductor_id, departure_time, arrival_time, fare) VALUES (10, 60, 8, '2026-12-17 19:00:00', '2026-12-18 09:00:00', 1101);

INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (1, 59, 1, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (2, 56, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (3, 71, 19, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (4, 18, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (5, 84, 50, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (6, 94, 44, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (7, 90, 8, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (8, 36, 5, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (9, 88, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (10, 37, 5, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (11, 36, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (12, 62, 37, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (13, 26, 19, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (14, 94, 49, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (15, 97, 25, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (16, 27, 10, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (17, 74, 7, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (18, 6, 15, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (19, 8, 6, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (20, 7, 8, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (21, 94, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (22, 61, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (23, 93, 43, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (24, 82, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (25, 84, 43, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (26, 1, 30, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (27, 30, 9, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (28, 77, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (29, 97, 33, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (30, 75, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (31, 62, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (32, 3, 39, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (33, 33, 40, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (34, 51, 8, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (35, 70, 3, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (36, 85, 24, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (37, 30, 30, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (38, 48, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (39, 5, 21, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (40, 77, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (41, 77, 15, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (42, 82, 19, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (43, 47, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (44, 28, 10, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (45, 36, 7, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (46, 78, 15, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (47, 92, 13, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (48, 8, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (49, 45, 36, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (50, 31, 7, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (51, 21, 18, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (52, 88, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (53, 63, 35, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (54, 13, 33, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (55, 29, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (56, 63, 44, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (57, 18, 25, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (58, 87, 13, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (59, 53, 37, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (60, 69, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (61, 91, 37, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (62, 30, 15, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (63, 85, 11, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (64, 74, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (65, 99, 24, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (66, 63, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (67, 71, 13, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (68, 82, 4, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (69, 68, 16, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (70, 43, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (71, 28, 42, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (72, 78, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (73, 33, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (74, 62, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (75, 55, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (76, 85, 26, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (77, 70, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (78, 77, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (79, 27, 14, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (80, 73, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (81, 72, 44, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (82, 85, 35, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (83, 85, 41, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (84, 92, 18, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (85, 98, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (86, 37, 25, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (87, 86, 31, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (88, 93, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (89, 45, 25, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (90, 1, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (91, 24, 31, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (92, 82, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (93, 7, 41, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (94, 97, 44, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (95, 90, 1, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (96, 95, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (97, 46, 27, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (98, 75, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (99, 32, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (100, 78, 22, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (101, 68, 1, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (102, 56, 35, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (103, 19, 44, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (104, 30, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (105, 26, 33, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (106, 85, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (107, 80, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (108, 52, 24, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (109, 17, 22, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (110, 42, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (111, 14, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (112, 89, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (113, 1, 36, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (114, 34, 33, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (115, 75, 9, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (116, 53, 11, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (117, 30, 41, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (118, 96, 35, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (119, 25, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (120, 52, 10, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (121, 95, 50, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (122, 33, 15, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (123, 9, 40, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (124, 40, 14, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (125, 46, 11, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (126, 73, 9, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (127, 78, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (128, 46, 37, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (129, 74, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (130, 83, 8, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (131, 55, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (132, 21, 19, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (133, 77, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (134, 37, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (135, 75, 40, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (136, 100, 16, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (137, 19, 33, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (138, 7, 50, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (139, 97, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (140, 79, 32, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (141, 26, 45, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (142, 51, 1, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (143, 67, 40, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (144, 22, 9, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (145, 91, 14, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (146, 70, 35, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (147, 66, 42, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (148, 22, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (149, 14, 26, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (150, 58, 24, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (151, 2, 45, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (152, 60, 44, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (153, 94, 6, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (154, 44, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (155, 17, 27, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (156, 18, 32, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (157, 63, 10, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (158, 10, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (159, 51, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (160, 80, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (161, 27, 36, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (162, 83, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (163, 98, 49, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (164, 58, 16, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (165, 60, 23, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (166, 15, 26, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (167, 93, 3, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (168, 98, 3, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (169, 18, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (170, 94, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (171, 3, 32, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (172, 57, 4, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (173, 32, 8, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (174, 82, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (175, 8, 30, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (176, 63, 38, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (177, 30, 23, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (178, 11, 5, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (179, 48, 49, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (180, 92, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (181, 51, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (182, 6, 26, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (183, 38, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (184, 42, 11, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (185, 12, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (186, 42, 34, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (187, 23, 3, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (188, 52, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (189, 8, 40, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (190, 97, 18, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (191, 57, 4, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (192, 31, 23, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (193, 1, 37, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (194, 10, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (195, 62, 24, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (196, 43, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (197, 42, 5, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (198, 54, 31, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (199, 93, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (200, 85, 27, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (24, 42, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (123, 20, 14, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (122, 4, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (200, 85, 14, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (27, 26, 37, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (182, 68, 14, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (114, 88, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (87, 46, 33, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (86, 59, 41, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (27, 42, 28, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (13, 65, 27, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (37, 89, 47, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (173, 43, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (152, 2, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (97, 26, 10, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (181, 82, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (1, 76, 35, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (46, 5, 41, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (28, 14, 48, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (27, 13, 7, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (118, 57, 46, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (148, 16, 38, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (54, 64, 25, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (8, 8, 37, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (81, 80, 33, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (50, 60, 20, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (7, 42, 22, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (33, 97, 24, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (185, 16, 19, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (198, 81, 42, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (61, 79, 36, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (54, 84, 22, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (198, 15, 42, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (31, 5, 50, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (160, 2, 23, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (153, 9, 29, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (72, 42, 37, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (70, 92, 2, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (29, 17, 45, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (126, 73, 25, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (72, 94, 43, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (46, 51, 41, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (138, 25, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (191, 22, 19, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (137, 31, 12, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (109, 77, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (57, 93, 17, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (186, 68, 32, 'Confirmed');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (170, 10, 42, 'Cancelled');
INSERT IGNORE INTO bookings (passenger_id, schedule_id, seat_number, status) VALUES (85, 83, 42, 'Confirmed');

INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (1, 1037, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (2, 533, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (3, 1701, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (4, 504, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (5, 840, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (6, 2042, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (7, 2796, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (8, 2797, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (9, 1282, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (10, 2138, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (11, 1237, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (12, 2795, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (13, 557, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (14, 2009, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (15, 1988, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (16, 2318, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (17, 2070, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (18, 1256, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (19, 2379, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (20, 1361, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (21, 1536, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (22, 2809, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (23, 955, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (24, 2338, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (25, 1996, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (26, 1669, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (27, 887, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (28, 694, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (29, 1118, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (30, 2672, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (31, 1366, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (32, 1037, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (33, 2849, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (34, 870, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (35, 2605, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (36, 2874, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (37, 1724, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (38, 1480, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (39, 2524, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (40, 1602, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (41, 2842, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (42, 659, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (43, 1807, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (44, 833, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (45, 1604, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (46, 562, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (47, 2322, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (48, 1728, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (49, 995, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (50, 2477, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (51, 2943, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (52, 2100, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (53, 704, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (54, 2829, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (55, 2768, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (56, 2610, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (57, 1420, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (58, 2975, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (59, 1412, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (60, 2292, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (61, 985, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (62, 2166, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (63, 1434, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (64, 1202, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (65, 730, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (66, 1518, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (67, 1196, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (68, 645, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (69, 1301, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (70, 1146, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (71, 2276, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (72, 1803, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (73, 1193, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (74, 2305, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (75, 1292, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (76, 2138, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (77, 621, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (78, 2954, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (79, 1211, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (80, 2501, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (81, 841, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (82, 2014, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (83, 1890, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (84, 2142, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (85, 1281, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (86, 2229, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (87, 996, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (88, 1347, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (89, 2632, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (90, 2658, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (91, 2957, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (92, 1401, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (93, 1418, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (94, 2213, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (95, 999, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (96, 2427, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (97, 1321, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (98, 2637, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (99, 1490, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (100, 2399, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (101, 2235, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (102, 2427, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (103, 1975, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (104, 923, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (105, 1237, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (106, 2425, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (107, 2033, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (108, 2334, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (109, 1066, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (110, 1185, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (111, 1763, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (112, 1746, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (113, 2194, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (114, 2837, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (115, 2919, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (116, 2837, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (117, 2398, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (118, 1433, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (119, 1600, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (120, 1296, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (121, 1834, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (122, 2937, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (123, 1052, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (124, 2328, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (125, 1225, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (126, 1082, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (127, 504, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (128, 1412, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (129, 665, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (130, 2383, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (131, 1760, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (132, 2288, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (133, 2122, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (134, 1420, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (135, 2090, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (136, 2086, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (137, 2981, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (138, 980, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (139, 1814, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (140, 2658, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (141, 2025, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (142, 1524, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (143, 1460, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (144, 769, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (145, 843, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (146, 1807, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (147, 571, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (148, 1938, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (149, 1515, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (150, 1218, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (151, 2960, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (152, 1731, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (153, 1271, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (154, 1826, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (155, 1743, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (156, 2470, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (157, 1235, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (158, 2628, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (159, 760, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (160, 2825, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (161, 1147, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (162, 2489, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (163, 2038, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (164, 563, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (165, 1068, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (166, 506, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (167, 1050, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (168, 2779, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (169, 1623, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (170, 2227, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (171, 1706, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (172, 2497, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (173, 1795, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (174, 811, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (175, 2152, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (176, 2395, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (177, 1709, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (178, 2462, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (179, 2006, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (180, 995, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (181, 1667, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (182, 2767, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (183, 771, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (184, 2445, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (185, 928, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (186, 2289, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (187, 1691, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (188, 531, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (189, 718, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (190, 1289, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (191, 1675, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (192, 1754, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (193, 1867, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (194, 2085, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (195, 820, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (196, 1431, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (197, 2906, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (198, 1371, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (199, 2891, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (200, 1360, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (201, 2759, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (202, 2154, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (203, 2289, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (204, 2080, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (205, 2698, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (206, 634, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (207, 1083, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (208, 1674, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (209, 1012, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (210, 2054, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (211, 2144, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (212, 2866, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (213, 1678, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (214, 576, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (215, 1859, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (216, 637, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (217, 1092, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (218, 500, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (219, 501, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (220, 1805, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (221, 2178, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (222, 2806, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (223, 2155, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (224, 1014, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (225, 1998, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (226, 2038, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (227, 712, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (228, 1071, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (229, 518, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (230, 1226, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (231, 515, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (232, 2601, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (233, 2134, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (234, 520, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (235, 752, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (236, 1649, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (237, 2464, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (238, 1955, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (239, 2405, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (240, 2098, 'Debit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (241, 2700, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (242, 795, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (243, 1938, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (244, 814, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (245, 591, 'UPI');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (246, 598, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (247, 2971, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (248, 2414, 'Net Banking');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (249, 2177, 'Credit Card');
INSERT IGNORE INTO payments (booking_id, amount, payment_method) VALUES (250, 1603, 'Credit Card');

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
