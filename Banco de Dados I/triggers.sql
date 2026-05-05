-- ==================================================== --
-- Script: criação e testes de triggers
-- ==================================================== --

--------------------------------- Questão 1 -----------------------------------

-- Criando tabela para a questão
CREATE TABLE AUDITORIA (
    DATA DATE PRIMARY KEY,
    CPF VARCHAR2(11),
    SALARIO_ANTERIOR NUMBER(10,0),
    SALARIO_ATUAL NUMBER(10,0),
    USUARIO VARCHAR2(40)
);   

-- Criando o trigger
CREATE OR REPLACE TRIGGER registrar_alteracao_salario
AFTER UPDATE OF Salario ON FUNCIONARIO
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA VALUES(SYSDATE, :OLD.CPF, :OLD.Salario, :NEW.Salario, USER);
END;

-- Testando Trigger de auditoria
UPDATE FUNCIONARIO SET Salario=20000 WHERE CPF=33344555587;
UPDATE FUNCIONARIO SET Salario=50000 WHERE CPF=88866555576;
UPDATE FUNCIONARIO SET Salario=0 WHERE CPF=88866555576;

--------------------------------- Questão 2 -----------------------------------

-- Criação do trigger
CREATE OR REPLACE TRIGGER salario_invalido
BEFORE UPDATE OF Salario ON FUNCIONARIO
FOR EACH ROW
BEGIN
    IF :NEW.Salario < 20000 THEN
        :NEW.Salario := 20000;
    ELSIF :NEW.Salario > 50000 THEN 
        :NEW.Salario := 50000;
    END IF;
END;

-- Testando Trigger de salário inválido
UPDATE FUNCIONARIO SET Salario=50001 WHERE CPF=88866555576;
UPDATE FUNCIONARIO SET Salario=19999 WHERE CPF=33344555587;
UPDATE FUNCIONARIO SET Salario=20001 WHERE CPF=98765432168;

--------------------------------- Questão 3 -----------------------------------

-- Adicionando a coluna para quantidade de funcionários na tabela de departamentos
ALTER TABLE DEPARTAMENTO ADD (QTDE_FUNCIONARIOS NUMBER(5) DEFAULT 0);

-- Preenchendo a coluna com a quantidade correta de funcionários por departamento
UPDATE DEPARTAMENTO d
SET QTDE_FUNCIONARIOS = (
    SELECT COUNT(CPF) 
    FROM FUNCIONARIO 
    WHERE NUMERO_DEPARTAMENTO = d.NUMERO
);

-- Criando o trigger para manter a quantidade de funcionários inalterada
CREATE OR REPLACE TRIGGER max_de_func_atingido
BEFORE INSERT ON FUNCIONARIO
FOR EACH ROW
BEGIN
    Raise_Application_Error(-20001, 'O número máximo de funcionários no departamento foi atingido');
END;

-- Tentando inserir outro funcioário
INSERT INTO FUNCIONARIO VALUES (
    '66688444472', 'Ronaldo', 'K', 'Lima',
    'Rua Reboucas, 65, Piracicaba, SP', DATE '1962-09-15',
    'M', 5, '33344555587', 38000
);