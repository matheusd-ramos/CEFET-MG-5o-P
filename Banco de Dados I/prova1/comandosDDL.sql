-- Criação das tabelas
CREATE TABLE PRODUTO (
    Codigo_Produto VARCHAR2(6) PRIMARY KEY,
    Nome_Produto VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE PEDIDO (
    Numero_Pedido VARCHAR2(5) PRIMARY KEY,
    Data DATE DEFAULT SYSDATE
);

CREATE TABLE ITEM (
    Numero_Item NUMBER(2), 
    Quantidade NUMBER(2,0) CHECK (Quantidade > 0),
    Valor NUMBER(5,2) CHECK (Valor > 0),
    Codigo_Produto VARCHAR2(6) REFERENCES PRODUTO(Codigo_Produto) ON DELETE CASCADE NOT NULL,
    Numero_Pedido VARCHAR2(5) REFERENCES PEDIDO(Numero_Pedido) ON DELETE CASCADE,
    PRIMARY KEY (Numero_Item, Numero_Pedido)
);

