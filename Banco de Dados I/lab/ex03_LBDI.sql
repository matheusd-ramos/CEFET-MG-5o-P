-- Questão 1
select First_Name, Last_Name, 
TO_CHAR(Hire_Date, 'DD-Month-YYYY', 'NLS_DATE_LANGUAGE = PORTUGUESE') as Data
from EMPLOYEES
where SUBSTR(Last_Name, 1, 1) = 'R';

-- Questão 2 (Parece que estamos com problema de permissão)
select CONCAT(CONCAT(First_Name, ' '), Last_Name) as Nome_Completo,
UPPER(d.Department_Name) as Departamento
from EMPLOYEES e
join DEPARTMENTS d on e.Department_ID = d.Department_ID
where LOWER(e.Department_Name) = 'executive';