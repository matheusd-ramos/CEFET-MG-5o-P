-- ==================================================== --
-- Script: funções SQL
-- ==================================================== --

-- Questão 01
select First_Name, Last_Name, 
TO_CHAR(Hire_Date, 'DD-Month-YYYY', 'NLS_DATE_LANGUAGE = PORTUGUESE') as Data
from EMPLOYEES
where SUBSTR(Last_Name, 1, 1) = 'R';

-- Questão 02 
select CONCAT(CONCAT(First_Name, ' '), Last_Name) as Nome_Completo,
UPPER(d.Department_Name) as Departamento
from EMPLOYEES e
join DEPARTMENTS d on e.Department_ID = d.Department_ID
where LOWER(e.Department_Name) = 'executive';

-- Questão 03
select (First_Name || ' ' || Last_Name) as Nome_Completo,
TO_CHAR(Hire_Date, 'DD-month-YYYY', 'NLS_DATE_LANGUAGE = PORTUGUESE') as Data_Admissao
from EMPLOYEES
where TO_CHAR(HIRE_DATE, 'YY') = 99;

-- Questão 04
select (First_Name || ' ' || Last_Name) as Nome_Completo,
ROUND(Salary/30) Salario_Diario,
Salary * 12 Salario_Anual
from EMPLOYEES
where Commission_Pct is not null;

-- Questão 05
select (First_Name || ' ' || Last_Name) as Nome_Completo,
Salary Salario_Mensal, 
Salary + NVL(Commission_Pct, 0) * Salary Salario_Comissao
from EMPLOYEES;

-- Questão 06
SELECT
    SUBSTR(e.first_name, 1, 1) || '.' || SUBSTR(e.last_name, 1, 1) || '.' AS iniciais,
    d.department_name as Departamento_NOME
FROM aluno.employees e
JOIN aluno.departments d ON e.employee_id = d.manager_id;

-- Questão 07
select (First_Name || ' ' || Last_Name) as Nome_Completo,
(ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/ 12) || ' anos' || ' e ' ||
MOD(ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)), 12) || ' meses')
as Tempo_Trabalhado
from EMPLOYEES;

-- Questão 08
SELECT
    d.department_name,
    ROUND(AVG(e.salary)) AS media_salarial,
    MAX(e.salary) AS maior_salario,
    MIN(e.salary) AS menor_salario
FROM aluno.employees e
JOIN aluno.departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Quetão 09
SELECT
    d.department_name,
    COUNT(e.employee_id) AS clerks
FROM aluno.employees e
JOIN aluno.departments d ON e.department_id = d.department_id
WHERE LOWER(e.job_id) LIKE '%clerk%'
GROUP BY d.department_name;