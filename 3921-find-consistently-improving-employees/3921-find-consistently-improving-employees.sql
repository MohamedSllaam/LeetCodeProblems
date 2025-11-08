
WITH LatestReview AS (
    SELECT
        employee_id,
        review_date,
        rating, 
		       DENSE_RANK() OVER (PARTITION BY employee_id ORDER BY review_date desc  ) AS rn
    FROM performance_reviews
)

select  L1.employee_id   , e.name ,
L1.rating - L3.rating  as improvement_score
 
from  LatestReview  L1
   join employees e 
on e.employee_id = L1.employee_id 
   join LatestReview L2
on L2.employee_id = L1.employee_id  and L2.rn  =2 
join LatestReview L3
on L3.employee_id = L1.employee_id  and L3.rn  =3 

WHERE
    L1.rn =1  
	 and L1.rating > L2.rating and L2.rating > L3.rating
order by  improvement_score desc,  name asc

