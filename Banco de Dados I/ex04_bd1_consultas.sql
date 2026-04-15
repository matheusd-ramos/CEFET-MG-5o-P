-- ============================================================ --
-- Script: comandos de consulta banco de dados empresa
-- Objetivo: testar comandos de consulta
-- ============================================================ -- 

-- Questão 1)
SELECT Primeiro_Nome, Ultimo_Nome, Salario
FROM ALUNO.FUNCIONARIO
WHERE Numero_Departamento = 4 OR Numero_Departamento = 5;

-- Questão 2)
SELECT Primeiro_Nome, Ultimo_Nome, Salario
FROM ALUNO.FUNCIONARIO
WHERE Numero_Departamento = 4 OR Numero_Departamento = 5
ORDER BY Salario; -- Por padrão é crescente

-- Questão 3)
SELECT Primeiro_Nome, Ultimo_Nome, Salario, Numero_Departamento
FROM ALUNO.FUNCIONARIO
WHERE Numero_Departamento = 4 OR Numero_Departamento = 5
ORDER BY Numero_Departamento ASC, Salario ASC;

-- Questão 4)
SELECT Primeiro_Nome, Ultimo_Nome, Salario
FROM ALUNO.FUNCIONARIO
WHERE Numero_Departamento = 4
UNION
SELECT Primeiro_Nome, Ultimo_Nome, Salario
FROM ALUNO.FUNCIONARIO
WHERE Numero_Departamento = 5;

-- Questão 5)
SELECT Primeiro_Nome, Ultimo_Nome, Salario, ALUNO.FUNCIONARIO.Numero_Departamento
FROM ALUNO.FUNCIONARIO CROSS JOIN ALUNO.DEPARTAMENTO
WHERE ALUNO.FUNCIONARIO.Numero_Departamento = ALUNO.DEPARTAMENTO.Numero_Departamento;   

-- Questão 6)
SELECT Primeiro_Nome, Ultimo_Nome, Salario, ALUNO.FUNCIONARIO.Numero_Departamento
FROM ALUNO.FUNCIONARIO INNER JOIN ALUNO.DEPARTAMENTO
ON ALUNO.FUNCIONARIO.Numero_Departamento = ALUNO.DEPARTAMENTO.Numero_Departamento; 
-- JOIN obgriga a cláusula ON no lugar de WHERE

-- Questão 7)
SELECT DISTINCT CPF_Supervisor 
FROM ALUNO.FUNCIONARIO
WHERE CPF_Supervisor is not null;