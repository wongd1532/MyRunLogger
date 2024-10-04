CREATE DATABASE my_run_logger_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE my_run_logger_db;

CREATE TABLE person (
  person_id         INT AUTO_INCREMENT,
  fname             VARCHAR(50) NOT NULL,
  lname             VARCHAR(50),
  gender            ENUM ('Male', 'Female', 'Non-Binary', 'Other')
  birthdate         DATE,
  PRIMARY KEY (person_id)
);

CREATE TABLE shoe (
    shoe_id         INT AUTO_INCREMENT,
    brand           VARCHAR(50) NOT NULL,
    model           VARCHAR(50) NOT NULL,
    version         VARCHAR(10),
    date_purchased  DATE,
    person_id       INT,
    PRIMARY KEY (shoe_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE run (
    run_id              INT AUTO_INCREMENT,
    start_time          DATETIME,
    weather_condition   VARCHAR(50),
    social_condition    ENUM('Solo', 'Partner', 'Small Group', 'Large Group', 'Race') NOT NULL,
    route_id            INT,
    PRIMARY KEY (run_id),
    FOREIGN KEY (route_id) REFERENCES route(route_id)
);

CREATE TABLE route (
    route_id            INT AUTO_INCREMENT,
    name                VARCHAR(50),
    distance            DECIMAL(10, 2) NOT NULL,
    elevation_gain      INT,
    start_location_id   INT,
    end_location_id     INT,
    PRIMARY KEY (route_id),
    FOREIGN KEY (start_location, end_location) REFERENCES location(location_id)
);

CREATE TABLE location (
    location_id     INT AUTO_INCREMENT,
    name            VARCHAR(50) NOT NULL,
    latitude        DECIMAL(9, 6),
    longitude       DECIMAL(9, 6),
    city            VARCHAR(50) NOT NULL,
    country         VARCHAR(50) NOT NULL,
    PRIMARY KEY (location_id)    
);

CREATE TABLE goal (
    goal_id             INT AUTO_INCREMENT,
    start_date          DATE,
    target_date         DATE,
    creation_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    achievement_date    DATE,
    person_id           INT,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    -- constraint for target date > start date
);

CREATE TABLE duration_goal (
    goal_id         INT,
    duration        TIME NOT NULL,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (goal_id) REFERENCES goal(goal_id)
);

CREATE TABLE distance_goal (
    goal_id         INT,
    distance        DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (goal_id) REFERENCES goal(goal_id)
);

CREATE TABLE person_run_shoe (
    person_id       INT,
    run_id          INT,
    shoe_id         INT,
    duration
);
