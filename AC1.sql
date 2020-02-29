-- CRIANDO TABELA DISCIPLINA OFERTADA
	CREATE TABLE DisciplinaOfertada
	(
		ID					INT IDENTITY NOT NULL,
		idCoordenador		INT NOT NULL,
		DtInicioMatricula	DATE,
		DtFimMatricula		DATE,
		idDisciplina		INT NOT NULL,
		idCurso				INT NOT NULL,
		Ano					VARCHAR(4) NOT NULL,
		Semestre			INT NOT NULL,
		Turma				VARCHAR(15) NOT NULL,
		IdProfessor			INT,
		Metodologia			VARCHAR(80),
		Recurso				VARCHAR(80),
		CriterioAvaliacao	VARCHAR(80),
		PlanoDeAulas		VARCHAR(80),

		CONSTRAINT PK_ID_DisciplinaOfertada PRIMARY KEY (ID)
	);

-- CRIANDO TABELA CURSO
	CREATE TABLE Curso
	(
		ID		INT IDENTITY NOT NULL,
		Nome	VARCHAR(30) NOT NULL,

		CONSTRAINT PK_ID_Curso PRIMARY KEY (ID)
	);

-- CRIANDO TABELA SOLICITAÇÃO MATRICULA
	CREATE TABLE SolicitacaoMatricula
	(
		ID						INT IDENTITY NOT NULL,
		IdAluno					INT NOT NULL,
		IdDisciplinaOfertada	INT NOT NULL,
		DtSolicitacao			DATE NOT NULL,
		IdCoordenador			INT,
		Status					VARCHAR(10),
		
		CONSTRAINT PK_ID_SolicitacaoMatricula PRIMARY KEY (ID)
	);

-- CRIANDO TABELA Atividade
	CREATE TABLE Atividade
	(
		ID				INT IDENTITY NOT NULL,
		Titulo			VARCHAR(10) NOT NULL,
		Descricao		VARCHAR (100),
		Conteudo		VARCHAR (100) NOT NULL,
		Tipo			VARCHAR (50) NOT NULL,
		Extras			VARCHAR (100),
		IdProfessor		INT NOT NULL,

		CONSTRAINT PK_ID_Atividade PRIMARY KEY (ID)
	);

-- CRIANDO TABELA Atividade Vinculada
	CREATE TABLE AtividadeVinculada
	(
		ID							INT IDENTITY NOT NULL,
		IdAtividade					INT NOT NULL,
		IdProfessor					INT NOT NULL,
		IdDisciplinaOfertada		INT NOT NULL,
		Rotulo						VARCHAR (50) NOT NULL,
		Status						VARCHAR (20) NOT NULL,
		DtInicioRespostas			DATETIME NOT NULL,
		DtFimRespostas				DATETIME NOT NULL,

		CONSTRAINT PK_ID_AtividadeVinculada PRIMARY KEY (ID)
	);

-- CRIANDO TABELA Entrega 
	CREATE TABLE Entrega
	(
		ID							INT IDENTITY NOT NULL,
		IdAluno						INT NOT NULL,
		IdAtividadeVinculada		INT NOT NULL,
		Titulo						VARCHAR(10) NOT NULL,
		Resposta					VARCHAR(100) NOT NULL,
		DtEntrega					DATETIME NOT NULL,
		Status						VARCHAR (20) NOT NULL,
		IdProfessor					INT,
		Nota						NUMERIC (4,2),
		DtAvaliacao					DATETIME,
		Obs							VARCHAR (50),
		
		CONSTRAINT PK_ID_Entrega PRIMARY KEY (ID)
	);

-- CRIANDO AS CHAVES ESTRANGEIRAS
	ALTER TABLE DisciplinaOfertada ADD
		CONSTRAINT FK_idCoordenador_DisciplinaOfertada FOREIGN KEY (idCoordenador)
		REFERENCES Coordenador (ID);

	ALTER TABLE DisciplinaOfertada ADD
		CONSTRAINT FK_idDisciplina_DisciplinaOfertada FOREIGN KEY (idDisciplina)
		REFERENCES Disciplina (ID);

	ALTER TABLE DisciplinaOfertada ADD
		CONSTRAINT FK_idCurso_DisciplinaOfertada FOREIGN KEY (idCurso)
		REFERENCES Curso (ID);
