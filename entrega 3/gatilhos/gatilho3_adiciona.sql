PRAGMA foreign_keys	= ON;
.mode columns
.headers on
.nullvalue NULL


-- Impede que a password de um utilizador seja atualizada para a password anterior.
CREATE TRIGGER UpdatePassword
BEFORE UPDATE OF password ON Utilizador
FOR EACH ROW
WHEN EXISTS (SELECT * FROM Utilizador WHERE password = New.password)
BEGIN
    SELECT RAISE(ABORT, 'Não pode alterar a password para a password antiga.');
END;