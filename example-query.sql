use my_run_logger_db;

select 		pname.fname,
			pa.pair_name,
			SUM(pr.distance_ran) total_distance
from 		person p 
inner join	person pname on pname.person_id = p.person_id
inner join 	person_run pr on pr.runner_id = p.person_id
inner join  pair pa on pa.pair_id = pr.pair_id
group by	p.person_id, pa.pair_id;
