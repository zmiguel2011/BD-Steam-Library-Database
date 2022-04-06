.mode columns
.headers on
.nullvalue NULL

SELECT idUtilizador, username, nickname 
FROM Utilizador U1 
WHERE U1.nickname IN
(SELECT nickname 
FROM Utilizador U2 
GROUP BY U2.nickname 
HAVING COUNT(*)>1);