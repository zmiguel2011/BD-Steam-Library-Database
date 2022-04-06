PRAGMA foreign_keys	= ON;
.mode columns
.headers on
.nullvalue NULL


INSERT INTO Jogo VALUES (21, 'Grand Theft Auto - VI', 0, 79,'2025-11-09',18, 5);

SELECT titulo, nome FROM Jogo, Categoria, CategoriaJogo 
WHERE CategoriaJogo.idJogo = Jogo.idJogo
AND CategoriaJogo.idCategoria = Categoria.idCategoria
AND CategoriaJogo.idCategoria = 12;

.print ''
.print 'Podemos confirmar que a categoria do jogo foi atualizada para Pre Order.'
.print ''