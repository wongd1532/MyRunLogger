USE my_run_logger_db;

-- LOAD PERSON 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\person_1014_data.csv'
INTO TABLE person
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(fname, lname, birthdate, height, weight, gender);      -- specify the table columns

-- LOAD SHOE 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\shoe_1014_data.csv'
INTO TABLE shoe
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(brand, model, version);        -- specify the table columns

-- LOAD PAIR 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\pair_1014_data.csv'
INTO TABLE pair
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(pair_name, date_purchased, owner_id, shoe_id);     -- specify the table columns

-- LOAD LOCATION 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\location_1014_data.csv'
INTO TABLE location
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(location_name, city, country, latitude, longitude);    -- specify the table columns

-- LOAD ROUTE 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\route_1014_data.csv'
INTO TABLE route
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(route_name, route_distance, route_elevation_gain, start_location_id, end_location_id);     -- specify the table columns

-- LOAD RUN 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\run_1014_data.csv'
INTO TABLE run
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(run_name, run_start_datetime, weather_desc, social_type, route_id);    -- specify the table columns

-- LOAD PERSON_RUN 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\person_run_1014_data.csv'
INTO TABLE person_run
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(duration_ran, distance_ran, elevation_gain_ran, runner_id, run_id, pair_id);   -- specify the table columns

-- LOAD GOAL 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\goal_1014_data.csv'
INTO TABLE goal
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(goal_start_date, goal_target_date, completion_status, completion_date, person_id);     -- specify the table columns

-- LOAD DISTANCE_GOAL 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\distance_goal_1014_data.csv'
INTO TABLE distance_goal
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(goal_distance, goal_id);       -- specify the table columns

-- LOAD DURATION_GOAL 1014 DATA
LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Data\MyRunLogger_1014_data\duration_goal_1014_data.csv'
INTO TABLE duration_goal
FIELDS TERMINATED BY ','        -- delimiter used in the CSV file (commas)
LINES TERMINATED BY '\n'        -- lines are typically terminated by newlines
IGNORE 1 LINES                  -- if your CSV has a header row
(goal_duration, goal_id);       -- specify the table columns
