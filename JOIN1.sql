create table venda(
	id_nf integer not null,
	id_item integer not null,
	cod_prod integer not null,
	valor_unit numeric(10,2) not null,
	quantidade numeric(10) not null,
	desconto integer
);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (1, 1, 1, 25.00, 10, 5);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (1, 2, 2, 13.50, 3, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (1, 3, 3, 15.00, 2, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (1, 4, 4, 10.00, 1, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (1, 5, 5, 30.00, 1, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (2, 1, 3, 15.00, 4, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (2, 2, 4, 10.00, 5, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (2, 3, 5, 30.00, 7, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (3, 1, 1, 25.00, 5, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (3, 2, 4, 10.00, 4, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (3, 3, 5, 30.00, 5, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (3, 4, 2, 13.50, 7, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (4, 1, 5, 30.00, 10, 15);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (4, 2, 4, 10.00, 12, 5);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (4, 3, 1, 25.00, 13, 5);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (4, 4, 2, 13.50, 15, 5);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (5, 1, 3, 15.00, 3, null);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (5, 2, 5, 30.00, 6, null);


insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (6, 1, 1, 25.00, 22, 15);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (6, 2, 3, 15.00, 25, 20);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (7, 1, 1, 25.00, 10, 3);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (7, 2, 2, 13.50, 10, 4);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (7, 3, 3, 15.00, 10, 4);

insert into venda(id_nf, id_item, cod_prod, valor_unit, quantidade, desconto)
values           (7, 4, 5, 30.00, 10, 1);

SELECT * FROM VENDA

/*a) Pesquise os itens que foram vendidos sem desconto. As colunas presentes no resultado
da consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT.*/

CREATE OR REPLACE FUNCTION EXA1() RETURNS SETOF VENDA AS 
$$
BEGIN 
	RETURN QUERY SELECT * FROM VENDA WHERE DESCONTO IS NULL;
END;
$$LANGUAGE plpgsql;
SELECT * FROM EXA1()

/*b) Pesquise os itens que foram vendidos com desconto. As colunas presentes no resultado
da consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR
VENDIDO. OBS: O valor vendido é igual ao VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)).*/

CREATE OR REPLACE FUNCTION EXA2() RETURNS SETOF VENDA AS 
$$
BEGIN 
	RETURN QUERY SELECT * FROM VENDA WHERE DESCONTO > 0;
END;
$$LANGUAGE plpgsql;
SELECT * FROM EXA2()


--c) Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo.

CREATE OR REPLACE FUNCTION EXC() RETURNS VARCHAR AS 
$$
UPDATE VENDA
SET DESCONTO = 0
WHERE DESCONTO IS NULL;
SELECT 'DADOS ATUALIZADOS' ;
$$LANGUAGE SQL;

SELECT exc();
SELECT * FROM VENDA;

/*d) Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta
são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO,
VALOR_VENDIDO. OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE *
VALOR_UNIT. O VALOR_VENDIDO é igual a VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)).*/

CREATE FUNCTION EXD() RETURNS SETOF VENDA AS 
$$
DECLARE
	
	BEGIN
	  RETURN QUERY SELECT (QUANTIDADE * VALOR_UNIT) FROM VENDA;
		
	END;
$$ LANGUAGE plpgsql;

DROP FUNCTION EXD();
SELECT * FROM EXD();


/*e) Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. OBS: O
VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF.*/

/*f) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_VENDIDO. OBS: O
VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. O
VALOR_VENDIDO é igual a ∑ VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)). Agrupe o
resultado da consulta por ID_NF.*/
CREATE OR REPLACE FUNCTION EXAF() RETURNS SETOF VENDA AS 
$$
BEGIN 
	 SELECT * FROM VENDA WHERE VALOR_UNIT * (DESCONTO/100);
END;
$$LANGUAGE plpgsql;
SELECT * FROM EXAF();
SELECT * FROM VENDA

/*g) Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da
consulta são: COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por
COD_PROD.*/
CREATE OR REPLACE VIEW EXG AS
SELECT COD_PROD,QUANTIDADE FROM
VENDA
ORDER BY QUANTIDADE ASC;

SELECT * FROM EXG;

/*h) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto. As
colunas presentes no resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE.
Agrupe o resultado da consulta por ID_NF, COD_PROD.*/

/*i) Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o resultado
do maior valor para o menor. As colunas presentes no resultado da consulta são: ID_NF,
VALOR_TOT. OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE *
VALOR_UNIT. Agrupe o resultado da consulta por ID_NF.*/

/*j) Qual o valor médio dos descontos dados por produto. As colunas presentes no resultado
da consulta são: COD_PROD, MEDIA. Agrupe o resultado da consulta por COD_PROD.*/

/*k) Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas
presentes no resultado da consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe o
resultado da consulta por COD_PROD.*/

/*l) Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado
da consulta são: ID_NF, QTD_ITENS. OBS:: NÃO ESTÁ RELACIONADO A QUANTIDADE
VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA FISCAL. Agrupe o
resultado da consulta por ID_NF*/