# Database Normalization for Data Integrity
The goal of the normalization process was to ensure good data structure (integrity) and eliminate redundant data.

Several iterations of the ERD and Relational Data Model were needed to achieve the current refined conceptual schema. During this process, I learned some new concepts and have highlighted major iterations and considerations below:

## Removing Data Redundancy: Person - Pair - Shoe
Initially, this relationship was only represented by the person and shoe entity. Through normalization, I realized that I could reduce data redunancy by separating the Shoes records into Shoes and Pair records, where pairs exist as a pair of a specific kind of shoe.

## Associative Entity and Ternary Relationship: Person - Run - Pair
Although I learned about the basic Chen ERD notation in database courses (CS 330, CS 338), I was not taught about Associative Entities or Ternary Relationships. In this situation, using an associative entity makes sense to represent the relationship between the person, run, and pair entities: A person runs a run with a pair of shoes. 

To capture this, I created an associative entity (person_run) between person and run. Each record in this relation represents each person's version of a run, hence there are run metrics specific to each record. Even though multiple people can participate in a single run, they may stray from the route resulting in varying distances or elevation gains, or run for different durations.

Additionally, each person must use exactly one pair of shoes for a run, and a pair can be used for many runs. This relationship's cardinality and ordinality can be represented as:
- Total participation from person_run, exactly one
- Partial participation from pair, zero or many

So it makes sense to include the pair_id field in the person_run relation.

## Crow's Foot Notation for Relational Data Model
I was taught basic Chen ERD notation in school, but often saw and didn't bother learning the unfamiliar Crow's Foot Notation. Needing to create an ERD diagram and Relational Data Model, I used this as an opportunity to learn the Crow's Foot Notation.

Previously, I would create relational data models by listing tables and their fields horizontally, then drawing arrows to foreign keys. I created a more compact and simple Relational Data Model using Crow's Foot Notation.

## Normal Forms: BCNF vs 3NF
For the purpose of this database, it's acceptable to not use Boyce-Codd Normal Form (BCNF) because this project is small-scale enough that the overhead of enforcing BCNF is inefficient.

Instead, we can verify that the database is indeed in Third Normal Form (3NF):

### First Normal Form
- [x] No multivalued attributes
- [x] No repeating records

### Second Normal Form
- [x] All non-key attributes are fully functionally dependent on the entire primary key
- [x] For composite primary keys, no non-key attribute is dependent on just part of the key

### Third Normal Form
- [x] All non-prime attributes only depend on prime attributes
