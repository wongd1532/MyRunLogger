CREATE DATABASE my_run_logger_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE my_run_logger_db;

CREATE TABLE person (
    person_id           INT AUTO_INCREMENT,         -- primary key
    fname               VARCHAR(50) NOT NULL,       -- first name
    lname               VARCHAR(50) NOT NULL,       -- last name
    birthdate           DATE NOT NULL,              -- date of birth
    height              INT,                        -- (optional) height in cm
    weight              DECIMAL(4, 1),              -- (optional) weight in kg
    gender              ENUM('Unspecified', 'Male', 'Female',
                             'Non-Binary', 'Other') NOT NULL,   -- gender options
    PRIMARY KEY (person_id),
    CHECK chk_person_birthdate_past (birthdate < CURRENT_DATE),     -- person must be born in past
    CHECK chk_person_height_pos (height IS NULL OR height > 0),     -- person height is null or positive
    CHECK chk_person_weight_pos (weight IS NULL or weight > 0)      -- person weight is null or positive
);

CREATE TABLE shoe (
    shoe_id             INT AUTO_INCREMENT,         -- primary key
    brand               VARCHAR(50) NOT NULL,       -- e.x. Nike
    model               VARCHAR(50) NOT NULL,       -- e.x. Downshifter
    version             VARCHAR(10),                -- e.x. 12
    PRIMARY KEY (shoe_id)
);

CREATE TABLE pair (
    pair_id             INT AUTO_INCREMENT,     -- primary key
    pair_name       VARCHAR(50) NOT NULL DEFAULT 'Unnamed Pair',    -- personal name for pair of shoes
    date_purchased      DATE,                   -- nullable, to track pair age
    owner_id            INT NOT NULL,           -- foreign key to person table
    shoe_id             INT NOT NULL,           -- foreign key to shoe table
    PRIMARY KEY (pair_id),
    FOREIGN KEY (owner_id) REFERENCES person(person_id)
        ON DELETE CASCADE       -- deleting person deletes their pairs of shoes
        ON UPDATE CASCADE,      -- updating person updates their pair of shoes
    FOREIGN KEY (shoe_id) REFERENCES shoe(shoe_id)
        ON DELETE RESTRICT      -- cannot delete shoe if a pair of that shoe exists
        ON UPDATE CASCADE       -- updating shoe updates pairs of that shoe
);

CREATE TABLE location (
    location_id         INT AUTO_INCREMENT,         -- primary key
    location_name       VARCHAR(50) NOT NULL,       -- location name
    city                VARCHAR(50) NOT NULL,       -- city name
    country             VARCHAR(50) NOT NULL,       -- country name
    latitude            DECIMAL(9, 6),              -- nullable latitude
    longitude           DECIMAL(9, 6),              -- nullable longitude
    PRIMARY KEY (location_id),
    CHECK chk_location_latitude_valid (latitude BETWEEN -90 AND 90),        -- valid range for latitude
    CHECK chk_location_longitude_valid (longitude BETWEEN -180 AND 180)     -- valid range for longitude
);

CREATE TABLE route (
    route_id                INT AUTO_INCREMENT,         -- primary key
    route_name              VARCHAR(50) NOT NULL DEFAULT 'Unnamed Route',       -- route name
    route_distance          DECIMAL(10, 1) NOT NULL,    -- route distance in km to nearest 1 decimal
    route_elevation_gain    INT NOT NULL DEFAULT 0,     -- elevation gain in meters
    start_location_id       INT NOT NULL,               -- foreign key to location table
    end_location_id         INT NOT NULL,               -- foreign key to location table
    PRIMARY KEY (route_id),
    FOREIGN KEY (start_location_id) REFERENCES location(location_id)
        ON DELETE RESTRICT      -- cannot delete location if route starts at location
        ON UPDATE CASCADE,      -- updating location updates route
    FOREIGN KEY (end_location_id) REFERENCES location(location_id)
        ON DELETE RESTRICT      -- cannot delete location if route ends at location
        ON UPDATE CASCADE,      -- updating location updates route
    CHECK chk_route_distance_pos (route_distance > 0)     -- route distance must be positive
);

