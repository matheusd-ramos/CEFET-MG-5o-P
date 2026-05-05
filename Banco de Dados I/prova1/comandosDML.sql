-- =============================================== --
-- Script: Prova 1
-- Alunos: Matheus Ramos e Gabriel Moura
-- =============================================== --

-- Inserção dos produtos
INSERT INTO PRODUTO VALUES (
    'PRD001',
    'Chuteira Profissional'
);

INSERT INTO PRODUTO VALUES (
    'PRD002',
    'Bola Oficial'
);

INSERT INTO PRODUTO VALUES (
    'PRD003',
    'Camiseta Esportiva'
);

INSERT INTO PRODUTO VALUES (
    'PRD004',
    'Meião Esportivo'
);

-- Inserção dos pedidos
INSERT INTO PEDIDO VALUES (
    'P1001',
    TO_DATE('2026-03-10', 'YYYY-MM-DD')
);

INSERT INTO PEDIDO VALUES (
    'P1002',
    TO_DATE('2026-03-18', 'YYYY-MM-DD')
);

-- Inserção dos Itens
INSERT INTO ITEM VALUES (
    1,
    1,
    300.00,
    'PRD001',
    'P1001'
);

INSERT INTO ITEM VALUES (
    2,
    1,
    150.00,
    'PRD002',
    'P1001'
);

INSERT INTO ITEM VALUES (
    1,
    2,
    200.00,
    'PRD003',
    'P1002'
);

INSERT INTO ITEM VALUES (
    2,
    1,
    300.00,
    'PRD001',
    'P1002'
);

INSERT INTO ITEM VALUES (
    3,
    1,
    20.00,
    'PRD004',
    'P1002'
);

-- Consulta das tabelas
SELECT * FROM PRODUTO;
SELECT * FROM PEDIDO;
SELECT * FROM ITEM;

-- Consulta dos pedidos
SELECT P.Numero_Pedido, I.Numero_Item, PR.Nome_Produto, I.Valor, I.Quantidade
FROM ITEM I 
JOIN PRODUTO PR ON I.Codigo_Produto = PR.Codigo_Produto
JOIN PEDIDO P ON I.Numero_Pedido = P.Numero_Pedido;

COMMIT;