/* Write your T-SQL query statement below */

with ddd as
(
select employee_id ,   IIF(sum(duration_hours)>20, 1, 0) meeting_heavy

from meetings
group by employee_id , DATEPART(iso_week, meeting_date), YEAR(meeting_date) 
)
select  e.employee_id, e.employee_name , e.department , sum(meeting_heavy) meeting_heavy_weeks from ddd  d
join employees e on   d.employee_id = e.employee_id
group by  e.employee_id, e.employee_name , e.department 
having sum(meeting_heavy) >=2
order by  meeting_heavy_weeks desc , e.employee_name  