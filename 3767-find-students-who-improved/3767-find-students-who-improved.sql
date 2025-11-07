/* Write your T-SQL query statement below */
-- select s1.student_id , s1.subject, s1.score first_score, s2.score latest_score  from Scores S1 join  Scores S2 on
--  S1.student_id = S2.student_id and S1.subject = S2.subject
--  where   
--  S1.exam_date < S2.exam_date and  S1.score <  S2.score 

 select s1.student_id , s1.subject,  s1.score  first_score,  s2.score  latest_score from Scores S1 join  Scores S2 on
 S1.student_id = S2.student_id and S1.subject = S2.subject 
 where   
   S1.exam_date < S2.exam_date 
   and
  S1.score <  S2.score 
  and 
  s1.exam_date = 
  (SELECT MIN(S3.exam_date) FROM Scores S3 
  where  s1.student_id =S3.student_id and s1.subject = S3.subject )
    and 
  s2.exam_date = 
  (SELECT max(S3.exam_date) FROM Scores S3 
  where  s1.student_id =S3.student_id and s1.subject = S3.subject )
   

 

