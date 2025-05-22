create database airline
use airline 

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10),
    address VARCHAR(200),
    phone VARCHAR(15),
    points INT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(35),
    date_of_birth DATE,
    gender VARCHAR(10),
    address VARCHAR(100),
    phone VARCHAR(20),
    salary DECIMAL(10,2),
    hire_date DATE DEFAULT (CURRENT_DATE),
    end_date DATE,
    is_current CHAR(1) DEFAULT 'Y' CHECK (is_current IN ('Y', 'N')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    type VARCHAR(50),
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE customer_interactions (
    interaction_id INT PRIMARY KEY,
    passenger_id INT,
    employee_id INT,
    feedback_id INT,
    interaction_time DATETIME,
    interaction_date DATE,
    interaction_type VARCHAR(50),
    satisfaction_rate DECIMAL(5,2),
    duration_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (feedback_id) REFERENCES feedback(feedback_id)
);

INSERT INTO passengers (passenger_id, name, date_of_birth, gender, address, phone, points, status)
VALUES 
(31,'Ahmed Hassan', '1990-05-20', 'Male', 'Cairo', '01012345678', 1200, 'Gold'),

(32,'Sara Youssef', '1985-12-11', 'Female', 'Giza', '01098765432', 800, 'Silver'),
(33,'Omar Tarek', '2000-07-30', 'Male', 'Alexandria', '01111222333', 400, 'Bronze');

INSERT INTO employees (employee_id, name, date_of_birth, gender, address, phone, salary, hire_date, end_date, is_current)
VALUES 
(51,'Mona Adel', '1980-08-15', 'Female', 'Cairo', '01234567890', 8500.00, '2015-01-10', NULL, 'Y'),
(52,'Khaled Nabil', '1992-03-05', 'Male', 'Giza', '01199887766', 7200.00, '2018-06-01', NULL, 'Y');

INSERT INTO feedback (feedback_id, type, description)
VALUES 
(101,'Complaint', 'Late response from customer support.'),
(102,'Inquiry', 'Asked about loyalty points policy.'),
(103,'Appreciation', 'Excellent assistance from support staff.');

INSERT INTO customer_interactions (interaction_id,passenger_id, employee_id, feedback_id, interaction_time, interaction_date, interaction_type, satisfaction_rate, duration_minutes)
VALUES 
(1,31, 51, 101, '2025-05-01 10:30:00', '2025-05-01', 'Phone Call', 3.5, 12),
(2,32, 52, 102, '2025-05-02 14:00:00', '2025-05-02', 'Email', 4.8, 5),
(3,33, 51, 103, '2025-05-03 09:45:00', '2025-05-03', 'Chat', 5.0, 7);

INSERT INTO passengers (passenger_id, name, date_of_birth, gender, address, phone, points, status)
VALUES 
(34,'Ahmed Hassan', '1990-05-20', 'Male', 'Cairo', '01012345678', 1200, 'Gold')


select * from passengers