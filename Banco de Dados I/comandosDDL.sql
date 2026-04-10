-- ==================================================== --
-- Script: criação de banco de dados de jogo de futebol
-- ==================================================== --

-- 1) Criação de tabelas --
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

-- 2) Inserção de dados --

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

-- 3) Adicionando chaves primárias --

ALTER TABLE TIME ADD CONSTRAINT PRIMARY KEY (ID_Time);
