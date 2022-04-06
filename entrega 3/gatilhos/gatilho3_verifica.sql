PRAGMA foreign_keys	= ON;
.mode columns
.headers on
.nullvalue NULL


UPDATE Utilizador
SET Password = 'SamePasswordTest'
Where Pais = 'Portugal';

.print ''
.print 'Muda a Primeira Vez a Password de todos os Utilizadores que sao de Portugal.'
.print ''

UPDATE Utilizador
SET Password = 'SamePasswordTest'
Where Pais = 'Portugal';

.print ''
.print 'Como tal, ao tentarmos trocar a password outra vez dos Utilizadores que sao de Portugal para um mesmo valor, verificamos que da um erro.'
.print ''