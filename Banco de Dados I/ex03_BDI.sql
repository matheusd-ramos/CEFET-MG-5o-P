-- ============================================================
-- Script: Árvore familiar (auto-relacionamento na mesma tabela)
-- Objetivo: criar a tabela FAMILIA, inserir dados e atualizar datas
-- ============================================================

CREATE TABLE FAMILIA (
    Nome            VARCHAR2(50) NOT NULL PRIMARY KEY,
    Pai             VARCHAR2(50) REFERENCES FAMILIA(Nome),
    Mae             VARCHAR2(50) REFERENCES FAMILIA(Nome),
    Conjuge         VARCHAR2(50) REFERENCES FAMILIA(Nome)
);

-- Cadastro de casais da geração mais antiga -- 
INSERT INTO FAMILIA VALUES ('Regina', NULL, NULL, NULL);
INSERT INTO FAMILIA VALUES ('Ken',    NULL, NULL, NULL);
UPDATE FAMILIA SET Conjuge = 'Regina' WHERE Nome = 'Ken';
UPDATE FAMILIA SET Conjuge = 'Ken'    WHERE Nome = 'Regina';

INSERT INTO FAMILIA VALUES ('Laura', NULL, NULL, NULL);
INSERT INTO FAMILIA VALUES ('John',  NULL, NULL, NULL);
UPDATE FAMILIA SET Conjuge = 'John'  WHERE Nome = 'Laura';
UPDATE FAMILIA SET Conjuge = 'Laura' WHERE Nome = 'John';

-- Filhos e novos casamentos --
INSERT INTO FAMILIA VALUES ('Adam',  'Ken',   'Regina', NULL);
INSERT INTO FAMILIA VALUES ('Tina',  NULL,    NULL,     'Adam');
UPDATE FAMILIA SET Conjuge = 'Tina' WHERE Nome = 'Adam';
INSERT INTO FAMILIA VALUES ('Jonas', 'Adam',  'Tina',   NULL);

INSERT INTO FAMILIA VALUES ('Eva',   'Ken',   'Regina', NULL);
INSERT INTO FAMILIA VALUES ('Tomas', 'John',  'Laura',  'Eva');
UPDATE FAMILIA SET Conjuge = 'Tomas' WHERE Nome = 'Eva';

INSERT INTO FAMILIA VALUES ('Charlie', 'Tomas', 'Eva',  NULL);
INSERT INTO FAMILIA VALUES ('Addison', 'Tomas', 'Eva',  NULL);
INSERT INTO FAMILIA VALUES ('Dexie',   'Tomas', 'Eva',  NULL);
INSERT INTO FAMILIA VALUES ('Caty',    'John',  'Laura', NULL);
INSERT INTO FAMILIA VALUES ('Sean',    NULL,    NULL,    'Caty');
UPDATE FAMILIA SET Conjuge = 'Sean' WHERE Nome = 'Caty';
INSERT INTO FAMILIA VALUES ('George',  'Sean',  'Caty',  NULL);

-- Estrutura temporal (nascimento e casamento) -- 
ALTER TABLE FAMILIA ADD (
    Data_Nascimento DATE DEFAULT DATE '1950-04-07' NOT NULL,
    Data_Casamento  DATE
);

-- Atualização das datas conhecidas --
UPDATE FAMILIA
SET Data_Nascimento = DATE '1950-03-19',
    Data_Casamento  = DATE '1968-06-12'
WHERE Nome = 'Regina';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1947-07-21',
    Data_Casamento  = DATE '1968-06-12'
WHERE Nome = 'Ken';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1948-12-05',
    Data_Casamento  = DATE '1958-01-01'
WHERE Nome = 'Laura';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1950-05-07',
    Data_Casamento  = DATE '1958-01-01'
WHERE Nome = 'John';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1963-09-27',
    Data_Casamento  = DATE '1981-09-11'
WHERE Nome = 'Adam';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1964-07-17',
    Data_Casamento  = DATE '1981-09-11'
WHERE Nome = 'Tina';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1965-11-15',
    Data_Casamento  = DATE '1983-09-07'
WHERE Nome = 'Eva';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1964-11-14',
    Data_Casamento  = DATE '1983-09-07'
WHERE Nome = 'Tomas';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1970-02-28',
    Data_Casamento  = DATE '1989-12-25'
WHERE Nome = 'Caty';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1969-03-31',
    Data_Casamento  = DATE '1989-12-25'
WHERE Nome = 'Sean';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1982-04-16'
WHERE Nome = 'Jonas';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1990-11-11'
WHERE Nome = 'Charlie';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1995-10-10'
WHERE Nome = 'Addison';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1999-02-02'
WHERE Nome = 'Dexie';

UPDATE FAMILIA
SET Data_Nascimento = DATE '1989-08-08'
WHERE Nome = 'George';

-- Conferência final --
SELECT *
FROM FAMILIA
ORDER BY Nome;