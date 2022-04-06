.mode columns
.headers on
.nullvalue NULL

SELECT nickname 
FROM Utilizador, Biblioteca 
WHERE Utilizador.idUtilizador = Biblioteca.idUtilizador AND HorasJogadas2semanas=0 
GROUP BY 1;