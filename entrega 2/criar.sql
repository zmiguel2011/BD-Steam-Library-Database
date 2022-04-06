PRAGMA foreign_keys = ON;
.mode columns
.headers on

--Tabela Utilizador
DROP TABLE IF EXISTS Utilizador;
CREATE TABLE Utilizador(
    IdUtilizador INTEGER PRIMARY KEY,
    Email TEXT CONSTRAINT nn_Utilizador_Email NOT NULL,
    Username TEXT CONSTRAINT nn_Utilizador_Username NOT NULL,
    Password TEXT CONSTRAINT nn_Utilizador_Password NOT NULL,
    DataInscricao DATE CONSTRAINT nn_Utilizador_DataInscricao NOT NULL,
    Pais TEXT CONSTRAINT nn_Utilizador_Pais NOT NULL,
    Morada TEXT CONSTRAINT nn_Utilizador_Morada NOT NULL,
    Perfil TEXT CONSTRAINT nn_Utilizador_Perfil NOT NULL,
    Nickname TEXT CONSTRAINT nn_Utilizador_Nickname NOT NULL,
    Descricao TEXT DEFAULT NULL,
    Nivel INTEGER DEFAULT 1,
    CONSTRAINT unique_email UNIQUE (Email),
    CONSTRAINT unique_perfil UNIQUE (Perfil),
    CONSTRAINT unique_username UNIQUE (Username)
);


--Tabela Grupo
DROP TABLE IF EXISTS Grupo;

CREATE TABLE Grupo(
    IdGrupo INTEGER PRIMARY KEY,
    Nome TEXT CONSTRAINT nn_grupo_nome NOT NULL,
    Abreviatura TEXT CONSTRAINT nn_grupo_abreviatura NOT NULL,
    Tema TEXT CONSTRAINT nn_grupo_tema NOT NULL,
    DataCriacao DATE CONSTRAINT nn_grupo_data NOT NULL,
    CONSTRAINT nome_unique UNIQUE(Nome),
    CONSTRAINT abreviatura_unique UNIQUE(Abreviatura)
);

-- Table: Categoria
DROP TABLE IF EXISTS Categoria;
CREATE TABLE Categoria(
    IdCategoria INTEGER PRIMARY KEY,
    Nome TEXT CONSTRAINT nn_Categoria_Nome NOT NULL,
    CONSTRAINT unique_Nome UNIQUE (Nome)
);

-- Table: Desenvolvedor
DROP TABLE IF EXISTS Desenvolvedor;
CREATE TABLE Desenvolvedor(
    IdDesenvolvedor INTEGER PRIMARY KEY,
    Nome TEXT CONSTRAINT nn_Desenvolvedor_Nome NOT NULL,
    CONSTRAINT unique_nome UNIQUE (Nome)
);

-- Table: Jogo

DROP TABLE IF EXISTS Jogo;
CREATE TABLE Jogo(
    IdJogo INTEGER PRIMARY KEY,
    Titulo TEXT CONSTRAINT nn_Jogo_Titulo NOT NULL,
    Classificacao INTEGER CONSTRAINT nn_Jogo_Classificacao NOT NULL,
    PrecoUnitario INTEGER CONSTRAINT nn_Jogo_Preco NOT NULL,
    DataLancamento DATE CONSTRAINT nn_Jogo_Datalancamento NOT NULL,
    PEGI INTEGER CONSTRAINT nn_Jogo_Pegi NOT NULL,
    IdDesenvolvedor INTEGER,
    CONSTRAINT IdDesenvolvedorReferenceJogo FOREIGN KEY (IdDesenvolvedor) REFERENCES Desenvolvedor ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ValidPreco CHECK (PrecoUnitario>=0),
    CONSTRAINT ValidClassificacao CHECK (Classificacao>=0 and Classificacao<=100),
    CONSTRAINT unique_titulo UNIQUE (titulo)
);


--Tabela Carrinho
DROP TABLE IF EXISTS Carrinho;
CREATE TABLE Carrinho(
    IdCarrinho INTEGER,
    IdJogo INTEGER,
    Quantidade INTEGER CONSTRAINT nn_carrinho_quantidade NOT NULL,
    CONSTRAINT QuantidadeValida CHECK(Quantidade > 0),
    CONSTRAINT IdJogoReference FOREIGN KEY(IdJogo) REFERENCES Jogo ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CarrinhoPKDefinition PRIMARY KEY(IdCarrinho, IdJogo)
);

