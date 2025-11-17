/* Write your T-SQL query statement below */


select season ,category,total_quantity ,total_revenue    
from 
(
select season ,category,total_quantity ,total_revenue ,ROW_NUMBER() OVER (PARTITION BY season ORDER BY total_quantity DESC ,total_revenue DESC ) rn   
from  
(

select category,sum( quantity) total_quantity  , sum( quantity * price)  total_revenue ,season 
from   
(
SELECT p.category , s.product_id, s.quantity , s.price ,
CASE
   WHEN month(sale_date  ) in (12,1,2)   THEN 'Winter'
   WHEN month(sale_date  ) in (3,4,5)   THEN 'Spring'
   WHEN month(sale_date  ) in (6,7,8)   THEN 'Summer'
    ELSE 'Fall'
END AS season 
FROM sales s
join products p  on s.product_id= p.product_id
) as dd
  group by  category, season 
  ) as ddddd
  ) as dddddd
  where rn =1
   order by season