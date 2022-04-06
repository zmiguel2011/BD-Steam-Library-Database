.mode columns
.headers on
.nullvalue NULL

SELECT Valor, DataTransacao, Date() as "Hoje" , MAX (JULIANDAY(DATE()) - JULIANDAY(DataTransacao)) AS "Diferença de Dias" FROM Transacao;