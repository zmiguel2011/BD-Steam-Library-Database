.mode columns
.headers on
.nullvalue NULL

DROP View IF EXISTS UsoMetodoPagamento; 

CREATE View UsoMetodoPagamento AS Select NomeMetodo, Count(*) AS Utilizacoes 
FROM Transacao, MetodoPagamento 
WHERE Transacao.idMetodoPagamento = MetodoPagamento.idMetodoPagamento GROUP BY NomeMetodo;

SELECT U1.NomeMetodo, U1.Utilizacoes 
FROM UsoMetodoPagamento U1 
WHERE NOT EXISTS 
(SELECT * FROM UsoMetodoPagamento U2 WHERE U2.Utilizacoes<U1.Utilizacoes); 