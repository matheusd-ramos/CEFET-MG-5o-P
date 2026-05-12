-- ============================================================== --
-- Script: processamento de transações e controle de concorrência --
-- Data: 08/05/2026                                               --
-- ============================================================== --

-- Questão 01
-- Usuário1: ECLBDIT103
-- Usuário2: ECLBDIT113

-- Questão 02
create table membro (
   mat       number(12) primary key,
   nome      varchar2(40) not null,
   cpf       varchar2(11) not null,
   ende      varchar2(40) not null,
   data_nasc date not null
);

-- Questão 03
insert into membro values ( 111,
                            'Antonio',
                            '11111111',
                            'Rua A',
                            to_date('01/12/2001','DD/MM/YYYY') );

-- Questão 04
select *
  from eclbdit103.membro;

-- Questão 05
grant select on membro to eclbdit103;

-- Questão 06
insert into eclbdit103.membro values ( 222,
                                       'Carlos',
                                       '22222222',
                                       'Rua B',
                                       to_date('02/12/2001','DD/MM/YYYY') );
commit;

-- Questão 07
insert into membro values ( 333,
                            'Corlaite',
                            '33333333',
                            'Rua C',
                            to_date('03/12/2001','DD/MM/YYYY') );

insert into membro values ( 444,
                            'Cantor',
                            '44444444',
                            'Rua D',
                            to_date('04/12/2001','DD/MM/YYYY') );  

-- Questão 08
commit;

-- Questão 09
insert into membro values ( 555,
                            'Eddie',
                            '55555555',
                            'Rua E',
                            to_date('05/12/2001','DD/MM/YYYY') );

insert into membro values ( 666,
                            'Vedder',
                            '66666666',
                            'Rua F',
                            to_date('06/12/2001','DD/MM/YYYY') );

select *
  from eclbdit103.membro;

-- Questão 10)
rollback;

-- Questão 11)
update eclbdit103.membro set nome='Manel' where mat=444;

-- Questão 12)
grant update on membro to eclbdit103;

-- Questão 13)
update eclbdit103.membro set nome='Manel' where mat=444;
select * from eclbdit103.membro;

-- Questão 14)
commit;
select * from eclbdit103.membro;

-- Questão 15)
update eclbdit103.membro set nome='Tõe' where mat=111;

-- Questão 16)
commit;

-- Questão 17)
update eclbdit103.membro set nome='Tunico' where mat=111;
update membro set nome='Tinoco' where mat=111;

-- Questão 18)
revoke update, insert, select on membro from eclbdit103;