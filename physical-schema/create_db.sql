CREATE DATABASE my_run_logger_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE my_run_logger_db;

CREATE TABLE person (
    person_id           INT AUTO_INCREMENT,                         -- primary key
    fname               VARCHAR(50)             NOT NULL,           -- first name
    lname               VARCHAR(50)             NOT NULL,           -- last name
    birthdate           DATE NOT NULL,                              -- date of birth
    height              INT,                                        -- (optional) height in cm
    weight              DECIMAL(4, 1),                              -- (optional) weight in kg
    gender              ENUM('Unspecified', 'Male', 'Female',
                             'Non-Binary', 'Other') NOT NULL,       -- gender options
    PRIMARY KEY (person_id),
    CHECK chk_person_birthdate_past (birthdate < CURRENT_DATE),     -- person must be born in past
    CHECK chk_person_height_weight_pos (height > 0 AND weight > 0)  -- person must have positive height and weight
);

CREATE TABLE shoe (
    shoe_id             INT AUTO_INCREMENT,
    brand               VARCHAR(50)             NOT NULL,   -- e.x. Nike
    model               VARCHAR(50)             NOT NULL,   -- e.x. Downshifter
    version             VARCHAR(10),                        -- e.x. 12
    PRIMARY KEY (shoe_id)
);

CREATE TABLE pair (
    pair_id             INT AUTO_INCREMENT,
    nickname            VARCHAR(50) NOT NULL DEFAULT 'Unnamed Pair',
    date_purchased      DATE,
    owner_id            INT NOT NULL,           -- foreign key to person table
    shoe_id             INT NOT NULL,           -- foreign key to shoe table
    PRIMARY KEY (pair_id),
    FOREIGN KEY (owner_id) REFERENCES person(person_id),
    FOREIGN KEY (shoe_id) REFERENCES shoe(shoe_id)
);

CREATE TABLE location (
    location_id         INT AUTO_INCREMENT,
    name                VARCHAR(50) NOT NULL,
    city                VARCHAR(50) NOT NULL,
    country             VARCHAR(50) NOT NULL,
    latitude            DECIMAL(9, 6),
    longitude           DECIMAL(9, 6),
    PRIMARY KEY (location_id),
    CHECK chk_lat_long_valid -- valid ranges for latitude and longitude
        (latitude BETWEEN -90 AND 90 AND longitude BETWEEN -180 AND 180)
);

CREATE TABLE route (
    route_id            INT AUTO_INCREMENT,
    name                VARCHAR(50) NOT NULL DEFAULT 'Unnamed Route',
    distance            DECIMAL(10, 1) NOT NULL,
    elevation_gain      INT NOT NULL DEFAULT 0,
    start_location_id   INT NOT NULL, -- foreign key to location table
    end_location_id     INT NOT NULL, -- foreign key to location table
    PRIMARY KEY (route_id),
    FOREIGN KEY (start_location_id) REFERENCES location(location_id),
    FOREIGN KEY (end_location_id) REFERENCES location(location_id),
    CHECK chk_route_distance_pos (distance > 0) -- route distance must be positive
);

CREATE TABLE run (
    run_id              INT AUTO_INCREMENT,
    name                VARCHAR(50) NOT NULL DEFAULT 'Unnamed Run',
    start_datetime      DATETIME NOT NULL,
    weather_desc        VARCHAR(50),
    social_type         ENUM('Unspecified', 'Solo', 'Partner', 'Small Group', 'Large Group', 'Race') NOT NULL,
    route_id            INT NOT NULL, -- foreign key to route table
    PRIMARY KEY (run_id),
    FOREIGN KEY (route_id) REFERENCES route(route_id)
);

CREATE TABLE person_run_pair (
    person_id           INT, -- foreign key to person table
    run_id              INT, -- foreign key to run table
    pair_id             INT NOT NULL, -- foreign key to pair table
    duration            TIME NOT NULL,
    PRIMARY KEY (person_id, run_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (run_id) REFERENCES run(run_id),
    FOREIGN KEY (pair_id) REFERENCES pair(pair_id)
);

CREATE TABLE goal (
    goal_id             INT AUTO_INCREMENT,
    start_date          DATE NOT NULL,
    target_date         DATE NOT NULL,
    completion_status   ENUM('Incomplete', 'Complete') NOT NULL,
    completion_date     DATE,
    person_id           INT,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    CHECK chk_target_after_start (target_date >= start_date), -- target date must be after start date
    CHECK chk_completion_valid -- if completion date exists, completion date is after start date
        (completion_date IS NULL OR completion_date >= start_date),
    CHECK chk_completion_status_correct -- if completion_status is complete, completion_date is not null
        (completion_status = 'Incomplete' OR completion_date IS NOT NULL)
);

CREATE TABLE duration_goal (
    goal_id             INT, -- foreign key to goal table
    duration            TIME NOT NULL,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (goal_id) REFERENCES goal(goal_id)
);

CREATE TABLE distance_goal (
    goal_id             INT, -- foreign key to goal table
    distance            INT NOT NULL,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (goal_id) REFERENCES goal(goal_id),
    CHECK chk_distance_goal_pos (distance > 0) -- goal duration is positive
);