--Tabela Metodo Pagamento
DROP TABLE IF EXISTS MetodoPagamento;
CREATE TABLE MetodoPagamento(
    IdMetodoPagamento INTEGER PRIMARY KEY,
    NomeMetodo TEXT CONSTRAINT nn_MetodoPagamento_NomeMetodo NOT NULL,
    CONSTRAINT unique_NomeMetodo UNIQUE(NomeMetodo)
);

--Tabela Transacao
DROP TABLE IF EXISTS Transacao;
CREATE TABLE Transacao(
    IdCarrinho INTEGER,
    IdJogo INTEGER,
    IdUtilizador INTEGER,
    DataTransacao DATE CONSTRAINT nn_transacao_dataTransacao NOT NULL,
    Valor REAL CONSTRAINT nn_transacao_valor NOT NULL,
    IdMetodoPagamento INTEGER,
    CONSTRAINT IdMetodoPagamentoReferenceTransacao FOREIGN KEY (IdMetodoPagamento) REFERENCES MetodoPagamento ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT IdUtilizadorReferenceTransacao FOREIGN KEY (IdUtilizador) REFERENCES Utilizador ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ValidValor CHECK (Valor >= 0),
    CONSTRAINT IdCarrinhoReferenceTransacao FOREIGN KEY (IdCarrinho, IdJogo) REFERENCES Carrinho ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT TransacaoPkDefinition PRIMARY KEY (IdCarrinho, IdJogo)
);

-- Table: Biblioteca
DROP TABLE IF EXISTS Biblioteca;
CREATE TABLE Biblioteca (
    IdUtilizador INTEGER,
    IdJogo INTEGER,
    HorasJogadas INTEGER DEFAULT 0,
    HorasJogadas2Semanas INTEGER DEFAULT 0,
    CONSTRAINT IdUtilizadorReferenceBiblioteca FOREIGN KEY (IdUtilizador) REFERENCES Utilizador ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT IdJogoReferenceBiblioteca FOREIGN KEY (IdJogo) REFERENCES Jogo ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PrimaryKeyDefinitionBiblioteca PRIMARY KEY (IdUtilizador, IdJogo),
    CONSTRAINT ValidHorasJogadas2Semanas  CHECK(HorasJogadas >= HorasJogadas2Semanas and HorasJogadas2Semanas <= (14 * 24))
);

-- Table: CategoriaJogo
DROP TABLE IF EXISTS CategoriaJogo;

CREATE TABLE CategoriaJogo(
    IdJogo INTEGER,
    IdCategoria INTEGER,
    CONSTRAINT IdJogoReferenceCategoriajogo FOREIGN KEY (IdJogo) REFERENCES Jogo,
    CONSTRAINT IdCategoriaReferenceCategoriajogo FOREIGN KEY (IdCategoria) REFERENCES Categoria,
    CONSTRAINT PrimaryKeysDefinitionCategoriajogo PRIMARY KEY (IdJogo, IdCategoria)
);

-- Table: Amigo
DROP TABLE IF EXISTS Amigo;

CREATE TABLE Amigo(
    IdUtilizador1 INTEGER,
    IdUtilizador2 INTEGER,
    CONSTRAINT IdUtilizador1ReferenceAmigo FOREIGN KEY (IdUtilizador1) REFERENCES Utilizador ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT IdUtilizador2ReferenceAmigo FOREIGN KEY (IdUtilizador2) REFERENCES Utilizador ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PrimaryKeysDefinitionAmigo PRIMARY KEY (IdUtilizador1, IdUtilizador2),
    CONSTRAINT ValidDifferentUser CHECK (IdUtilizador1 <> IdUtilizador2)
);

--Tabela PertenceGrupo
DROP TABLE IF EXISTS PertenceGrupo;

CREATE TABLE PertenceGrupo(
    IdUtilizador INTEGER,
    IdGrupo INTEGER,
    CONSTRAINT IdUtilizadorReferencePertenceGrupo FOREIGN KEY (IdUtilizador) REFERENCES Utilizador ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT IdGrupoReferencePertenceGrupo FOREIGN KEY (IdGrupo) REFERENCES Grupo ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PrimarykeyDefinitionPertenceGrupo PRIMARY KEY(IdUtilizador, IdGrupo)
);

