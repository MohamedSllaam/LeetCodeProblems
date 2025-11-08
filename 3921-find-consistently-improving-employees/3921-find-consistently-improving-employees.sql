

WITH LatestReview AS (
    SELECT
        employee_id,
        review_date,
        rating, 
		       DENSE_RANK() OVER (PARTITION BY employee_id ORDER BY review_date desc  ) AS rn
    FROM performance_reviews
)

select  L1.employee_id   , e.name ,
L1.rating -(select max(l2.rating) from LatestReview l2 where L2.rn  =3  and  L1.employee_id = l2.employee_id   )as improvement_score
 
from  LatestReview  L1
   join employees e 
on e.employee_id = L1.employee_id 
WHERE
    rn =1 and 
	rating >(select max(l2.rating) from LatestReview l2 where L2.rn  =2  and  L1.employee_id = l2.employee_id   )and
	(select max(l2.rating) from LatestReview l2 where L2.rn  =2  and  L1.employee_id = l2.employee_id   ) >
	(select max(l2.rating) from LatestReview l2 where L2.rn  =3  and  L1.employee_id = l2.employee_id   )
order by  improvement_score desc,  name asc

