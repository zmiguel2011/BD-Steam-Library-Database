.mode columns
.headers on
.nullvalue NULL

SELECT Desenvolvedor.nome, SUM(PrecoUnitario) AS "Receita Total" 
FROM Desenvolvedor,JOGO 
WHERE Jogo.IdDesenvolvedor = Desenvolvedor.IdDesenvolvedor 
GROUP BY Desenvolvedor.nome 
ORDER BY "Receita Total" DESC limit 5;