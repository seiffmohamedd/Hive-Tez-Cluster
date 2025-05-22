CREATE TABLE customer_dim (
    sk_passenger_id SERIAL PRIMARY KEY,
    passenger_id INTEGER,
    passenger_name VARCHAR(100),
    passenger_dateofbirth DATE,
    passenger_gender VARCHAR(10),
    passenger_address VARCHAR(200),
    passenger_phone VARCHAR(15),
    passenger_points INTEGER,
    passenger_status VARCHAR(50),
    start_date DATE DEFAULT '2000-01-01',
    end_date DATE DEFAULT '9999-12-31',
    is_current CHAR(1) DEFAULT 'Y' CHECK (is_current IN ('Y', 'N')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE time_dim (
    time_id TIMESTAMP PRIMARY KEY,
    hour SMALLINT NOT NULL,      
    minute SMALLINT NOT NULL,    
    hour_description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE date_dim (
    date_id DATE PRIMARY KEY,
    year INTEGER,
    quarter SMALLINT,
    month SMALLINT,
    day_of_week SMALLINT,
    day_of_month SMALLINT,
    day_of_year SMALLINT,
    week_of_year SMALLINT,
    is_holiday SMALLINT CHECK (is_holiday IN (0,1)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE feedback_dim (
    feedback_id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_dim (
    sk_employee_id SERIAL PRIMARY KEY,
    employee_id INTEGER,
    employee_name VARCHAR(35),
    employee_dateofbirth DATE,
    employee_gender VARCHAR(10),
    employee_address VARCHAR(100),
    employee_phone VARCHAR(20),
    salary NUMERIC(10,2),
    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE,
    is_current CHAR(1) DEFAULT 'Y' CHECK (is_current IN ('Y', 'N')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customercarefact (
    customer_id INTEGER,
    date_id DATE,
    time_id TIMESTAMP,
    feedback_id INTEGER,
    employee_id INTEGER,
    interaction_type VARCHAR(50),
    satisfaction_rate NUMERIC(5,2),
    duration INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_customer_care PRIMARY KEY (customer_id, date_id, feedback_id, employee_id, time_id),
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer_dim(sk_passenger_id),
    CONSTRAINT fk_care_date FOREIGN KEY (date_id) REFERENCES date_dim(date_id),
    CONSTRAINT fk_care_feedback FOREIGN KEY (feedback_id) REFERENCES feedback_dim(feedback_id),
    CONSTRAINT fk_care_employee FOREIGN KEY (employee_id) REFERENCES employee_dim(sk_employee_id),
    CONSTRAINT fk_care_time FOREIGN KEY (time_id) REFERENCES time_dim(time_id)
);

INSERT INTO customer_dim VALUES (1,1, 'Ahmed Mohamed', '1985-06-15', 'Male', 'Cairo', '01001234567', 1200, 'Gold', '2024-01-01', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (2,2, 'Sara Ahmed', '1990-12-20', 'Female', 'Alexandria', '01009876543', 800, 'Silver', '2023-07-15', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (3,3, 'Mohamed Hassan', '1978-08-05', 'Male', 'Giza', '01102345678', 1500, 'Platinum', '2022-06-10', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (4,4, 'Nour Amr', '1995-04-22', 'Female', 'Aswan', '01205678901', 400, 'Bronze', '2021-05-20', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (5,5, 'Khaled Ibrahim', '1983-09-30', 'Male', 'Mansoura', '01501112233', 1300, 'Gold', '2020-03-12', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (6,6, 'Mariam Saleh', '1992-11-10', 'Female', 'Suez', '01007654321', 900, 'Silver', '2019-08-25', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (7,7, 'Omar Tarek', '1989-03-05', 'Male', 'Luxor', '01106543210', 1600, 'Platinum', '2018-04-10', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (8,8, 'Layla Adel', '1997-07-18', 'Female', 'Port Said', '01203456789', 500, 'Bronze', '2017-09-30', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (9,9, 'Youssef Nabil', '1980-12-02', 'Male', 'Zagazig', '01507654321', 1100, 'Gold', '2016-06-20', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (10,10, 'Hana Sameh', '1994-05-14', 'Female', 'Tanta', '01005432176', 750, 'Silver', '2015-02-18', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (11,11, 'Hassan Youssef', '1987-10-25', 'Male', 'Fayoum', '01003456789', 950, 'Silver', '2014-08-12', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (12,12, 'Amina Khaled', '1996-03-30', 'Female', 'Ismailia', '01107896543', 600, 'Bronze', '2013-11-05', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (13,13, 'Walid Mahmoud', '1982-07-18', 'Male', 'Damietta', '01204567891', 1400, 'Gold', '2012-09-22', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (14,14, 'Rania Hatem', '1991-12-10', 'Female', 'Minya', '01506543219', 700, 'Silver', '2011-06-15', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (15,15, 'Tarek Salah', '1979-05-05', 'Male', 'Beni Suef', '01007654320', 1700, 'Platinum', '2010-04-30', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (16,16, 'Mona Nader', '1998-08-21', 'Female', 'Sohag', '01104356782', 450, 'Bronze', '2009-07-18', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (17,17, 'Mostafa Adel', '1986-02-14', 'Male', 'Qena', '01203456780', 1250, 'Gold', '2008-03-25', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (18,18, 'Salma Tamer', '1993-09-11', 'Female', 'Hurghada', '01502345678', 850, 'Silver', '2007-12-05', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (19,19, 'Yasser Fathy', '1984-06-07', 'Male', 'Sharm El Sheikh', '01001234568', 1550, 'Platinum', '2006-10-10', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (20,20, 'Heba Magdy', '1999-01-29', 'Female', 'Matrouh', '01107895432', 500, 'Bronze', '2005-05-15', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (21,21, 'Ahmed Shokry', '1988-11-12', 'Male', 'Alexandria', '01005678912', 1100, 'Gold', '2014-02-20', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (22,22, 'Nourhan Saeed', '1995-07-28', 'Female', 'Giza', '01109876543', 750, 'Silver', '2013-05-15', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (23,23, 'Ibrahim Khalil', '1980-04-03', 'Male', 'Aswan', '01206789012', 1600, 'Platinum', '2012-10-10', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (24,24, 'Heba El-Sayed', '1992-09-17', 'Female', 'Mansoura', '01507896532', 900, 'Silver', '2011-08-08', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (25,25, 'Khaled Fathy', '1985-01-22', 'Male', 'Zagazig', '01003456721', 1300, 'Gold', '2010-07-05', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (26,26, 'Mai Tamer', '1997-06-14', 'Female', 'Qena', '01108765432', 550, 'Bronze', '2009-03-25', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (27,27, 'Mohamed Galal', '1978-12-05', 'Male', 'Ismailia', '01203456123', 1800, 'Platinum', '2008-11-12', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (28,28, 'Laila Hossam', '1994-03-19', 'Female', 'Tanta', '01502345671', 800, 'Silver', '2007-06-18', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (29,29, 'Youssef Nabil', '1983-08-07', 'Male', 'Minya', '01001234529', 1450, 'Gold', '2006-09-22', '9999-12-31', 'Y');
INSERT INTO customer_dim VALUES (30,30, 'Sara Adel', '2000-02-01', 'Female', 'Damietta', '01107895421', 480, 'Bronze', '2005-04-30', '9999-12-31', 'Y');



INSERT INTO time_dim (time_id, hour, minute, hour_description)
SELECT 
    (TIMESTAMP '2020-01-01 00:00:00' + (n * INTERVAL '30 minutes')) AS time_id,
    MOD(FLOOR(n / 2)::int, 24) AS hour,
    CASE WHEN MOD(n, 2) = 0 THEN 0 ELSE 30 END AS minute,
    CASE 
        WHEN MOD(FLOOR(n / 2)::int, 24) = 0 THEN 'Midnight'
        WHEN MOD(FLOOR(n / 2)::int, 24) BETWEEN 1 AND 5 THEN 'Early Morning'
        WHEN MOD(FLOOR(n / 2)::int, 24) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN MOD(FLOOR(n / 2)::int, 24) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN MOD(FLOOR(n / 2)::int, 24) BETWEEN 18 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS hour_description
FROM generate_series(0, 47) AS n;


INSERT INTO date_dim (date_id, year, quarter, month, day_of_month, day_of_week, day_of_year, week_of_year, is_holiday) 
VALUES 
(TO_DATE('2020-03-01', 'YYYY-MM-DD'), 2020, 1, 3, 1, 1, 61, 10, 0),
(TO_DATE('2020-03-02', 'YYYY-MM-DD'), 2020, 1, 3, 2, 2, 62, 10, 0),
(TO_DATE('2020-03-03', 'YYYY-MM-DD'), 2020, 1, 3, 3, 3, 63, 10, 0),
(TO_DATE('2020-03-04', 'YYYY-MM-DD'), 2020, 1, 3, 4, 4, 64, 10, 0),
(TO_DATE('2020-03-05', 'YYYY-MM-DD'), 2020, 1, 3, 5, 5, 65, 10, 0),
(TO_DATE('2020-03-06', 'YYYY-MM-DD'), 2020, 1, 3, 6, 6, 66, 10, 0),
(TO_DATE('2020-03-07', 'YYYY-MM-DD'), 2020, 1, 3, 7, 7, 67, 10, 0),
(TO_DATE('2020-03-08', 'YYYY-MM-DD'), 2020, 1, 3, 8, 1, 68, 11, 0),
(TO_DATE('2020-03-09', 'YYYY-MM-DD'), 2020, 1, 3, 9, 2, 69, 11, 0),
(TO_DATE('2020-03-10', 'YYYY-MM-DD'), 2020, 1, 3, 10, 3, 70, 11, 0),
(TO_DATE('2020-03-11', 'YYYY-MM-DD'), 2020, 1, 3, 11, 4, 71, 11, 0),
(TO_DATE('2020-03-12', 'YYYY-MM-DD'), 2020, 1, 3, 12, 5, 72, 11, 0),
(TO_DATE('2020-03-13', 'YYYY-MM-DD'), 2020, 1, 3, 13, 6, 73, 11, 0),
(TO_DATE('2020-03-14', 'YYYY-MM-DD'), 2020, 1, 3, 14, 7, 74, 11, 0),
(TO_DATE('2020-03-15', 'YYYY-MM-DD'), 2020, 1, 3, 15, 1, 75, 12, 0),
(TO_DATE('2020-03-16', 'YYYY-MM-DD'), 2020, 1, 3, 16, 2, 76, 12, 0),
(TO_DATE('2020-03-17', 'YYYY-MM-DD'), 2020, 1, 3, 17, 3, 77, 12, 0),
(TO_DATE('2020-03-18', 'YYYY-MM-DD'), 2020, 1, 3, 18, 4, 78, 12, 0),
(TO_DATE('2020-03-19', 'YYYY-MM-DD'), 2020, 1, 3, 19, 5, 79, 12, 0),
(TO_DATE('2020-03-20', 'YYYY-MM-DD'), 2020, 1, 3, 20, 6, 80, 12, 0),
(TO_DATE('2020-03-21', 'YYYY-MM-DD'), 2020, 1, 3, 21, 7, 81, 12, 0),
(TO_DATE('2020-03-22', 'YYYY-MM-DD'), 2020, 1, 3, 22, 1, 82, 13, 0),
(TO_DATE('2020-03-23', 'YYYY-MM-DD'), 2020, 1, 3, 23, 2, 83, 13, 0),
(TO_DATE('2020-03-24', 'YYYY-MM-DD'), 2020, 1, 3, 24, 3, 84, 13, 0),
(TO_DATE('2020-03-25', 'YYYY-MM-DD'), 2020, 1, 3, 25, 4, 85, 13, 0),
(TO_DATE('2020-03-26', 'YYYY-MM-DD'), 2020, 1, 3, 26, 5, 86, 13, 0),
(TO_DATE('2020-03-27', 'YYYY-MM-DD'), 2020, 1, 3, 27, 6, 87, 13, 0),
(TO_DATE('2020-03-28', 'YYYY-MM-DD'), 2020, 1, 3, 28, 7, 88, 13, 0),
(TO_DATE('2020-03-29', 'YYYY-MM-DD'), 2020, 1, 3, 29, 1, 89, 14, 0),
(TO_DATE('2020-03-30', 'YYYY-MM-DD'), 2020, 1, 3, 30, 2, 90, 14, 0),
(TO_DATE('2020-03-31', 'YYYY-MM-DD'), 2020, 1, 3, 31, 3, 91, 14, 0),
(TO_DATE('2020-04-02', 'YYYY-MM-DD'), 2020, 2, 4, 2, 5, 93, 14, 0),
(TO_DATE('2020-04-03', 'YYYY-MM-DD'), 2020, 2, 4, 3, 6, 94, 14, 0),
(TO_DATE('2020-04-04', 'YYYY-MM-DD'), 2020, 2, 4, 4, 7, 95, 14, 0),
(TO_DATE('2020-04-05', 'YYYY-MM-DD'), 2020, 2, 4, 5, 1, 96, 15, 0),
(TO_DATE('2020-04-06', 'YYYY-MM-DD'), 2020, 2, 4, 6, 2, 97, 15, 0),
(TO_DATE('2020-04-07', 'YYYY-MM-DD'), 2020, 2, 4, 7, 3, 98, 15, 0),
(TO_DATE('2020-04-08', 'YYYY-MM-DD'), 2020, 2, 4, 8, 4, 99, 15, 0),
(TO_DATE('2020-04-09', 'YYYY-MM-DD'), 2020, 2, 4, 9, 5, 100, 15, 0),
(TO_DATE('2020-04-10', 'YYYY-MM-DD'), 2020, 2, 4, 10, 6, 101, 15, 0),
(TO_DATE('2020-04-11', 'YYYY-MM-DD'), 2020, 2, 4, 11, 7, 102, 15, 0),
(TO_DATE('2020-04-12', 'YYYY-MM-DD'), 2020, 2, 4, 12, 1, 103, 16, 0),
(TO_DATE('2020-04-13', 'YYYY-MM-DD'), 2020, 2, 4, 13, 2, 104, 16, 0);


INSERT INTO feedback_dim (feedback_id, type, description) VALUES (1, 'Negative', 'Staff ignored my request for assistance');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (2, 'Neutral', 'it was ok');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (3, 'Negative', 'The check-in process took too long causing unnecessary stress');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (4, 'Negative', 'Flight attendants were not friendly at all');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (5, 'Neutral', 'I didnt feel anything special');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (6, 'Positive', 'I loved the hot towels and complimentary drinks in business class');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (7, 'Positive', 'The airline handled my special meal request perfectly');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (8, 'Positive', 'Everything was smooth from check-in to landing');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (9, 'Positive', 'I can not complain about anything');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (10, 'Positive', 'Nice experiment');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (11, 'Negative', 'My flight was delayed for over 3 hours without any clear explanation');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (12, 'Positive', 'The flight attendants were extremely polite and made the journey comfortable');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (13, 'Negative', 'Lost my baggage and customer service took too long to respond');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (14, 'Positive', 'Smooth check-in process and the flight was on time');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (15, 'Negative', 'Seats were too cramped making the long-haul flight very uncomfortable');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (16, 'Positive', 'The in-flight entertainment had a great selection of movies and music');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (17, 'Negative', 'The food quality was terrible and not worth the extra charge');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (18, 'Positive', 'The pilot kept us informed throughout the flight making us feel at ease');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (19, 'Negative', 'Boarding was chaotic with no clear instructions from the staff');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (20, 'Positive', 'Fast and hassle-free baggage claim which I really appreciated');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (21, 'Negative', 'My flight was canceled last minute and I struggled to get a refund');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (22, 'Positive', 'Friendly staff and very comfortable seating. Will fly again');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (23, 'Negative', 'Customer service was rude when I asked about my delayed flight');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (24, 'Positive', 'I was upgraded to business class for free which made my day');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (25, 'Negative', 'There was no legroom at all my knees were constantly pressed against the seat');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (26, 'Positive', 'The check-in staff was helpful and assisted me with my overweight baggage');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (27, 'Negative', 'The Wi-Fi on board was expensive and didnt work properly');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (28, 'Positive', 'Smooth takeoff and landing the pilot did a great job');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (29, 'Negative', 'No vegetarian meal option available on an international flight');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (30, 'Positive', 'Loved the cleanliness of the aircraft and the modern interior');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (31, 'Negative', 'I was charged an unexpected baggage fee at the last minute');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (32, 'Positive', 'The airline app made it easy to check in and manage my flight details');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (33, 'Negative', 'Staff ignored my request for assistance multiple times');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (34, 'Positive', 'The business class experience was outstanding—worth the price');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (35, 'Negative', 'Uncomfortable seats with barely any recline for a long-haul flight');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (36, 'Positive', 'Boarding was organized and stress-free');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (37, 'Negative', 'The air conditioning was too cold and I couldnt adjust it');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (38, 'Positive', 'The crew made my child feel special with a small toy and extra attention');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (39, 'Negative', 'Security check at the airlines gate was unnecessarily slow');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (40, 'Positive', 'The airline lounge was comfortable and had great food options');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (41, 'Negative', 'My flight was overbooked and I had to wait for the next one');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (42, 'Positive', 'The airline provided compensation for my delayed flight');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (43, 'Negative', 'There was a lack of communication about our flight delay');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (44, 'Positive', 'The boarding process was quick and my flight left on time');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (45, 'Negative', 'The flight was extremely noisy and the crew didnt do anything about it');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (46, 'Positive', 'The seats in economy were surprisingly spacious and comfortable');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (47, 'Negative', 'The check-in counter was understaffed causing long wait times');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (48, 'Positive', 'Flight arrived 20 minutes ahead of schedule');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (49, 'Negative', 'The pilot did not inform us about the turbulence in advance');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (50, 'Positive', 'I loved the hot towels and complimentary drinks in business class');

INSERT INTO feedback_dim (feedback_id, type, description) VALUES (51, 'Negative', 'No charging ports in economy class making it hard to work');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (52, 'Positive', 'Cabin crew was professional and attentive to all passengers');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (53, 'Negative', 'The in-flight meal was stale and not worth the price');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (54, 'Positive', 'Flight attendants were always smiling and willing to help');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (55, 'Negative', 'The airline lost my baggage and I had to wait days to get it back');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (56, 'Positive', 'Seats were very clean and comfortable even in economy class');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (57, 'Negative', 'The check-in process took too long causing unnecessary stress');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (58, 'Positive', 'The free snacks and drinks were a nice touch');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (59, 'Negative', 'Crew members seemed uninterested in helping passengers');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (60, 'Positive', 'I was given extra legroom without asking—great service');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (61, 'Negative', 'The flight was delayed multiple times with no updates');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (62, 'Positive', 'Everything was smooth from check-in to landing');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (63, 'Negative', 'The lavatories were unclean and had a bad odor');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (64, 'Positive', 'Great value for money I got more than I expected');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (65, 'Negative', 'The boarding gate changed at the last minute causing confusion');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (66, 'Positive', 'I enjoyed the free in-flight Wi-Fi service');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (67, 'Negative', 'They ran out of my preferred meal option before they reached my seat');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (68, 'Positive', 'The flight had plenty of storage space for carry-on bags');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (69, 'Negative', 'The baggage claim process took way too long');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (70, 'Positive', 'The airline handled my special meal request perfectly');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (71, 'Negative', 'My seat was broken and I had to sit uncomfortably the entire flight');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (72, 'Positive', 'The customer support team was quick to respond to my queries');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (73, 'Negative', 'The plane was old and looked poorly maintained');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (74, 'Positive', 'A very smooth journey with excellent customer service');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (75, 'Negative', 'The airport lounge was overcrowded and lacked seating');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (76, 'Positive', 'The free upgrade to premium economy was a pleasant surprise.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (77, 'Negative', 'Flight attendants were not friendly at all.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (78, 'Positive', 'The airline offered great last-minute deals.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (79, 'Negative', 'The flight kept getting delayed due to "technical issues."');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (80, 'Positive', 'I felt safe and comfortable throughout the entire flight.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (81, 'Negative', 'Extra charges for choosing a seat were unreasonable.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (82, 'Positive', 'The coffee served on board was actually quite good!');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (83, 'Negative', 'The plane was too noisy making it hard to rest.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (84, 'Positive', 'I received priority boarding as a frequent flyer—great perk!');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (85, 'Negative', 'They didnt allow enough time for passengers to board.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (86, 'Positive', 'The flight attendants made the journey enjoyable with their friendly attitude.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (87, 'Negative', 'I was charged an unexpected fee at the check-in counter.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (88, 'Positive', 'My flight experience was stress-free from start to finish.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (89, 'Negative', 'Limited meal options for long-haul flights.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (90, 'Positive', 'The aircraft was modern and well-maintained.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (91, 'Negative', 'The crew forgot my meal order and didnt apologize.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (92, 'Positive', 'I appreciated the spacious legroom in premium economy.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (93, 'Negative', 'Too many announcements throughout the flight.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (94, 'Positive', 'I had a great flying experience with this airline.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (95, 'Negative', 'I had to pay for water which was ridiculous.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (96, 'Positive', 'The staff went above and beyond to assist me.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (97, 'Negative', 'No blankets were available on a cold overnight flight.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (98, 'Positive', 'They surprised me with a birthday cake on my flight!');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (99, 'Negative', 'Overpriced tickets for the service provided.');
INSERT INTO feedback_dim (feedback_id, type, description) VALUES (100, 'Positive', 'The airline made up for the delay by offering a meal voucher.');


INSERT INTO employee_dim VALUES (1, 1, 'Ahmed Hassan', TO_DATE('1986-04-28', 'YYYY-MM-DD'), 'Male', 'Cairo', '01234567890', 12105, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (2, 2, 'Mona Ali', TO_DATE('1984-06-04', 'YYYY-MM-DD'), 'Female', 'Giza', '01234567891', 12521, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (3, 3, 'Youssef Mohamed', TO_DATE('1987-05-17', 'YYYY-MM-DD'), 'Male', 'Alexandria', '01234567892', 15550, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'N');
INSERT INTO employee_dim VALUES (4, 3, 'Youssef Mohamed', TO_DATE('1987-05-17', 'YYYY-MM-DD'), 'Male', 'New Cairo', '01234567892', 15550, TO_DATE('2024-03-16', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (5, 4, 'Sara Ibrahim', TO_DATE('1987-06-12', 'YYYY-MM-DD'), 'Female', 'Aswan', '01234567893', 17595, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (6, 5, 'Omar Khaled', TO_DATE('1987-11-16', 'YYYY-MM-DD'), 'Male', 'Luxor', '01234567894', 9824, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (7, 6, 'Fatma Adel', TO_DATE('1990-08-24', 'YYYY-MM-DD'), 'Female', 'Mansoura', '01234567895', 11030, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (8, 7, 'Tarek Mostafa', TO_DATE('1986-06-10', 'YYYY-MM-DD'), 'Male', 'Suez', '01234567896', 10800, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'N');
INSERT INTO employee_dim VALUES (9, 7, 'Tarek Mostafa', TO_DATE('1986-06-10', 'YYYY-MM-DD'), 'Male', 'Port Said', '01234567896', 10800, TO_DATE('2024-02-11', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (10, 8, 'Nada Hossam', TO_DATE('1993-02-14', 'YYYY-MM-DD'), 'Female', 'Tanta', '01234567897', 11800, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (11, 9, 'Ali Mahmoud', TO_DATE('1991-10-22', 'YYYY-MM-DD'), 'Male', 'Ismailia', '01234567898', 9700, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (12, 10, 'Yasmin Salah', TO_DATE('1992-07-01', 'YYYY-MM-DD'), 'Female', 'Sharm El-Sheikh', '01234567899', 13000, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
UPDATE employee_dim SET end_date = TO_DATE('2024-01-05', 'YYYY-MM-DD'), is_current = 'N' WHERE employee_id = 15 AND is_current = 'Y';
INSERT INTO employee_dim VALUES (13, 15, 'Mohamed Salah', TO_DATE('1984-09-10', 'YYYY-MM-DD'), 'Male', 'New Damietta', '01234567904', 14000, TO_DATE('2024-01-06', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (14, 16, 'Ramy Saad', TO_DATE('1985-03-25', 'YYYY-MM-DD'), 'Male', 'Alexandria', '01234567905', 10500, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (15, 17, 'Lina Ehab', TO_DATE('1990-12-30', 'YYYY-MM-DD'), 'Female', 'Fayoum', '01234567906', 11200, TO_DATE('2023-01-01', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (16, 51, 'Amira Zaki', TO_DATE('1994-06-08', 'YYYY-MM-DD'), 'Female', 'Dahab', '01234567951', 12500, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (17, 52, 'Hassan Ehab', TO_DATE('1992-01-20', 'YYYY-MM-DD'), 'Male', 'Cairo', '01234567952', 13550, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (18, 53, 'Mariam Khaled', TO_DATE('1993-09-30', 'YYYY-MM-DD'), 'Female', 'Alexandria', '01234567953', 12000, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (19, 54, 'Yousef Samir', TO_DATE('1991-03-25', 'YYYY-MM-DD'), 'Male', 'Giza', '01234567954', 11000, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (20, 55, 'Khaled Tamer', TO_DATE('1989-07-18', 'YYYY-MM-DD'), 'Male', 'Tanta', '01234567955', 13000, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (21, 56, 'Nour Hany', TO_DATE('1990-11-02', 'YYYY-MM-DD'), 'Female', 'Luxor', '01234567956', 11850, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (22, 58, 'Sameh Adel', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (23, 59, 'Ahmed Adel', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (24, 60, 'Abdelrahman Sayed', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (25, 61, 'Seif Khalil', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (26, 62, 'Mohmed Hekal', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (27, 63, 'Mohamed Moaaz', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (28, 64, 'Omar Mustafa', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (29, 65, 'Bassel Walid', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (30, 66, 'Ahmed Nasr', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (31, 67, 'Mohamed Nasr', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (32, 68, 'Hussein Mohamed', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (33, 69, 'Huss', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (34, 70, 'Mohamed Makbool', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (35, 71, 'Ahmed El Sheikh', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (36, 72, 'Ahmed El Adawy', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (37, 73, 'Ahmed Otifi', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (38, 74, 'Mohamed Walid', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (39, 75, 'Ziad Essam', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (40, 76, 'Omar Hany', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (41, 77, 'Mohamed Ramy', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (42, 78, 'Ahmed Sayed', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (43, 79, 'Khaled Essam', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (44, 80, 'Youssef Galal', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (45, 81, 'Amr Ibrahim', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (46, 82, 'Amr Khalid', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (47, 83, 'Diaa Essam', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (48, 84, 'Kareem Walid', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (49, 85, 'Sameh Adel', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');
INSERT INTO employee_dim VALUES (50, 86, 'Sameh Adel', TO_DATE('1993-05-27', 'YYYY-MM-DD'), 'Male', 'Hurghada', '01234567957', 12250, TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 'Y');

INSERT INTO CustomerCareFact VALUES (1, TO_DATE('2020-03-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 40, 'Chat', 4.51, 27);
INSERT INTO CustomerCareFact VALUES (2, TO_DATE('2020-03-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 6, 'Chat', 3.01, 40);
INSERT INTO CustomerCareFact VALUES (3, TO_DATE('2020-03-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 35, 'In-Person', 4.42, 35);
INSERT INTO CustomerCareFact VALUES (4, TO_DATE('2020-03-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 18, 'Chat', 3.06, 35);
INSERT INTO CustomerCareFact VALUES (5, TO_DATE('2020-03-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 33, 'Chat', 1.11, 2);
INSERT INTO CustomerCareFact VALUES (6, TO_DATE('2020-03-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 5, 'In-Person', 3.35, 13);
INSERT INTO CustomerCareFact VALUES (7, TO_DATE('2020-03-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 35, 'Chat', 1.04, 47);
INSERT INTO CustomerCareFact VALUES (8, TO_DATE('2020-03-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 9, 'In-Person', 3.36, 3);
INSERT INTO CustomerCareFact VALUES (9, TO_DATE('2020-03-09', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'Call', 3.89, 47);

INSERT INTO CustomerCareFact VALUES (10, TO_DATE('2020-03-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 33, 'Email', 4.90, 46);
INSERT INTO CustomerCareFact VALUES (11, TO_DATE('2020-03-11', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 14, 'Email', 1.26, 4);
INSERT INTO CustomerCareFact VALUES (12, TO_DATE('2020-03-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 19, 'In-Person', 3.40, 23);
INSERT INTO CustomerCareFact VALUES (13, TO_DATE('2020-03-13', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 40, 'In-Person', 2.11, 46);
INSERT INTO CustomerCareFact VALUES (14, TO_DATE('2020-03-14', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 6, 'In-Person', 2.02, 6);
INSERT INTO CustomerCareFact VALUES (15, TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 22, 'Chat', 4.86, 56);
INSERT INTO CustomerCareFact VALUES (16, TO_DATE('2020-03-16', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 27, 'Call', 2.70, 27);
INSERT INTO CustomerCareFact VALUES (17, TO_DATE('2020-03-17', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 31, 'Email', 3.78, 23);
INSERT INTO CustomerCareFact VALUES (18, TO_DATE('2020-03-18', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 36, 'In-Person', 2.46, 54);
INSERT INTO CustomerCareFact VALUES (19, TO_DATE('2020-03-19', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10, 29, 'Call', 1.94, 58);
INSERT INTO CustomerCareFact VALUES (20, TO_DATE('2020-03-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 24, 'Call', 2.40, 38);
INSERT INTO CustomerCareFact VALUES (21, TO_DATE('2020-03-21', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 18, 'In-Person', 3.74, 59);
INSERT INTO CustomerCareFact VALUES (22, TO_DATE('2020-03-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 18, 'Email', 4.57, 36);
INSERT INTO CustomerCareFact VALUES (23, TO_DATE('2020-03-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 41, 'Email', 4.37, 50);
INSERT INTO CustomerCareFact VALUES (24, TO_DATE('2020-03-24', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 2, 'Email', 2.08, 31);
INSERT INTO CustomerCareFact VALUES (25, TO_DATE('2020-03-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 22, 'Call', 2.09, 22);

INSERT INTO CustomerCareFact VALUES (26, TO_DATE('2020-03-26', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4, 'Chat', 2.82, 6);
INSERT INTO CustomerCareFact VALUES (27, TO_DATE('2020-03-27', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 16, 'Call', 3.98, 6);
INSERT INTO CustomerCareFact VALUES (28, TO_DATE('2020-03-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 3, 'Email', 1.18, 37);
INSERT INTO CustomerCareFact VALUES (29, TO_DATE('2020-03-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 38, 'Call', 3.31, 46);
INSERT INTO CustomerCareFact VALUES (30, TO_DATE('2020-03-30', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 06:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 21, 'Email', 2.53, 48);
INSERT INTO CustomerCareFact VALUES (1, TO_DATE('2020-03-31', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 47, 'In-Person', 1.66, 18);

INSERT INTO CustomerCareFact VALUES (2, TO_DATE('2020-03-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 26, 'Email', 2.94, 3);
INSERT INTO CustomerCareFact VALUES (3, TO_DATE('2020-03-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 47, 'Chat', 4.54, 56);
INSERT INTO CustomerCareFact VALUES (4, TO_DATE('2020-03-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 31, 'Call', 1.89, 37);
INSERT INTO CustomerCareFact VALUES (5, TO_DATE('2020-03-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10, 8, 'Chat', 4.83, 44);
INSERT INTO CustomerCareFact VALUES (6, TO_DATE('2020-03-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 43, 'Email', 2.54, 27);
INSERT INTO CustomerCareFact VALUES (7, TO_DATE('2020-03-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 7, 'Chat', 1.51, 60);
INSERT INTO CustomerCareFact VALUES (8, TO_DATE('2020-03-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 31, 'Chat', 4.02, 39);
INSERT INTO CustomerCareFact VALUES (9, TO_DATE('2020-03-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 2, 'In-Person', 1.59, 56);
INSERT INTO CustomerCareFact VALUES (10, TO_DATE('2020-03-09', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 26, 'Chat', 3.93, 57);
INSERT INTO CustomerCareFact VALUES (11, TO_DATE('2020-03-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 29, 'Call', 1.99, 35);
INSERT INTO CustomerCareFact VALUES (12, TO_DATE('2020-03-11', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 37, 'Email', 1.28, 14);
INSERT INTO CustomerCareFact VALUES (13, TO_DATE('2020-03-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 12, 'In-Person', 2.49, 48);
INSERT INTO CustomerCareFact VALUES (14, TO_DATE('2020-03-13', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 50, 'Call', 1.09, 1);
INSERT INTO CustomerCareFact VALUES (15, TO_DATE('2020-03-14', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 'Call', 1.75, 23);
INSERT INTO CustomerCareFact VALUES (16, TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 35, 'In-Person', 3.83, 20);
INSERT INTO CustomerCareFact VALUES (17, TO_DATE('2020-03-16', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 46, 'Email', 1.30, 45);
INSERT INTO CustomerCareFact VALUES (18, TO_DATE('2020-03-17', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 4, 'Chat', 1.29, 45);
INSERT INTO CustomerCareFact VALUES (19, TO_DATE('2020-03-18', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 32, 'Email', 3.68, 40);
INSERT INTO CustomerCareFact VALUES (20, TO_DATE('2020-03-19', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 29, 'Call', 4.09, 49);

INSERT INTO CustomerCareFact VALUES (21, TO_DATE('2020-03-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 28, 'Email', 1.33, 60);
INSERT INTO CustomerCareFact VALUES (22, TO_DATE('2020-03-21', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 42, 'In-Person', 2.59, 16);
INSERT INTO CustomerCareFact VALUES (23, TO_DATE('2020-03-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4, 'Email', 2.89, 14);
INSERT INTO CustomerCareFact VALUES (24, TO_DATE('2020-03-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 2, 'Email', 4.33, 22);
INSERT INTO CustomerCareFact VALUES (25, TO_DATE('2020-03-24', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 7, 'In-Person', 4.74, 21);
INSERT INTO CustomerCareFact VALUES (26, TO_DATE('2020-03-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 40, 'Email', 3.94, 6);
INSERT INTO CustomerCareFact VALUES (27, TO_DATE('2020-03-26', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 17, 'Chat', 2.29, 43);
INSERT INTO CustomerCareFact VALUES (28, TO_DATE('2020-03-27', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 22, 'Email', 1.71, 30);
INSERT INTO CustomerCareFact VALUES (29, TO_DATE('2020-03-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 45, 'Call', 1.27, 20);
INSERT INTO CustomerCareFact VALUES (30, TO_DATE('2020-03-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 13, 'Chat', 3.07, 22);
INSERT INTO CustomerCareFact VALUES (1, TO_DATE('2020-03-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 10, 'In-Person', 3.30, 18);
INSERT INTO CustomerCareFact VALUES (12, TO_DATE('2020-03-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 49, 'Email', 4.03, 18);
INSERT INTO CustomerCareFact VALUES (13, TO_DATE('2020-03-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 34, 'Call', 2.05, 54);
INSERT INTO CustomerCareFact VALUES (4, TO_DATE('2020-03-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 45, 'Chat', 2.27, 15);
INSERT INTO CustomerCareFact VALUES (4, TO_DATE('2020-03-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 14, 'Email', 3.06, 23);
INSERT INTO CustomerCareFact VALUES (6, TO_DATE('2020-03-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 47, 'In-Person', 2.00, 51);
INSERT INTO CustomerCareFact VALUES (6, TO_DATE('2020-03-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 21, 'Chat', 1.09, 1);
INSERT INTO CustomerCareFact VALUES (5, TO_DATE('2020-03-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 28, 'Call', 1.79, 50);
INSERT INTO CustomerCareFact VALUES (3, TO_DATE('2020-03-09', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 17, 'Call', 3.01, 11);
INSERT INTO CustomerCareFact VALUES (11, TO_DATE('2020-03-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 13, 'In-Person', 4.34, 45);
INSERT INTO CustomerCareFact VALUES (7, TO_DATE('2020-03-11', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 10, 44, 'In-Person', 1.57, 37);
INSERT INTO CustomerCareFact VALUES (7, TO_DATE('2020-03-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 6, 'Email', 2.19, 46);
INSERT INTO CustomerCareFact VALUES (3, TO_DATE('2020-03-13', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 15, 'In-Person', 3.20, 56);
INSERT INTO CustomerCareFact VALUES (30, TO_DATE('2020-03-14', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 41, 'Call', 1.17, 18);
INSERT INTO CustomerCareFact VALUES (11, TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 10, 44, 'Email', 4.51, 31);
INSERT INTO CustomerCareFact VALUES (15, TO_DATE('2020-03-16', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 12, 'Call', 3.12, 24);
INSERT INTO CustomerCareFact VALUES (19, TO_DATE('2020-03-17', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 44, 'In-Person', 2.41, 45);
INSERT INTO CustomerCareFact VALUES (23, TO_DATE('2020-03-18', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 23:30:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 28, 'Chat', 1.21, 16);
INSERT INTO CustomerCareFact VALUES (25, TO_DATE('2020-03-19', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'In-Person', 4.61, 29);
INSERT INTO CustomerCareFact VALUES (22, TO_DATE('2020-03-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9, 31, 'In-Person', 1.00, 42);
INSERT INTO CustomerCareFact VALUES (25, TO_DATE('2020-03-21', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 26, 'Email', 1.64, 4);
INSERT INTO CustomerCareFact VALUES (24, TO_DATE('2020-03-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 43, 'Chat', 2.30, 35);
INSERT INTO CustomerCareFact VALUES (21, TO_DATE('2020-03-23', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 26, 'Call', 2.95, 45);
INSERT INTO CustomerCareFact VALUES (30, TO_DATE('2020-03-24', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 46, 'Chat', 4.20, 39);
INSERT INTO CustomerCareFact VALUES (11, TO_DATE('2020-03-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 42, 'Call', 1.57, 60);
INSERT INTO CustomerCareFact VALUES (5, TO_DATE('2020-03-26', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 25, 'In-Person', 2.76, 42);
INSERT INTO CustomerCareFact VALUES (7, TO_DATE('2020-03-27', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 26, 'Email', 3.33, 9);
INSERT INTO CustomerCareFact VALUES (8, TO_DATE('2020-03-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 27, 'In-Person', 4.99, 26);
INSERT INTO CustomerCareFact VALUES (9, TO_DATE('2020-04-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 12, 'In-Person', 1.90, 49);
INSERT INTO CustomerCareFact VALUES (10, TO_DATE('2020-04-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 29, 'Email', 2.60, 38);
INSERT INTO CustomerCareFact VALUES (11, TO_DATE('2020-04-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 20, 'In-Person', 3.40, 48);
INSERT INTO CustomerCareFact VALUES (12, TO_DATE('2020-04-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 38, 'Call', 2.77, 47);
INSERT INTO CustomerCareFact VALUES (13, TO_DATE('2020-04-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 23, 'In-Person', 4.03, 2);
INSERT INTO CustomerCareFact VALUES (14, TO_DATE('2020-04-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 20, 'Call', 2.42, 57);
INSERT INTO CustomerCareFact VALUES (15, TO_DATE('2020-04-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 41, 'In-Person', 4.59, 32);
INSERT INTO CustomerCareFact VALUES (16, TO_DATE('2020-04-09', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8, 22, 'Call', 2.98, 32);
INSERT INTO CustomerCareFact VALUES (26, TO_DATE('2020-04-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 35, 'Call', 4.51, 33);
INSERT INTO CustomerCareFact VALUES (28, TO_DATE('2020-04-11', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 21, 'Chat', 2.29, 20);
INSERT INTO CustomerCareFact VALUES (29, TO_DATE('2020-04-12', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 39, 'Call', 4.29, 14);
INSERT INTO CustomerCareFact VALUES (29, TO_DATE('2020-04-13', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 26, 'Chat', 3.27, 16);

