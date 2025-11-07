/* Write your T-SQL query statement below */
 select employee_id , 
 CASE   
    WHEN name not like 'M%' and  employee_id % 2 != 0   THEN salary
    ELSE 0
	END AS bonus
 from Employees
 order by 
employee_id