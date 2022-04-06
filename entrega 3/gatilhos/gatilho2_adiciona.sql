PRAGMA foreign_keys	= ON;
.mode columns
.headers on
.nullvalue NULL


-- Verifica, quando se adiciona um jogo à tabela Jogo, caso a data de lancamento do jogo seja superior à data atual, insere o novo jogo na categoria 'Pre Order'
CREATE TRIGGER checkPreOrder
AFTER INSERT ON Jogo
FOR EACH ROW
WHEN EXISTS (SELECT * FROM Jogo WHERE (JULIANDAY(DATE()) - JULIANDAY(DataLancamento)) < 0 AND idJogo=New.idJogo)
BEGIN
    INSERT INTO CategoriaJogo
    VALUES (New.idJogo, 12);
END;