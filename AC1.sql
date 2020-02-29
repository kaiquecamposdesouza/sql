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
		Status					VARCHAR(	
	);
