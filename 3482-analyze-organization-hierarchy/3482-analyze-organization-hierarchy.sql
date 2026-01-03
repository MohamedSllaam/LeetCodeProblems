/* Write your T-SQL query statement below */
WITH EmployeeLevel AS (
    SELECT
        employee_id,
        employee_name,
        1 AS Level
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        h.Level + 1
    FROM Employees e
    JOIN EmployeeLevel h
        ON e.manager_id = h.employee_id
),
EmployeeTeamSize AS (
    -- Anchor
    SELECT
        e.employee_id,
         
        m.employee_id AS manager_employee_id
    FROM Employees e
    JOIN Employees m
        ON m.employee_id = e.manager_id

    UNION ALL

    -- Recursive
    SELECT
        e.employee_id,
        
        h.manager_employee_id
    FROM Employees e
    JOIN EmployeeTeamSize h
        ON e.manager_id = h.employee_id
),
EmployeeTeamSizeAgg AS (
    SELECT
        manager_employee_id,
        COUNT(manager_employee_id) AS team_size
    FROM EmployeeTeamSize
    GROUP BY manager_employee_id
),
EmployeeBudget AS (
    -- Anchor
    SELECT
        e.employee_id, 
        e.salary,
        e.employee_id AS manager_employee_id
    FROM Employees e
    
    UNION ALL

    -- Recursive
    SELECT
        e.employee_id, 
        e.salary,
        h.manager_employee_id
    FROM Employees e
    JOIN EmployeeBudget h
        ON e.manager_id = h.employee_id
),
EmployeeBudgetAgg AS (
    SELECT
        manager_employee_id,
        SUM(salary) AS budget
    FROM EmployeeBudget
    GROUP BY manager_employee_id
)
SELECT
    l.employee_id,
    l.employee_name,
    l.Level,
    ISNULL(t.team_size, 0) AS team_size,
    ISNULL(b.budget, 0) AS budget
FROM EmployeeLevel l
LEFT JOIN EmployeeTeamSizeAgg t
    ON l.employee_id = t.manager_employee_id
LEFT JOIN EmployeeBudgetAgg b
    ON l.employee_id = b.manager_employee_id
 

ORDER BY l.Level, budget desc , l.employee_name;

