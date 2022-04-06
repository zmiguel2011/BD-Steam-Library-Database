.mode columns
.headers on
.nullvalue NULL

SELECT titulo, classificacao 
FROM Jogo, CategoriaJogo, Categoria 
WHERE Jogo.idJogo = CategoriaJogo.idJogo 
AND CategoriaJogo.idCategoria = Categoria.idCategoria 
AND nome ='Action' 
AND PEGI=16 
AND classificacao>85 
ORDER BY classificacao DESC;