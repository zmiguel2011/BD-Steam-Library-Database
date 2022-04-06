PRAGMA foreign_keys	= ON;
.mode columns
.headers on
.nullvalue NULL

CREATE TRIGGER VerificaValor
BEFORE INSERT ON Transacao
FOR EACH ROW
When Exists (SELECT * FROM Carrinho, Jogo Where Carrinho.IdCarrinho = NEW.IdCarrinho AND Carrinho.IdJogo = NEW.IdJogo AND Carrinho.IdJogo = Jogo.IdJogo AND (New.Valor <> Carrinho.Quantidade*Jogo.PrecoUnitario))
Begin
    SELECT RAISE(ABORT, 'Ocorreu um Erro! Valor da Transacao Incorreto (Nao é compativel com Quantidade * Jogo Preco Unitario)');
End;