CREATE TABLE run (
    run_id                  INT AUTO_INCREMENT,         -- primary key
    run_name                VARCHAR(50) NOT NULL DEFAULT 'Unnamed Run',     -- run name
    run_start_datetime      DATETIME NOT NULL,          -- time of start
    weather_desc            VARCHAR(50),                -- nullable weather description (e.x. Sunny)
    social_type             ENUM('Unspecified', 'Solo', 'Partner',
                                 'Small Group', 'Large Group', 'Race') NOT NULL, -- type of run
    route_id                INT NOT NULL,               -- foreign key to route table
    PRIMARY KEY (run_id),
    FOREIGN KEY (route_id) REFERENCES route(route_id)
        ON DELETE SET NULL      -- deleting route doesn't delete all runs on that route
        ON UPDATE SET NULL      -- updating route doesn't update route for past runs on that route
);

CREATE TABLE person_run (
    runner_id           INT,                        -- primary key, foreign key to person table
    run_id              INT,                        -- primary key, foreign key to run table
    pair_id             INT NULL,                   -- foreign key to pair table, nullable if pair of shoes is deleted
    duration_ran        TIME NOT NULL,              -- duration ran by runner during run
    distance_ran        DECIMAL(10, 1) NOT NULL,    -- distance ran by runner during run
    PRIMARY KEY (runner_id, run_id),
    FOREIGN KEY (runner_id) REFERENCES person(person_id)
        ON DELETE CASCADE       -- deleting person deletes their runs
        ON UPDATE CASCADE,      -- updating person updates their runs
    FOREIGN KEY (run_id) REFERENCES run(run_id)
        ON DELETE CASCADE       -- deleting run deletes person's run
        ON UPDATE CASCADE,      -- updating run updates person's run
    FOREIGN KEY (pair_id) REFERENCES pair(pair_id)
        ON DELETE SET NULL      -- deleting pair of shoes doesn't delete person's run
        ON UPDATE CASCADE       -- updating pair of shoes updates person's run
);

CREATE TABLE goal (
    goal_id             INT AUTO_INCREMENT,     -- primary key
    start_date          DATE NOT NULL,          -- start date for goal period
    target_date         DATE NOT NULL,          -- end date for goal period
    completion_status   ENUM('Incomplete', 'Complete') NOT NULL, -- 'Incomplete' default, or 'Complete' if goal achieved
    completion_date     DATE,                   -- date the goal is achieved
    person_id           INT,                    -- goal owner
    PRIMARY KEY (goal_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
        ON DELETE CASCADE       -- deleting person deletes person's goals
        ON UPDATE CASCADE,      -- updating person updates person's goals
    CHECK chk_target_after_start (target_date >= start_date),               -- target date must be after start date
    CHECK chk_completion_valid
        (completion_date IS NULL OR completion_date >= start_date),         -- if completion date exists, completion date is after start date
    CHECK chk_completion_status_correct
        (completion_status = 'Incomplete' OR completion_date IS NOT NULL)   -- if completion_status is complete, completion_date is not null
);

CREATE TABLE duration_goal (
    goal_id             INT,            -- primary key, foreign key to goal table
    duration            TIME NOT NULL,  -- total goal duration
    PRIMARY KEY (goal_id),
    FOREIGN KEY (goal_id) REFERENCES goal(goal_id)
        ON DELETE CASCADE       -- deleting super class goal record deletes subclass duration_goal
        ON UPDATE CASCADE       -- updating super class goal record updates subclass duration_goal
);

CREATE TABLE distance_goal (
    goal_id             INT,                        -- primary key, foreign key to goal table
    distance            DECIMAL(10, 1) NOT NULL,    -- total goal distance
    PRIMARY KEY (goal_id),
    FOREIGN KEY (goal_id) REFERENCES goal(goal_id)
        ON DELETE CASCADE       -- deleting super class goal record deletes subclass distance_goal
        ON UPDATE CASCADE       -- updatign super class goal record updates subclass distance_goal
    CHECK chk_distance_goal_pos (distance > 0)      -- goal distance is positive
);
