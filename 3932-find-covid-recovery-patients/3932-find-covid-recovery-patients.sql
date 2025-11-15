 SELECT 
       t1.patient_id ,
	   p.patient_name,
	   p.age,
	DATEDIFF(DAY, min( t1.test_date),min(t2.test_date)) AS recovery_time	   
    FROM covid_tests t1
    	join covid_tests t2
	on t1.patient_id =t2.patient_id and t1.test_date  < t2.test_date  and  t2. result = 'Negative' 
	and t1.result = 'Positive'    
    join patients p
on t1.patient_id  = p.patient_id
group by    t1.patient_id , p.patient_name,  p.age
order by recovery_time, p.patient_name