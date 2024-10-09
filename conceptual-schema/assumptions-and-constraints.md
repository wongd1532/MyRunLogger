# Assumption and Constraints
This list of assumptions and constraints clarifies any ambiguous interactions or relations from the ERD. It also serves as a foundation for setting `ON DELETE` and `ON UPDATE` foreign key constraints in the [database creation](../physical-schema/create_db.sql).

## Entities and Attributes
- Each person is represented by a `person` entity
    - All `person`s must have a `fname`, `lname`, `birthdate`, and `gender`
    - `gender` is defaulted to `"Unspecified"` and can be one of `"Male"`, `"Female"`, `"Non-Binary"`, or `"Other"`
    - A `person` can optionally have a `height` and `weight`
    - If `height` exists, it must be positive
    - If `weight` exists, it must be positive
- Each kind of shoe is represented by a `shoe` entity
    - All `shoe`s must have a `brand` and `model`
    - A `shoe` can optionally have a `version`
- Each pair of shoes is represented by a `pair` entity
    - All `pair`s must have a `pair_name`, `owner_id`, and `shoe_id`
    - `pair_name` is defaulted to `"Unnamed Pair"`
    - A `pair` can optionally have a `date_purchased`
    - If `date_purchased` exists, it must not be in the future
- Each location is represented by a `location` entity
    - All `location`s must have a `location`, `city`, and `country`
    - `location_name` is defaulted to `"Unnamed Location"`
    - A `location` can optionally have a `latitude` and `longitude`
    - If `latitude` exists, it must be between -90 and 90
    - If `longitude` exists, it must be between -180 and 180
- Each route is represented by a `route` entity
    - All `route`s must have a `route_name`, `route_distance`, `route_elevation_gain`, `start_location_id`, and `end_location_id`
    - `route_name` is defaulted to `"Unnamed Route"`
    - `route_elevation_gain` is defaulted to `0`
- Each run is represented by a `run` entity
    - All `run`s must have a `run_name`, `run_start_datetime`, `run_social_type`, and `route_id`
    - `run_name` is defaulted to `"Unnamed Run"`
    - `run_social_type` is defaulted to `"Unspecified"` and can be one of `"Solo"`, `"Partner"`, `"Small Group"`, `"Large Group"`, or `"Race"`
    - A `run` can optionally have a `weather_desc`
- Every instance of a person completing a run is represented by a `person_run` associative entity
    - All `person_run`s must have a `duration_ran`, `distance_ran`, `elevation_gain_ran`, `runner_id`, `run_id`, and `pair_id`
    - `elevation_gain_ran` is defaulted to 0
- Every running goal is represented by a `goal` entity
    - All `goal`s must be exactly one of a `duration_goal` or a `distance_goal` (cannot be both)
        - All `duration_goals` must have a `goal_duration`
        - All `distance_goals` must have a `goal_distance`
    - All `goal`s must have a `goal_start_date`, `goal_target_date`, `completion_status`, and `person_id`
    - `completion_status` is defaulted to `"Incomplete"` and can be either `"Incomplete"` or `"Complete"`
    - A `goal`'s `goal_target_date` must not be before the `goal_start_date`
    - A `goal` can optionally have a `completion_date`
    - If the `completion_date` exists, it must not be before the `start_date`
    - If a goal has no `completion_date`, then `completion_status` is `"Incomplete"`
    - If a goal has a `completion_date`, then `completion_date` must not be before `start_date` and `completion_status` is `"Complete"`

## Relationships
- A `person` can have *0 or many* `goal`s, but `goal`s must be owned by *one and only one* `person`
- A `person` can have *0 or many* `pair`s, but `pair`s must be owned by *one and only one* `person`
- A `person` can run *0 or many* `person_run`s, but `person_run`s must be run by exactly *one and only one* `person`
- A `person_run` must be associated with *one and only one* `run`, but `run`s may be associated with *0 or many* `person_run`s
- A `pair` can be used on *0 or many* `person_run`s, but `person_run`s must be run with *one and only one* `pair`
- A `run` must have *one and only one* `route`, but a `route` can be associated with *0 or many* `run`s
- A `route` must have *one and only one* start `location`, but a `location` can be the start location for *0 or many* `run`s
- A `route` must have *one and only one* end `location`, but a `location` can be the end location for *0 or many* `run`s