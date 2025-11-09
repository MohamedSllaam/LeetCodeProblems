select  p1.product_id product1_id, p2.product_id product2_id, p1.category product1_category,  p2.category product2_category,count(  pp2.user_id) customer_count from
ProductInfo p1 join
ProductPurchases pp  
on pp.product_id= p1.product_id 
 join ProductPurchases pp2 
 on  pp.user_id = pp2.user_id and  pp.product_id < pp2.product_id
join  ProductInfo p2
on pp2.product_id= p2.product_id 
group by  p1.product_id, p2.product_id, p1.category  , p2.category
having count(  pp2.user_id) >= 3
order by customer_count desc , product1_id ,product2_id
