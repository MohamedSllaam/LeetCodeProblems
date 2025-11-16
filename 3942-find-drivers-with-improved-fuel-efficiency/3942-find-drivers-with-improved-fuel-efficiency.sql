
with Avg_fuel_consumed as 
(
	select t1.driver_id,
	AVG(t1.distance_km /t1.fuel_consumed ) avg_First_half ,
	AVG(t2.distance_km /t2.fuel_consumed )  avg_second_half 
	from 
	trips t1
	join trips t2
	on t1.driver_id = t2.driver_id and  MONTH(t1.trip_date) BETWEEN 1 AND 6 and  MONTH(t2.trip_date) BETWEEN 7 AND 12 
	group by t1.driver_id
	)
	select  a.driver_id, d.driver_name, CAST((avg_First_half ) AS DECIMAL(10,2)) first_half_avg ,CAST(( avg_second_half ) AS DECIMAL(10,2)) second_half_avg ,  CAST((avg_second_half - avg_First_half) AS DECIMAL(10,2)) efficiency_improvement  from Avg_fuel_consumed a
	join drivers d on  a.driver_id = d.driver_id
	where  CAST((avg_second_half - avg_First_half) AS DECIMAL(10,2))>0
	order by  efficiency_improvement desc , d.driver_name
	 