--------------------------------------------------------------------------------------------
	ALTER TABLE SolicitacaoMatricula ADD
		CONSTRAINT FK_IdAluno_SolicitacaoMatricula FOREIGN KEY (idAluno)
		REFERENCES Aluno (ID);

	ALTER TABLE SolicitacaoMatricula ADD
		CONSTRAINT FK_IdDisciplinaOfertada_SolicitacaoMatricula FOREIGN KEY (IdDisciplinaOfertada)
		REFERENCES DisciplinaOfertada (ID);

	ALTER TABLE SolicitacaoMatricula ADD
		CONSTRAINT FK_IdCoordenador_SolicitacaoMatricula FOREIGN KEY (IdCoordenador)
		REFERENCES Coordenador (ID);
-------------------------------------------------------------------------------------------------------
	ALTER TABLE Atividade ADD
		CONSTRAINT FK_IdProfessor_Atividade FOREIGN KEY (IdProfessor)
		REFERENCES Professor (ID);
-------------------------------------------------------------------------------------------------------
	ALTER TABLE AtividadeVinculada ADD
		CONSTRAINT FK_IdAtividade_AtividadeVinculada FOREIGN KEY (IdAtividade)
		REFERENCES Atividade (ID);

	ALTER TABLE AtividadeVinculada ADD
		CONSTRAINT FK_IdProfessor_AtividadeVinculada FOREIGN KEY (IdProfessor)
		REFERENCES Professor (ID);

	ALTER TABLE AtividadeVinculada ADD
		CONSTRAINT FK_IdDisciplinaOfertada_AtividadeVinculada FOREIGN KEY (IdDisciplinaOfertada)
		REFERENCES DisciplinaOfertada (ID);
------------------------------------------------------------------------------------------------------
	ALTER TABLE Entrega ADD
			CONSTRAINT FK_IdAluno_Entrega FOREIGN KEY (IdAluno)
			REFERENCES Aluno (ID);
	
	ALTER TABLE Entrega ADD
			CONSTRAINT FK_IdAtividadeVinculada_Entrega FOREIGN KEY (IdAtividadeVinculada)
			REFERENCES AtividadeVinculada (ID);

	ALTER TABLE Entrega ADD
			CONSTRAINT FK_IdProfessor_Entrega FOREIGN KEY (IdProfessor)
			REFERENCES Professor (ID);

-- CRIANDO CHECK
	ALTER TABLE DisciplinaOfertada ADD
		CONSTRAINT CK_Ano_DisciplinaOfertada CHECK (Ano>=1900 AND Ano<=2100);

	ALTER TABLE DisciplinaOfertada ADD
		CONSTRAINT CK_Semestre_DisciplinaOfertada CHECK (Semestre>=1 AND Semestre<=2);

	ALTER TABLE DisciplinaOfertada ADD
		CONSTRAINT CK_Turma_DisciplinaOfertada CHECK (Turma IN ('ABCDEFGHIJKLMNOPQRSTUVXWYZ'));
---------------------------------------------------------------------------------------------------------------------------------
	ALTER TABLE SolicitacaoMatricula ADD
			CONSTRAINT CK_Status_SolicitacaoMatricula CHECK (Status IN ('Solicitada','Aprovada','Rejeitada','Cancelada'));
---------------------------------------------------------------------------------------------------------------------------------
	ALTER TABLE Atividade ADD
			CONSTRAINT CK_Tipo_Atividade CHECK (Tipo IN ('Resposta Abreta','Teste'));
---------------------------------------------------------------------------------------------------------------------------------
	ALTER TABLE Entrega ADD
			CONSTRAINT CK_Status_Entrega CHECK (Status IN ('Entregue','Corrigido'));

	ALTER TABLE Entrega ADD
			CONSTRAINT CK_Nota_Entrega CHECK (Nota>=00.00 AND Nota<=10.00);

-- CRIANDO CHAVE ÚNICA
	ALTER TABLE Curso ADD
			CONSTRAINT UQ_Nome_Curso UNIQUE(Nome);
----------------------------------------------------------------------------------------------------------------------------------
	ALTER TABLE Atividade ADD
			CONSTRAINT UQ_Titulo_Atividade UNIQUE(Titulo);

--CRINADO VALOR PADRÃO
	ALTER TABLE SolicitacaoMatricula ADD
			CONSTRAINT DF_DtSolicitante_SolicitacaoMatricula DEFAULT (GETDATE()) FOR DtSolicitante;

	ALTER TABLE SolicitacaoMatricula ADD
			CONSTRAINT DF_Status_SolicitacaoMatricula DEFAULT ('Solicitada') FOR Status;
----------------------------------------------------------------------------------------------------------------------------------
	ALTER TABLE Entrega ADD
			CONSTRAINT DF_DtEntrega_Entrega DEFAULT (GETDATE()) FOR DtEntrega;

	ALTER TABLE Entrega ADD
			CONSTRAINT DF_Status_Entrega DEFAULT ('Entregue') FOR Status;

	


	