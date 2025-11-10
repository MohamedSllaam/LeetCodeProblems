select book_id , title,author, genre, publication_year , current_borrowers from 
(
select book_id , title,author, genre, publication_year , total_copies, (select count(book_id) 
from  borrowing_records where book_id = l.book_id and return_date is null and borrow_date is not null  ) as  current_borrowers 
from  library_books  l
) as D
where  
current_borrowers - total_copies =0
order by current_borrowers desc , title asc