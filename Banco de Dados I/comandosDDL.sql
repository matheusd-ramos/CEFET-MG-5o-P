-- ==================================================== --
-- Script: criação de banco de dados de jogo de futebol
-- ==================================================== --

-- 1) Criação de tabelas
CREATE TABLE TIME (
    ID_Time NUMBER(3),
    Nome_Time VARCHAR2(30)
);

CREATE TABLE JOGO (
    Data DATE,
    Placar_Casa NUMBER(2),
    Placar_Visitante NUMBER(2)
);

CREATE TABLE JOGADOR (
    CPF NUMBER(11),
    Nome_Jogador VARCHAR2(30)
);

-- 2) Inserção de dados

-- Inserção de times
INSERT INTO TIME VALUES (123, 'Cruzeiro');
INSERT INTO TIME VALUES (456, 'Atlético');
INSERT INTO TIME VALUES (789, 'América');

-- Inserção de jogos
INSERT INTO JOGO VALUES ('01/01/2026', 2, 1);
INSERT INTO JOGO VALUES ('02/02/2026', 1, 1);
INSERT INTO JOGO VALUES ('03/03/2026', 0, 1);

-- Inserção de jogadores
INSERT INTO JOGADOR VALUES (12345678910, 'Garibaldo');
INSERT INTO JOGADOR VALUES (09876543211, 'Beto');
INSERT INTO JOGADOR VALUES (11111111111, 'Elmo');

-- 3) Adicionando chaves primárias

ALTER TABLE TIME ADD CONSTRAINT ID_Time PRIMARY KEY (ID_Time);
ALTER TABLE JOGADOR ADD CONSTRAINT CPF PRIMARY KEY (CPF);

-- 4) Adicionando chaves estrangeiras e integridades referenciais

ALTER TABLE JOGO ADD ID_Casa NUMBER(3) REFERENCES TIME(ID_Time) ON DELETE CASCADE;
ALTER TABLE JOGO ADD ID_Visitante NUMBER(3) REFERENCES TIME(ID_Time) ON DELETE CASCADE;
ALTER TABLE JOGADOR ADD ID_Time NUMBER(3) REFERENCES TIME(ID_Time); -- Já bloqueia de natureza

-- 5) Preenchendo as chaves estrangeiras com chaves primárias

UPDATE JOGO SET ID_Casa = 123 WHERE Data = '01/01/26';
UPDATE JOGO SET ID_Visitante = 456 WHERE Data = '01/01/26';

UPDATE JOGO SET ID_Casa = 789 WHERE Data = '02/02/26';
UPDATE JOGO SET ID_Visitante = 123 WHERE Data = '02/02/26';

UPDATE JOGO SET ID_Casa = 456 WHERE Data = '03/03/26';
UPDATE JOGO SET ID_Visitante = 789 WHERE Data = '03/03/26';

UPDATE JOGADOR SET ID_Time = 123 WHERE CPF = 12345678910;
UPDATE JOGADOR SET ID_Time = 456 WHERE CPF = 9876543211;
UPDATE JOGADOR SET ID_Time = 789 WHERE CPF = 11111111111;

-- 6) Criando a chave primária de Jogo

ALTER TABLE JOGO ADD CONSTRAINT pk_JOGO PRIMARY KEY (Data, ID_Casa, ID_Visitante);

-- 7) Alterando a coluna ID_Time de Jogador
 
ALTER TABLE JOGADOR MODIFY ID_Time NOT NULL;

-- 8) Adicionando chave única no nome do Jogador

ALTER TABLE JOGADOR ADD CONSTRAINT uk_Nome UNIQUE (Nome_Jogador);

-- 9) Conferindo as restrições com consultas

INSERT INTO JOGADOR VALUES (12345678910, 'Jorge', 123);     -- Mesmo CPF
INSERT INTO TIME VALUES (123, 'Santos');                    -- Mesmo ID_Time
DROP TABLE TIME;                                            -- Tentando apagar a tabela time (com bloqueio)
INSERT INTO JOGO VALUES ('01/01/26', 0, 0, 123, 456);       -- Tentendo adicionar o mesmo jogo
INSERT INTO JOGADOR VALUES (0, 'Marcelo');                  -- Tentando adicionar jogador sem time
INSERT INTO JOGADOR VALUES (0, 'Garibaldo', 456);           -- Tentando acicionar jogador com mesmo nome