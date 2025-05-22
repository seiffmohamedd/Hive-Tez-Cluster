CREATE DATABASE IF NOT EXISTS customer_care_dw
COMMENT 'Customer Care Data Warehouse'
LOCATION '/user/hadoop/customer_care/db';

USE customer_care_dw;

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;



CREATE EXTERNAL TABLE customer_dim_staging (
    sk_passenger_id INT,
    passenger_id INT,
    passenger_name STRING,
    passenger_dateofbirth DATE,
    passenger_gender STRING,
    passenger_address STRING,
    passenger_phone STRING,
    passenger_points INT,
    passenger_status STRING,
    start_date DATE,
    end_date STRING,
    is_current STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care/customer_dim'
TBLPROPERTIES (
    "skip.header.line.count"="1" 
);

select * from customer_dim_staging

CREATE TABLE customer_dim (
    sk_passenger_id INT,
    passenger_id INT,
    passenger_name STRING,
    passenger_dateofbirth DATE,
    passenger_gender STRING,
    passenger_address STRING,
    passenger_phone STRING,
    passenger_points INT,
    start_date DATE,
    end_date STRING,
    is_current STRING
)
PARTITIONED BY (passenger_status STRING)
CLUSTERED BY (passenger_id) INTO 10 BUCKETS
STORED AS ORC;


INSERT OVERWRITE TABLE customer_dim PARTITION(passenger_status)
SELECT 
    sk_passenger_id, passenger_id, passenger_name, passenger_dateofbirth,
    passenger_gender, passenger_address, passenger_phone, passenger_points,
    start_date, end_date, is_current, passenger_status
FROM customer_dim_staging;



select * from customer_dim where passenger_status = 'Gold'







CREATE EXTERNAL TABLE time_dim_staging (
    time_id TIMESTAMP,
    hour INT,
    minute INT,
    hour_description STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care/time_dim'
TBLPROPERTIES (
    "skip.header.line.count"="1"
);




CREATE TABLE time_dim (
    time_id TIMESTAMP,
    hour INT,
    minute INT,
    hour_description STRING
    
)
STORED AS ORC;



INSERT OVERWRITE TABLE time_dim
SELECT 
    time_id, hour, minute, hour_description
FROM time_dim_staging;




select * from time_dim




CREATE EXTERNAL TABLE date_dim_staging (
    date_id DATE,
    year INT,
    quarter INT,
    month INT,
    day_of_week INT,
    day_of_month INT,
    day_of_year INT,
    week_of_year INT,
    is_holiday INT,
    year_part INT,
    quarter_part INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care/date_dim'
TBLPROPERTIES (
    "skip.header.line.count"="1" 
);

CREATE TABLE date_dim (
    date_id DATE,
    year INT,
    quarter INT,
    month INT,
    day_of_week INT,
    day_of_month INT,
    day_of_year INT,
    week_of_year INT,
    is_holiday INT
)
STORED AS ORC;

INSERT OVERWRITE TABLE date_dim
SELECT 
    date_id, 
    year, 
    quarter,
    month, 
    day_of_week, 
    day_of_month, 
    day_of_year, 
    week_of_year, 
    is_holiday
FROM date_dim_staging;




select * from date_dim




CREATE EXTERNAL TABLE feedback_dim_staging (
    feedback_id INT,
    type STRING,
    description STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care/feedback_dim'
TBLPROPERTIES (
    "skip.header.line.count"="1"
);


CREATE TABLE feedback_dim (
    feedback_id INT,
    type STRING,
    description STRING
)
STORED AS ORC;


INSERT OVERWRITE TABLE feedback_dim
SELECT 
    feedback_id,
    type,
    description
FROM feedback_dim_staging;

select * from feedback_dim




CREATE EXTERNAL TABLE employee_dim_staging (
    sk_employee_id INT,
    employee_id INT,
    employee_name STRING,
    employee_dateofbirth DATE,
    employee_gender STRING,
    employee_address STRING,
    employee_phone STRING,
    salary DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    is_current STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care/employee_dim'
TBLPROPERTIES (
    "skip.header.line.count"="1"
);



CREATE TABLE employee_dim (
    sk_employee_id INT,
    employee_id INT,
    employee_name STRING,
    employee_dateofbirth DATE,
    employee_gender STRING,
    employee_address STRING,
    employee_phone STRING,
    salary DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    is_current STRING
)
CLUSTERED BY (employee_id) INTO 10 BUCKETS
STORED AS ORC
TBLPROPERTIES (
    'transactional'='true'
);





INSERT INTO TABLE employee_dim
SELECT 
    sk_employee_id,
    employee_id,
    employee_name,
    employee_dateofbirth,
    employee_gender,
    employee_address,
    employee_phone,
    salary,
    start_date,
    end_date,
    is_current
FROM employee_dim_staging;

select * from employee_dim

CREATE EXTERNAL TABLE customercarefact_staging (
    customer_id INT,
    date_str STRING,
    time_str STRING,
    feedback_id INT,
    employee_id INT,
    interaction_type STRING,
    satisfaction_rate DECIMAL(5,2),
    duration INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care/customercarefact'
TBLPROPERTIES (
    "skip.header.line.count"="1"
);

select * from customercarefact_staging

CREATE TABLE customercarefact (
    customer_id INT,
    time_id TIMESTAMP,
    date_id DATE,
    feedback_id INT,
    employee_id INT,
    satisfaction_rate DECIMAL(5,2),
    duration INT
)
PARTITIONED BY (interaction_type STRING)
CLUSTERED BY (customer_id) INTO 10 BUCKETS
STORED AS ORC;


INSERT OVERWRITE TABLE customercarefact PARTITION(interaction_type)
SELECT 
    customer_id,
    CAST(time_str AS TIMESTAMP),
    CAST(date_str AS DATE),
    feedback_id,
    employee_id,
    satisfaction_rate,
    duration,
    interaction_type
FROM customercarefact_staging;


MSCK REPAIR TABLE customercarefact;

select * from customercarefact;


CREATE EXTERNAL TABLE IF NOT EXISTS passengers_staging (
    passenger_id INT,
    name STRING,
    date_of_birth DATE,
    gender STRING,
    address STRING,
    phone STRING,
    points INT,
    status STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care_staging/passengers';

select * from passengers_staging


CREATE EXTERNAL TABLE IF NOT EXISTS employees_staging (
  employee_id INT,
  employee_name STRING,
  employee_dateofbirth DATE,
  employee_gender STRING,
  employee_address STRING,
  employee_phone STRING,
  salary FLOAT,
  is_current STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care_staging/employees';


select * from employees_staging

CREATE EXTERNAL TABLE IF NOT EXISTS feedback_staging (
  feedback_id INT,
  type STRING,
  description STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care_staging/feedback';

CREATE EXTERNAL TABLE IF NOT EXISTS customer_interactions_staging (
  interaction_id INT,
  customer_id INT,
  interaction_time STRING,
  interaction_date STRING,
  feedback_id INT,
  employee_id INT,
  satisfaction_rate INT,
  duration INT,
  interaction_type STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hadoop/customer_care_staging/customer_interactions';




