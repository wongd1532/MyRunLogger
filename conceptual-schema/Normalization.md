# Database Normalization for Data Integrity

We aim to normalize the database to ensure good data structure (integrity) and eliminate redundant data. Below, the normalization process is demonstrated for this database:

## First Normal Form
- [x] Each cell contains a single atomic value
- [x] All tables have a unique super key:
    - person(**person_id_**, fname, lname)
    - shoe(**shoe_id**, brand, model, version, person_id)
    - run(**run_id**, start_date, weather, social, route_id)
    - route(**route_id**, name, distance, elevation_gain, start_location, end_location)
    - location(**location_id**, name, latitude, longitude, city, country)
    - goal(**goal_id**, start_date, target_date, creation_date, achievement_date, person_id)
    - duration_goal(**goal_id**, duration)
    - distance_goal(**goal_id**, distance)
    - person_run_shoe(**person_id**, **run_id**, shoe_id, duration)

## Second Normal Form
- [x] Database is in First Normal Form
- [x] All non-prime attributes are functionally dependent on the primary key (minimal super key)

## Third Normal Form
- [x] Database is in Second Normal Form
- [x] All non-prime attributes are only dependent on the table's primary key
> NOTE: the ternary relation between entities person, run, and shoe has primary key (person_id, run_id) since this is enough to determine all non-prime attributes.

For the purposes of our database, Third Normal Form suffices and we terminate the normalization process.
