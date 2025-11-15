
WITH LatestReview AS (
  SELECT 
       t1.test_id  ,
     t1.patient_id  ,
     t1.test_date  ,
     t1.result  ,
	  t2.test_date second_date  ,
     t2.result  second_result,
	 DATEDIFF(DAY,  t1.test_date,t2.test_date) AS recovery_time,
		        ROW_NUMBER() OVER (PARTITION BY t1.patient_id ORDER BY t1.test_date  ) AS rn
    FROM covid_tests t1
    	join covid_tests t2
	on t1.patient_id =t2.patient_id and t1.test_date  < t2.test_date  and  t2. result = 'Negative' 
	where t1.result = 'Positive' 
	)
select l.patient_id , p.patient_name , p.age ,l.recovery_time from LatestReview  l
join patients p
on l.patient_id  = p.patient_id
where rn =1 and second_date is not null
order by recovery_time, p.patient_name