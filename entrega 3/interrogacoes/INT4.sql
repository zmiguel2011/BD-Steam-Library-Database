.mode columns
.headers on
.nullvalue NULL

SELECT MesTransacao, MAX(NumeroTransacoes) AS "NumeroTransacoes" 
FROM 
(SELECT COUNT(idCarrinho) AS "NumeroTransacoes", DataTransacao, strftime('%m', DataTransacao) AS MesTransacao 
FROM Transacao 
WHERE DataTransacao LIKE "%2021%");