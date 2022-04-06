.mode columns
.headers on
.nullvalue NULL

SELECT Categoria, titulo, MAX(Horas) AS HorasTotais 
FROM (SELECT Categoria.nome AS Categoria, Jogo.Titulo,SUM(Biblioteca.HorasJogadas) AS Horas 
FROM Jogo,Categoria,CategoriaJogo,Biblioteca 
WHERE Jogo.IdJogo = CategoriaJogo.IdJogo 
AND CategoriaJogo.IdCategoria = Categoria.IdCategoria 
AND Biblioteca.IdJogo = Jogo.IdJogo 
GROUP BY Titulo,Categoria.nome) 
GROUP BY Categoria;