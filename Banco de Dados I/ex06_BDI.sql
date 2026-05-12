-- ==================================================== --
-- Script: sentenças de agrupamento e funções de grupo
-- ==================================================== --

-- Questão 01
select C.NAME Nome, SUM(O.TOTAL) Total_Pedidos, COUNT(*)
from ALUNO.CUSTOMER C join ALUNO.ORD O on C.CUSTID = O.CUSTID
group by C.NAME;

-- Questão 02
select P.DESCRIP Descrição, SUM(I.QTY) Quantidade
from ALUNO.PRODUCT P join ALUNO.ITEM I on P.PRODID = I.PRODID
group by P.DESCRIP;

-- Questão 03
select E.ENAME "Nome do Funcionário", SUM(O.TOTAL) "Total em vendas"
from (ALUNO.CUSTOMER C join ALUNO.ORD O on C.CUSTID=O.CUSTID) right join 
     ALUNO.EMP E on E.EMPNO=C.REPID
group by E.ENAME;

-- Questão 04
select C.CITY Cidade, SUM(O.TOTAL) Total, ROUND (AVG(O.TOTAL), 2) Média
from ALUNO.CUSTOMER C join ALUNO.ORD O on C.CUSTID=O.CUSTID
group by C.CITY;

-- Questão 05
select C.CITY Cidade, SUM(O.TOTAL) Total, ROUND (AVG(O.TOTAL), 2) Média
from ALUNO.CUSTOMER C join ALUNO.ORD O on C.CUSTID=O.CUSTID
group by C.CITY
having C.CITY IN ('PALO ALTO', 'SANTA CLARA');

-- Questão 06
select max(Soma)
from (select sum(I.QTY) Soma
      from ALUNO.ITEM I
      group by I.PRODID);

-- Questão 07
select I.PRODID, sum(I.QTY)
from ALUNO.ITEM I
group by I.PRODID
having sum(I.QTY) = (select max(Soma)
                     from (select sum(I.QTY) Soma
                     from ALUNO.ITEM I
                     group by I.PRODID));

-- Questão 08
select G.ENAME, sum(O.TOTAL)
from ALUNO.EMP E join ALUNO.EMP G on E.MGR=G.EMPNO join
     ALUNO.CUSTOMER C on E.EMPNO=C.REPID join 
     ALUNO.ORD O on C.CUSTID=O.CUSTID
group by G.ENAME;