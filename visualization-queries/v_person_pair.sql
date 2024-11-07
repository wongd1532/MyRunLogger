use my_run_logger_db;

select      p.person_id,
            concat(p.fname, ' ', p.lname),
            pa.pair_name
from        person p 
inner join  pair pa on pa.owner_id = p.person_id;
