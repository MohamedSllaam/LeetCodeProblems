select * 
from Users
where  email like '%.com' and email like '%@%'
  AND PATINDEX('%[^a-zA-Z0-9_]%', LEFT(email, CHARINDEX('@', email) - 1)) = 0
  and 
  PATINDEX('%[^a-zA-Z]%', 
        SUBSTRING(
            email, 
            CHARINDEX('@', email) + 1, 
            CHARINDEX('.com', email) - CHARINDEX('@', email) - 1
        )
    ) = 0;
