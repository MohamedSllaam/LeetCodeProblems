

WITH MaxProducts AS
(
    SELECT
        i.store_id,
        i.product_name,
        i.price,
		i.quantity
    FROM inventory i
    WHERE i.price = (
        SELECT MAX(i2.price)
        FROM inventory i2
        WHERE i2.store_id = i.store_id
    ) and
	(
        SELECT count(i2.product_name)
        FROM inventory i2
        WHERE i2.store_id = i.store_id
    ) >=3
),
 MinProducts AS
(
select  i.store_id ,i.product_name ,i.quantity,i.price 
from inventory i
where  i.price =(select min(i2.price) from inventory i2 
where i2.store_id =  i.store_id )
and
	(
        SELECT count(i2.product_name)
        FROM inventory i2
        WHERE i2.store_id = i.store_id
    ) >=3
)

SELECT mx.store_id ,s.store_name,s.location ,mx.product_name most_exp_product ,
mi.product_name cheapest_product ,  
CAST(ROUND(1.0 * mi.quantity / mx.quantity, 2) AS DECIMAL(10,2)) imbalance_ratio from
MaxProducts mx join MinProducts mi
on  mx.store_id = Mi.store_id
join stores s
 on mx.store_id = s.store_id
  where mx.quantity < mi.quantity
 order by imbalance_ratio desc , store_name asc


