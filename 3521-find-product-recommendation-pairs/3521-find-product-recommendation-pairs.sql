 
 
 select PP1.product_id product1_id ,  PP2.product_id product2_id , PI1.category product1_category , PI2.category product2_category ,  count(  distinct PP1.user_id ) customer_count   from 
 ProductPurchases PP1
join ProductInfo PI1
 on PP1.product_id = PI1.product_id
  join  ProductPurchases PP2
   on  PP1.user_id = PP2.user_id and PP1.product_id < PP2.product_id 
   join  ProductInfo PI2
     on   PI2.product_id = PP2.product_id 
  group by PP1.product_id ,  PP2.product_id , PI1.category , PI2.category
 having   count(  PP1.user_id )  >=3
 order by customer_count desc ,  product1_id , product2_id 