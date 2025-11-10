/* Write your T-SQL query statement below */
select book_id , title,author, genre, publication_year , (select count(book_id) 
from  borrowing_records where book_id = l.book_id and return_date is null and borrow_date is not null  ) as  current_borrowers 
from  library_books  l
where  
(select count(book_id) 
from  borrowing_records where book_id = l.book_id and return_date is null and borrow_date is not null  ) - total_copies =0
order by current_borrowers desc , title asc