.mode columns
.headers on
.nullvalue NULL

DROP View IF EXISTS ViewMediaHorasJogadas;

CREATE View ViewMediaHorasJogadas AS SELECT Pais, ROUND(AVG(HorasJogadas), 1) AS MediaHorasJogadas 
FROM Utilizador, Biblioteca 
WHERE Utilizador.idUtilizador = Biblioteca.idUtilizador 
GROUP BY Pais 
ORDER BY "MÃ©dia de horas jogadas" DESC;

DROP View IF EXISTS MediaNumeroJogos;

CREATE View ViewMediaNumeroJogos AS SELECT Pais, ROUND(AVG(NumeroJogos),1) AS MediaNumeroJogos 
FROM (SELECT username, Pais, Count(*) AS NumeroJogos 
FROM Utilizador, Biblioteca 
WHERE Utilizador.idUtilizador = Biblioteca .idUtilizador 
GROUP BY username) 
GROUP BY pais;

DROP View IF EXISTS ViewMediaNumeroAmigos;

CREATE View ViewMediaNumeroAmigos AS SELECT Pais, ROUND(AVG(NumeroAmigos),1) AS MediaNumeroAmigos 
FROM (SELECT username, Pais, Count(*) AS NumeroAmigos 
FROM Utilizador, Amigo 
WHERE Utilizador.idUtilizador = Amigo.idUtilizador1 
GROUP BY username) 
GROUP BY pais;

DROP View IF EXISTS ViewMediaNumeroGrupos;

CREATE View ViewMediaNumeroGrupos AS SELECT Pais, ROUND(AVG(NumeroGrupos),1) AS MediaNumeroGrupos 
FROM (SELECT username, Pais, Count(*) AS NumeroGrupos 
FROM Utilizador, PertenceGrupo 
WHERE Utilizador.idUtilizador = PertenceGrupo.idUtilizador 
GROUP BY username) 
GROUP BY pais;

DROP View IF EXISTS ViewMediaValorTransacao;

CREATE View ViewMediaValorTransacao AS SELECT Pais, ROUND(AVG(ValorTransacao),1) AS MediaValorTransacao 
FROM (SELECT username, Pais, AVG(valor) AS ValorTransacao 
FROM Utilizador, Transacao 
WHERE Utilizador.idUtilizador = Transacao .idUtilizador 
GROUP BY username) 
GROUP BY pais;

DROP View IF EXISTS ViewEstatisticasPais;

CREATE View ViewEstatisticasPais AS Select ViewMediaValorTransacao.Pais, MediaHorasJogadas, MediaNumeroGrupos,  MediaNumeroAmigos, MediaNumeroJogos, MediaValorTransacao 
FROM ViewMediaHorasJogadas 
JOIN ViewMediaNumeroJogos  ON (ViewMediaHorasJogadas.Pais = ViewMediaNumeroJogos.Pais) 
JOIN ViewMediaNumeroGrupos ON(ViewMediaHorasJogadas.Pais = ViewMediaNumeroGrupos.Pais) 
JOIN ViewMediaValorTransacao ON(ViewMediaHorasJogadas.Pais = ViewMediaValorTransacao.Pais) 
JOIN ViewMediaNumeroAmigos ON(ViewMediaHorasJogadas.Pais = ViewMediaNumeroAmigos.Pais);

SELECT * FROM ViewEstatisticasPais;