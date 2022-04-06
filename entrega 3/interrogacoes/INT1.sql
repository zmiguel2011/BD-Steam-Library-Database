.mode columns
.headers on
.nullvalue NULL

SELECT Jogo.Titulo, SUM(HorasJogadas) AS "Horas Totais" 
FROM Jogo, Biblioteca 
WHERE Jogo.idJogo = Biblioteca.idJogo 
GROUP BY titulo 
ORDER BY "Horas Totais" DESC LIMIT 1;