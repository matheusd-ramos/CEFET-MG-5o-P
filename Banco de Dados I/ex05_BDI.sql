-- ==================================================== --
-- Script: junções e aninhamentos em SQL
-- ==================================================== --

select * from EMPLOYEES;
select * from JOB_HISTORY;
select * from DEPARTMENTS;
select * from jobs;

-- Questão 01
select (E.First_Name || ' ' || E.Last_Name) as "Nome Completo", D.DEPARTMENT_ID
from EMPLOYEES E left join DEPARTMENTS D
on E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- Questão 02
select (E.First_Name || ' ' || E.Last_Name) as "Nome Completo", D.DEPARTMENT_ID
from DEPARTMENTS D right join  EMPLOYEES E
on E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- Questão 03
select D.Department_Name, E.First_Name
from DEPARTMENTS D left join EMPLOYEES E
on E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- Questão 04
select E.First_Name, D.Department_Name
from EMPLOYEES E full join DEPARTMENTS D
on D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- Questão 05
select E.First_Name
from EMPLOYEES E
where not exists (
    select J.EMPLOYEE_ID
    from JOB_HISTORY J
    where E.EMPLOYEE_ID = J.EMPLOYEE_ID
);

-- Questão 06
select unique E.First_Name
from EMPLOYEES E
where exists (
    select J.EMPLOYEE_ID
    from JOB_HISTORY J
    where E.EMPLOYEE_ID = J.EMPLOYEE_ID
);

-- Questão 07
select E.FIRST_NAME, J.JOB_ID, J.START_DATE, J.END_DATE
from EMPLOYEES E left join JOB_HISTORY J
on E.EMPLOYEE_ID = J.EMPLOYEE_ID;

-- Questão 08
select E.FIRST_NAME, J.JOB_ID, J.START_DATE, J.END_DATE, JO.JOB_TITLE
from  EMPLOYEES E 
      left join JOB_HISTORY J on E.EMPLOYEE_ID = J.EMPLOYEE_ID
      left join JOBS JO on J.JOB_ID = JO.JOB_ID;