-- ============================================================
-- Script: Criacao base de tabelas do bd de empresa
-- Objetivo: criar DEPARTAMENTO e FUNCIONARIO (estrutura inicial)
-- Uso: execute este script antes de bd_empresa.sql
-- ============================================================

CREATE TABLE DEPARTAMENTO (
    NUMERO NUMBER(5) PRIMARY KEY,
    NOME   VARCHAR2(50) NOT NULL,
    UNIQUE (NOME)
);

CREATE TABLE FUNCIONARIO (
    CPF                 VARCHAR2(11) PRIMARY KEY,
    PRIMEIRO_NOME       VARCHAR2(20) NOT NULL,
    NOME_MEIO           VARCHAR2(1),
    ULTIMO_NOME         VARCHAR2(20) NOT NULL,
    ENDERECO            VARCHAR2(120),
    DATA_NASCIMENTO     DATE NOT NULL,
    SEXO                CHAR(1) CHECK (SEXO IN ('M', 'F')),
    NUMERO_DEPARTAMENTO NUMBER(5) NOT NULL,
    FOREIGN KEY (NUMERO_DEPARTAMENTO) REFERENCES DEPARTAMENTO(NUMERO)
);

-- Conferencia rapida da estrutura
SELECT table_name, column_name, data_type, nullable
FROM user_tab_columns
WHERE table_name IN ('DEPARTAMENTO', 'FUNCIONARIO')
ORDER BY table_name, column_id;