PRAGMA foreign_keys	= ON;
.mode columns
.headers on
.nullvalue NULL

INSERT INTO Carrinho
SELECT '21', IdJogo, 2
FROM Jogo
Where IdJogo Not In (Select IdJogo From Carrinho);

INSERT INTO Transacao
SELECT IdCarrinho, Carrinho.IdJogo, 1, JulianDay(date()), 3232323232, 1
FROM Carrinho
Where IdCarrinho = 21;

.print ''
.print 'Podemos confirmar que é impossivel introduzir um tuplo em transacoes cujo valor seja imcopativel com a quantidade que consta no carrinho multiplicada pelo preco unitario do jogo.'
.print ''