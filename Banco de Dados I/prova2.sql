-- ==================================================== --
-- Consultas aninhadas: correlacionadas e não correlacionadas
-- ==================================================== --

-- Desafio 1
select E.first_name, E.last_name
from EMPLOYEES E
where E.department_id in (select D.department_id
                          from departments D
                          where D.DEPARTMENT_NAME='IT');

-- Desafio 2
select E.FIRST_NAME, E.LAST_NAME
from EMPLOYEES E
where E.SALARY > (select avg(SALARY)
                  from EMPLOYEES);

-- Desafio 3
select E1.FIRST_NAME, E1.LAST_NAME, E1.DEPARTMENT_ID
from EMPLOYEES E1
where E1.SALARY > (select avg(salary) 
                   from EMPLOYEES E2
                   where E1.DEPARTMENT_ID=E2.DEPARTMENT_ID);

-- Desafio 4
select D.DEPARTMENT_NAME
from departments D
where not exists (select 1
                  from EMPLOYEES E
                  where d.department_id = e.department_id);

-- Desafio 5
select D.DEPARTMENT_NAME, qtde_dep.qtde_fun
from departments D join
        (select department_id, count(E.first_name) as qtde_fun
        from EMPLOYEES E
        group by department_id) qtde_dep
on D.DEPARTMENT_ID = qtde_dep.DEPARTMENT_ID
where qtde_dep.qtde_fun is null;


-- ==================================================== --
-- Triggers de linha, de instrução e erro da tabela mutante
-- ==================================================== --

-- trigger de linha (for each row)
create trigger trg_protege_chefia
before delete on departments
for each row
BEGIN
        if :OLD.department_id = 10 then
                raise_application_error(-20001, 'O departamento da chefia não pode ser excluído!');
        end if;
end;

-- trigger de instrução (aplica apenas uma vez)
CREATE OR REPLACE TRIGGER trg_horario_comercial
BEFORE INSERT OR UPDATE OR DELETE ON employees
BEGIN
    -- Verifica se o dia atual é Sábado (SAT) ou Domingo (SUN)
    IF TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') IN ('SAT', 'SUN') THEN
        
        -- Bloqueia a transação inteira antes mesmo de olhar para os dados
        RAISE_APPLICATION_ERROR(-20005, 'Alterações na tabela só são permitidas em dias úteis!');
        
    END IF;
END;

-- posso rodar inserts também (para auditoria)
CREATE OR REPLACE TRIGGER trg_audita_departamentos
AFTER UPDATE ON departments
BEGIN
    -- Insere apenas UMA linha na tabela de log, não importa se o 
    -- UPDATE afetou 1 departamento ou 50 departamentos de uma vez.
    INSERT INTO log_auditoria (usuario, data_hora, acao)
    VALUES (USER, SYSDATE, 'Alguém atualizou a tabela de departamentos');
END;

-- erro da tabela mutante (nao usar)
CREATE TRIGGER trg_limite_salario
BEFORE UPDATE ON employees
FOR EACH ROW -- É um trigger de linha
DECLARE
    v_media NUMBER;
BEGIN
    -- O ERRO ACONTECE AQUI! 
    -- Você está fazendo um SELECT na tabela 'employees' enquanto a 
    -- própria tabela 'employees' está recebendo o UPDATE. Tabela Mutante!
    SELECT AVG(salary) INTO v_media FROM employees; 

    IF :NEW.salary > v_media THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salário acima da média!');
    END IF;
END;

-- funciona de boa
CREATE TRIGGER trg_valida_orcamento
BEFORE UPDATE ON employees
FOR EACH ROW -- É um trigger de linha
DECLARE
    v_orcamento_max NUMBER;
BEGIN
    -- ISSO FUNCIONA PERFEITAMENTE!
    -- O Trigger está na tabela 'employees', mas o SELECT está indo ler
    -- a tabela 'departments'. Como a 'departments' não está sofrendo 
    -- nenhuma alteração no momento, o banco permite a leitura tranquilamente.
    SELECT max_budget INTO v_orcamento_max 
    FROM departments 
    WHERE department_id = :NEW.department_id;

    IF :NEW.salary > v_orcamento_max THEN
        RAISE_APPLICATION_ERROR(-20002, 'Estourou o orçamento do departamento!');
    END IF;
END;

-- ==================================================== --
-- Cláusula having
-- ==================================================== --

SELECT regiao, SUM(valor_venda) AS faturamento_total
FROM vendas
WHERE ano_venda = 2023        -- 1º: Joga fora as vendas de 2022 e 2024 (linha a linha)
GROUP BY regiao               -- 2º: Cria os "montinhos" separados por região
HAVING SUM(valor_venda) > 50000; -- 3º: Joga fora a região inteira se o montinho não deu 50k

-- Usar funções de agregação (avg, sum, min, max, count) dentro do having

-- ==================================================== --
-- Views: uma consulta salva em uma tabela
-- ==================================================== --

CREATE VIEW vw_funcionarios_ti AS
SELECT first_name, last_name, salary
FROM employees
WHERE department_id = 10;

-- posso fazer inserts, deletes e updates em views (afeta a tabela original)
-- desde que ela não seja proveniente de um join, group by, having distinct 
-- ou funções de agregação (banco não vai saber onde inserir dados)

-- view não deixa o banco "mais rápido", porque sempre repete o select, apenas
-- as materialized views (novas tabelas) podem fazer isso