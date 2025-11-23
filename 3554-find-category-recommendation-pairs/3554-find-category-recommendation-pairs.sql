/* Write your T-SQL query statement below */


select  p.category category1, p2.category  category2 , count(distinct pp.user_id) customer_count from ProductPurchases pp   join ProductInfo  p 
on p.product_id = pp.product_id
join ProductPurchases pp2 on 
pp.user_id = pp2.user_id 
 join ProductInfo  p2 
 on pp2.product_id = p2.product_id and p.category< p2.category
 group by p.category, p2.category
 having count(distinct pp.user_id) >= 3
 order by customer_count desc ,  category1 ,category2

