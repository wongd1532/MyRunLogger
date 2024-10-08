# Assumption and Constraints
This list of assumptions and constraints clarifies any ambiguous interactions or relations from the ERD. It also serves as a foundation for setting `ON DELETE` and `ON UPDATE` foreign key constraints in the [database creation](../physical-schema/create_db.sql).

## Entities and Attributes
- Each person is represented by a `person` entity
    - All `person`s must have a `fname`, `lname`, `birthdate`, and `gender`
    - `gender` is defaulted to `"Unspecified"`
    - A `person` can optionally have a `height` and `weight`
- Each kind of shoe is represented by a `shoe` entity
    - All `shoe`s must have a `brand` and `model`
    - A `shoe` can optionally have a `version`
- Each pair of shoes is represented by a `pair` entity
    - All `pair`s must have a `pair_name`, `owner_id`, and `shoe_id`
    - `pair_name` is defaulted to `"Unnamed Pair"`
    - A `pair` can optionally have a `date_purchased`
- Each location is represented by a `location` entity
    - All `location`s must have a `location`, `city`, and `country`
    - `location_name` is defaulted to `"Unnamed Location"`
    - A `location` can optionally have a `latitude` and `longitude`
- Each route is represented by 