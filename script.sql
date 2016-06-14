DROP DATABASE IF EXISTS siga;
CREATE DATABASE IF NOT EXISTS siga;
USE siga;

-- ----------------------------------------------------------------------------
-- Pessoa
-- Criado por: Grupo 6A
-- Tambem precisa popular as tabelas Endereço e E-mail

DROP TABLE IF EXISTS tbl_pessoa;
CREATE TABLE IF NOT EXISTS tbl_pessoa
  (
     pessoa_id    VARCHAR(15) NOT NULL,
     prenome      VARCHAR(50),
     sobrenome    VARCHAR(50),
     raca         VARCHAR(50),
     sexo         VARCHAR(30),
     cidade_nasc  VARCHAR(60),
     pais_nasc    VARCHAR(30),
     uf_nasc      VARCHAR(30),
     data_nasc    DATE,
     pai_filiacao VARCHAR(30),
     mae_filiacao VARCHAR(30),
     PRIMARY KEY (pessoa_id)
  );


DROP TABLE IF EXISTS tbl_email;
CREATE TABLE IF NOT EXISTS tbl_email
  (
     pessoa VARCHAR(15) NOT NULL,
     email  VARCHAR(60),
     CONSTRAINT pk_email PRIMARY KEY (pessoa, email),
     CONSTRAINT email_fk_pessoa FOREIGN KEY (pessoa) REFERENCES tbl_pessoa (pessoa_id)
  ); 


DROP TABLE IF EXISTS tbl_endereco;
CREATE TABLE IF NOT EXISTS tbl_endereco
  (
     pessoa          VARCHAR(15) NOT NULL,
     cep_end         VARCHAR(30),
     pais_end        VARCHAR(60),
     uf_end          VARCHAR(60),
     cidade_end      VARCHAR(30),
     bairro_end      VARCHAR(30),
     complemento_end VARCHAR(30),
     rua_end         VARCHAR(30),
     ddd_end_tel     VARCHAR(30),
     prefixo_end_tel VARCHAR(30),
     numero_end_tel  VARCHAR(30),
     ramal_end_tel   VARCHAR(30),
     tipo_end        VARCHAR(30),
     CONSTRAINT pk_endereco PRIMARY KEY (pessoa, cep_end),
     CONSTRAINT end_fk_pessoa FOREIGN KEY (pessoa) REFERENCES tbl_pessoa (pessoa_id)
  ); 


INSERT INTO tbl_pessoa (pessoa_id, prenome, sobrenome, raca, sexo, cidade_nasc, pais_nasc, UF_nasc, data_nasc, pai_filiacao, mae_filiacao)
VALUES

-- Docentes
('24174616256', 'José', 'Silva', 'Branca', 'Masculino', 'São Carlos', 'Brasil', 'SP', '1990-12-31', 'João Silva', 'Maria Machado'),
('40078919665', 'Raimundo', 'Carvalho', 'Branca', 'Masculino', 'Pirapora do Bom Jesus', 'Brasil', 'SP', '1989-09-24', 'Joselyto Carvalho', 'Maria Castelo'),
('72003800670', 'Alice', 'Moreira', 'Branca', 'Feminino', 'São Paulo', 'Brasil', 'SP', '1992-01-23', 'Fernando Moreira', 'Ana Santos'),
('72799547230', 'Roberta', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira'),
('11104385910', 'Legolas', 'Silva', 'Elfo', 'Masculino', 'Terra Média', 'Brasil', 'AC', '1991-02-28', 'Sívio Silva', 'Sílva Silva'),

-- Estudantes
('90778718530', 'Estudante1', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira'),
('99982994204', 'Estudante2', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira'),
('02835384308', 'Estudante3', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira'),
('91994871601', 'Estudante4', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira'),
('77426047792', 'Estudante5', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira'),
('54523707227', 'Estudante6', 'Schmitt', 'Branca', 'Feminino', 'Belo Horizonte', 'Brasil', 'MG', '1988-04-04', 'José Schmitt', 'Carla Pereira');


-- ----------------------------------------------------------------------------
-- Docente
-- Criado por: Grupo 6A
-- Modificar os outros campos, mas manter os CPFs!

DROP TABLE IF EXISTS tbl_docente;
CREATE TABLE tbl_docente
  (
     pessoa          VARCHAR(15) NOT NULL,
     titularidade    VARCHAR(50),
     alivio_integral VARCHAR(50),
     alivio_parcial  VARCHAR(50),
     CONSTRAINT pk_docente PRIMARY KEY (pessoa),
     CONSTRAINT docente_fk_pessoa FOREIGN KEY (pessoa) REFERENCES tbl_pessoa (pessoa_id)
  );


DROP TABLE IF EXISTS tbl_carga_horaria;
CREATE TABLE tbl_carga_horaria
  (
     pessoa           VARCHAR(15) NOT NULL,
     semestre_inicio  DATE,
     semestre_termino DATE,
     ano_inicio       VARCHAR(8),
     ano_termino      VARCHAR(8),
     horas_aula       INT,
     CONSTRAINT pk_carga PRIMARY KEY (pessoa, semestre_inicio),
     CONSTRAINT carga_fk_pessoa FOREIGN KEY (pessoa) REFERENCES tbl_pessoa (pessoa_id)
  ); 


INSERT INTO tbl_docente (pessoa, titularidade, alivio_integral) VALUES
('24174616256', 'titular', 'alivio integral'),
('40078919665', 'titular', 'alivio integral'),
('72003800670', 'titular', 'alivio integral'),
('72799547230', 'titular', 'alivio integral'),
('11104385910', 'titular', 'alivio integral');


-- ----------------------------------------------------------------------------
-- Membro
-- Criado por: Wellyson (4A)
-- membro(PK(FK_Docente(pessoa)), categoria, data_eleicao, periodo_inicio, periodo_fim) está na 3FN porque:
-- Está na 1FN: porque todos os atributos são atômicos (o atributo composto “período” foi dividido em “período_inicio” e “periodo_fim”);
-- Está na 2FN: porque só há uma chave primária (e portanto, não existe atributo não chave que é dependente de somente uma parte da chave primária);
-- Está na 3FN: porque não existem atributos não chave que sejam dependentes de outros atributos não chave.

DROP TABLE IF EXISTS tbl_membro;
CREATE TABLE tbl_membro
  (
     cpf            VARCHAR(15) NOT NULL,
     categoria      VARCHAR(64) NOT NULL,
     data_eleicao   DATE NOT NULL,
     periodo_inicio DATE NOT NULL,
     periodo_fim    DATE NOT NULL,
     CONSTRAINT membro_pk PRIMARY KEY (cpf),
     CONSTRAINT membro_fk_docente FOREIGN KEY (cpf) REFERENCES tbl_docente (pessoa)
  );


-- ----------------------------------------------------------------------------
-- Reunião
-- Criado por: André Rocha (4A)

DROP TABLE IF EXISTS tbl_reuniao;
CREATE TABLE tbl_reuniao
  (
     numero INT(5) NOT NULL,
     data   DATE NOT NULL,
     CONSTRAINT reuniao_pk PRIMARY KEY (numero)
  ); 


-- ----------------------------------------------------------------------------
-- Ata
-- Criado por: Wellyson (4A)
-- ata(PK(FK_Reuniao(numero)), decisoes, pauta, topicos, resumo) está na 3FN:
-- Está na 1FN: porque todos os atributos são atômicos;
-- Está na 2FN: porque só há uma chave primária (e portanto, não existe atributo não chave que é dependente de somente uma parte da chave primária);
-- Está na 3FN: porque não existem atributos não chave que sejam dependentes de outros atributos não chave.

DROP TABLE IF EXISTS tbl_ata;
CREATE TABLE tbl_ata
  (
     numero_reuniao INT(5) NOT NULL,
     decisoes       VARCHAR(256) NOT NULL,
     pauta          VARCHAR(256) NOT NULL,
     topicos        VARCHAR(256) NOT NULL,
     resumo         VARCHAR(256) NOT NULL,
     CONSTRAINT ata_pk PRIMARY KEY (numero_reuniao),
     CONSTRAINT ata_fk_reuniao FOREIGN KEY (numero_reuniao) REFERENCES tbl_reuniao (numero)
  ); 

-- ----------------------------------------------------------------------------
-- Contribuição
-- Criado por: Lucas Bataglia (4A)
-- Contribuição(PK(FK_Membro(id), FK_ata(numero_reuniao)) está na 3FN:
-- Está na 1FN: porque todos os atributos são atômicos;
-- Está na 2FN: Não existe atributo não chave que é dependente de somente uma parte da chave primária);
-- Está na 3FN: porque não existem atributos não chave que sejam dependentes de outros atributos não chave.

DROP TABLE IF EXISTS tbl_ata;
CREATE TABLE tbl_ata
  (
     numero_reuniao INT(5) NOT NULL,
     decisoes       VARCHAR(256) NOT NULL,
     pauta          VARCHAR(256) NOT NULL,
     topicos        VARCHAR(256) NOT NULL,
     resumo         VARCHAR(256) NOT NULL,
     CONSTRAINT ata_pk PRIMARY KEY (numero_reuniao),
     CONSTRAINT ata_fk_reuniao FOREIGN KEY (numero_reuniao) REFERENCES tbl_reuniao (numero)
  );


-- ----------------------------------------------------------------------------
-- Participa
-- Criado por: Lucas Bataglia (4A)
-- Participa ( PK(FK_Membro(cpf), FK_reuniao(numero_reuniao))) está na 3FN:
-- Está na 1FN: porque todos os atributos são atômicos;
-- Está na 2FN: Não existe atributo não chave que é dependente de somente uma parte da chave primária);
-- Está na 3FN: porque não existem atributos não chave que sejam dependentes de outros atributos não chave.

DROP TABLE IF EXISTS tbl_participa;
CREATE TABLE tbl_participa
  (
     id             VARCHAR(15) NOT NULL,
     numero_reuniao INT(5) NOT NULL,
     CONSTRAINT participa_pk PRIMARY KEY (id, numero_reuniao),
     CONSTRAINT part_fk_reuniao FOREIGN KEY (numero_reuniao) REFERENCES tbl_reuniao (numero),
     CONSTRAINT part_fk_membro FOREIGN KEY (id) REFERENCES tbl_membro (cpf)
  ); 


-- ----------------------------------------------------------------------------
-- Estudante
-- Criado por: Pedro Padoveze

DROP TABLE IF EXISTS tbl_estudante;
CREATE TABLE IF NOT EXISTS tbl_estudante
  (
     ano_conclusao INT(4),
     ensino_medio  VARCHAR(80),
     ra            INT(6) NOT NULL,
     pessoa_id     VARCHAR(15) NOT NULL,
     CONSTRAINT fk_pessoa_id FOREIGN KEY (pessoa_id) REFERENCES tbl_pessoa (pessoa_id),
     CONSTRAINT estudante_pk PRIMARY KEY (ra)
  ); 

INSERT INTO tbl_estudante (ra, ensino_medio, ano_conclusao, pessoa_id) VALUES
(524896, "Escola Primaria Carlos Gomes", 2012, '90778718530'),
(425169, "Escola Primaria Carlos Gomes", 2010, '99982994204'),
(334578, "Colegio Municipal do Municipio de São Carlos", 2009, '02835384308'),
(654321, "Colegio CBA", 2015, '91994871601'),
(112358, "Colegio Fibonacci", 2004, '54523707227'),
(123456, "Colegio ABC", 2005, '77426047792');


-- ----------------------------------------------------------------------------
-- Atividade Complementar
-- Criado por: Rodrigo Teixeira Garcia (5A)

DROP TABLE IF EXISTS  tbl_atividade_complementar;
CREATE TABLE IF NOT EXISTS tbl_Atividade_Complementar (
    tipo VARCHAR(50) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    id INT NOT NULL,
    ra_ativ INT NOT NULL,
    FOREIGN KEY (ra_ativ)
        REFERENCES tbl_Estudante (ra),
    PRIMARY KEY (id)
);

-- View para contagem das atividades complementares
DROP view IF EXISTS v_atividade_numero;
CREATE OR REPLACE view v_atividade_numero
AS
  SELECT tipo AS tipo,
         Count(*)     AS qtd_ativ
  FROM   tbl_atividade_complementar
  GROUP  BY tipo; 


-- View para exibição de qual atividade cada aluno realiza
DROP view IF EXISTS v_atividade_aluno;
CREATE OR replace VIEW v_atividade_aluno
AS
  SELECT a.tipo,
         e.ra
  FROM   tbl_atividade_complementar AS a,
         tbl_estudante AS e
  WHERE  a.ra_ativ = e.ra; 

INSERT INTO tbl_atividade_complementar(tipo, descricao, carga_horaria, id, ra_ativ) VALUES
("Empresa Júnior", "Empresa ambientada no contexto universitário", 60, 100, 524896), 
("Atlética", "Organização que visa eventos de integração entre os alunos", 40, 200, 425169), 
("DCE", "Diretório Central dos Estudantes. Órgão para representação dos estudantes", 60, 300, 334578), 
("PET", "Programa de Ensino Tutorial. Desenvolvimento de projetos com auxílio de bolsa e supervisionado", 60, 400, 123456), 
("IC", "Iniciação Científica. Desenvolvimento de projeto com auxílio ou não de bolsa", 60, 500, 654321);


-- ----------------------------------------------------------------------------
-- Departamento
-- Criado por: Rodrigo Teixeira Garcia (5A)

DROP TABLE IF EXISTS  tbl_departamento;
CREATE TABLE IF NOT EXISTS tbl_departamento
  (
     centro VARCHAR(10) NOT NULL,
     campi  VARCHAR(20) NOT NULL,
     nome   VARCHAR(50) NOT NULL,
     sigla  VARCHAR(10) NOT NULL,
     PRIMARY KEY (sigla)
  ); 


-- View que conta o numero de departamentos
DROP view IF EXISTS v_departamento_numero;
CREATE OR replace VIEW v_departamento_numero
AS
  SELECT nome     AS nome,
         Count(*) AS qtd_depart
  FROM   tbl_departamento
  GROUP  BY nome; 


-- View que exibe cada departamento com seu respectivo capus e centro
DROP view IF EXISTS v_departamentos;
CREATE OR REPLACE view v_departamentos
AS
  SELECT nome, campi, sigla, centro
  FROM   tbl_departamento;
  

INSERT INTO tbl_departamento(centro, campi, nome, sigla) VALUES
("CCET", "São Carlos", "Departamento de Computação", "DC"), 
("CCET", "Sorocaba", "Departamento de Computação", "DComp"), 
("CCA", "Araras", "Desenvolvimento Rural", "DDR"), 
("CCET", "São Carlos", "Departamento de Matemática", "DM"), 
("CCET", "São Carlos", "Departamento de Física", "DF");


-- ----------------------------------------------------------------------------
-- Disciplina
-- Criado por: Vitor Rocha (5A)

DROP TABLE IF EXISTS tbl_disciplina;
CREATE TABLE IF NOT EXISTS tbl_disciplina
  (
     codigo                  VARCHAR(20) NOT NULL,
     nome                    VARCHAR(40),
     ementa                  TEXT,
     creditospraticos        INT,
     creditosteoricos        INT,
     departamento            VARCHAR(10) NOT NULL,
     idatividadecomplementar INT,
     CONSTRAINT fk_depto_disc FOREIGN KEY (departamento) REFERENCES tbl_departamento (sigla),
     CONSTRAINT fk_atcomp_disc FOREIGN KEY (idatividadecomplementar) REFERENCES tbl_atividade_complementar (id),
     CONSTRAINT pk_disc PRIMARY KEY (codigo)
  ); 

INSERT INTO tbl_Disciplina (codigo, nome, ementa, creditosTeoricos, creditosPraticos, departamento) VALUES
('02.522-4', 'Laboratorio de Banco de Dados', '', 0, 2, 'DC'),
('02.521-6', 'Banco de Dados', '', 4, 0, 'DC'),
('02.507-0', 'Construcao de Algoritmos e Programacao', '', 4, 4, 'DComp'),
('02.502-0', 'Programacao de Computadores', '', 2, 2, 'DComp'),
('08.910-9', 'Calculo 1', '', 4, 0, "DM");


-- ----------------------------------------------------------------------------
-- Técnico Administrativo
-- Criado por: Guilherme Lemos (4A)
-- TecnicoAdministrativo(PK(FK_Pessoa(id))) está na 3FN:
-- Está na 1FN: porque todos os atributos são atômicos;
-- Está na 2FN: porque só há uma chave primária (e portanto, não existe atributo não chave que é dependente de somente uma parte da chave primária);
-- Está na 3FN: porque não existem atributos não chave que sejam dependentes de outros atributos não chave.

DROP TABLE IF EXISTS tbl_tecnico_administrativo;
CREATE TABLE tbl_tecnico_administrativo
  (
     id VARCHAR(15) NOT NULL,
     CONSTRAINT tecnico_pk PRIMARY KEY (id),
     CONSTRAINT tecnico_fk_id FOREIGN KEY (id) REFERENCES tbl_pessoa (pessoa_id)
  ); 


INSERT INTO tbl_Tecnico_Administrativo(id) VALUES
('24174616256');

-- ----------------------------------------------------------------------------
-- Calendario
-- Criado por: Grupo 6A

DROP TABLE IF EXISTS tbl_calendario;
CREATE TABLE IF NOT EXISTS tbl_calendario (
    ano INT NOT NULL,
    semestre INT NOT NULL,
    tipo VARCHAR(10),
    data_ini DATE,
    data_ter DATE,
    CONSTRAINT pk_calendario PRIMARY KEY (ano , semestre)
); 


DROP VIEW IF EXISTS `v_calendario`;
CREATE VIEW v_calendario AS
    SELECT 
        tbl_calendario.ano AS ano,
        tbl_calendario.semestre AS semestre,
        DATE_FORMAT(tbl_calendario.data_ini, '%d-%c-%Y') AS data_ini,
        DATE_FORMAT(tbl_calendario.data_ter, '%d-%c-%Y') AS data_ter
    FROM
        tbl_calendario; 


INSERT INTO tbl_calendario(ano, semestre, tipo, data_ini, data_ter) VALUES
(2016, 1, "Acadêmico", '2016-02-01', '2016-07-30'), 
(2016, 2, "Acadêmico", '2016-08-01', '2016-12-15'), 
(2017, 1, "Acadêmico", '2017-02-01', '2017-07-30'), 
(2017, 2, "Acadêmico", '2017-08-01', '2017-12-15'), 
(2018, 1, "Acadêmico", '2018-02-01', '2018-07-30');


-- ----------------------------------------------------------------------------
-- Turma
-- Criado por: Vitor Rocha (5A)

DROP TABLE IF EXISTS tbl_turma;
CREATE TABLE IF NOT EXISTS tbl_turma
  (
     codigoturma      VARCHAR(1) NOT NULL,
     codigodisciplina VARCHAR(20) NOT NULL,
     numerodevagas    INT(3),
     horario          VARCHAR(20),
     dia              VARCHAR(20),
     ano              INT(11) NOT NULL,
     semestre         INT(11) NOT NULL,
     CONSTRAINT turma_fk_calendario FOREIGN KEY (ano, semestre) REFERENCES tbl_calendario (ano, semestre),
     CONSTRAINT fk_turma_codigodisciplina FOREIGN KEY (codigodisciplina) REFERENCES tbl_disciplina (codigo),
     CONSTRAINT pk_turma PRIMARY KEY (codigodisciplina, codigoturma, semestre, ano)
  ); 

INSERT INTO tbl_turma (semestre, ano, codigoTurma, codigoDisciplina, numeroDeVagas, horario, dia) VALUES
(1, 2016, 'A', '02.522-4', 25, '14:00', 'terca-feira'),
(1, 2016, 'B', '02.522-4', 25, '16:00', 'terca-feira'),
(1, 2016, 'C', '02.522-4', 25, '08:00', 'quarta-feira'),
(1, 2016, 'A', '02.521-6', 50, '14:00', 'quinta-feira'),
(1, 2016, 'A', '02.502-0', 25, '8:00', 'sexta-feira');


-- ----------------------------------------------------------------------------
-- Conselho
-- Criado por: Guilherme Lemos (4A)
-- Conselho(PK(DataInicioVigencia,DataFimVigencia), sigla, tipo) está na 3FN:
-- Está na 1FN: porque todos os atributos são atômicos, já que o atributo PeríodoVigencia foi separado em dataInicioVigencia e dataFimVigencia;
-- Está na 2FN: Não existe atributo não chave que é dependente de somente uma parte da chave primária;
-- Está na 3FN: porque não existem atributos não chave que sejam dependentes de outros atributos não chave.

DROP TABLE IF EXISTS tbl_conselho;
CREATE TABLE tbl_conselho
  (
     sigla              CHAR(8) NOT NULL,
     tipo               CHAR(20) NOT NULL,
     datainiciovigencia DATE NOT NULL,
     datafimvigencia    DATE NOT NULL,
     CONSTRAINT conselho_pk PRIMARY KEY (datainiciovigencia, datafimvigencia)
  ); 

INSERT INTO tbl_Conselho (sigla, tipo, dataInicioVigencia, dataFimVigencia) VALUES
('CoG', 'Graduação', '1998-01-31', '2016-12-31'),
('CoPG', 'Pós-Graduação', '2008-01-01', '2016-12-31'),
('CoP', 'Pesquisa', '2012-07-01', '2016-12-31');


-- ----------------------------------------------------------------------------
-- Estágio
-- Criado por: Julio Batista (5A)

DROP TABLE IF EXISTS tbl_estagio;
CREATE TABLE IF NOT EXISTS tbl_estagio
  (
     pais_atuacao       CHAR(3) NOT NULL DEFAULT 'BRA' comment 'ISO 3166-1 alfa-3',
     termo_compromisso  MEDIUMTEXT NOT NULL,
     carta_avaliacao    MEDIUMTEXT NOT NULL,
     supervisor_empresa VARCHAR(128) NOT NULL,
     empresa            VARCHAR(128) NOT NULL,
     obrigatorio        TINYINT(1) NOT NULL,
     data_termino       DATE NOT NULL,
     data_inicio        DATE NOT NULL,
     estudante_ra       INT(6) NOT NULL,
     supervisor_id      VARCHAR(15) NOT NULL,
     CONSTRAINT pk_estagio PRIMARY KEY (data_inicio, estudante_ra, supervisor_id),
     CONSTRAINT estagio_fk_estudante FOREIGN KEY (estudante_ra) REFERENCES tbl_estudante (ra),
     CONSTRAINT estagio_fk_supervisor FOREIGN KEY (supervisor_id) REFERENCES tbl_docente (pessoa)
  ); 


-- View que mostra quantos estágios foram feitos em cada país
DROP VIEW IF EXISTS v_estagio_paises;
CREATE OR REPLACE view v_estagio_paises
AS
  SELECT pais_atuacao AS pais_atuacao,
         Count(*)     AS qtd_estagios
  FROM   tbl_estagio
  GROUP  BY pais_atuacao;

-- View que mostra quantos estudantes estão atualmente empregados em cada empresa
DROP view IF EXISTS v_estagio_empresas;
CREATE OR REPLACE view v_estagio_empresas
AS
  SELECT empresa  AS empresa,
         Count(*) AS qtd_estudantes
  FROM   tbl_estagio
  WHERE  data_termino >= Curdate()
  GROUP  BY empresa; 


INSERT INTO tbl_estagio (pais_atuacao, termo_compromisso, carta_avaliacao, supervisor_empresa, empresa, obrigatorio, data_termino, data_inicio, estudante_ra, supervisor_id) VALUES
('BRA', 'Texto do termo de compromisso da EMBRAER', 'Carta de avaliação do 334578', 'Mauro Kern',            'EMBRAER',  '1',    '2016-06-30', '2016-01-01', '334578', '24174616256'),
('BRA', 'Texto do termo de compromisso da Oracle', 'Carta de avaliação do 123456', 'Larry Ellison',         'Oracle',   '1',    '2013-06-30', '2013-01-01', '123456', '24174616256'),
('FIN', 'Texto do termo de compromisso da Nokia', 'Carta de avaliação do 123456', 'Rich Green',            'Nokia',    '0',    '2014-12-31', '2014-07-01', '123456', '24174616256'),
('USA', 'Texto do termo de compromisso da IBM', 'Carta de avaliação do 123456', 'Mark Dean',    'IBM',      '0',    '2015-03-31', '2015-01-01', '123456', '11104385910'),
('KOR', 'Texto do termo de compromisso da Samsung', 'Carta de avaliação do 123456', 'Omar Khan',             'Samsung',  '0',    '2016-06-30', '2016-01-01', '123456', '24174616256'),
('SWE', 'Texto do termo de compromisso da Ericsson', 'Carta de avaliação do 654321', 'Håkan Eriksson',        'Ericsson', '0',    '2014-12-31', '2014-07-01', '654321', '72003800670'),
('BRA', 'Texto do termo de compromisso da Microsoft', 'Carta de avaliação do 654321', 'Dave Campbell',         'Microsoft', '1',   '2015-12-31', '2015-07-01', '654321', '72003800670'),
('BRA', 'Texto do termo de compromisso da EMBRAER', 'Carta de avaliação do 654321', 'Mauro Kern',            'EMBRAER',  '1',    '2016-06-30', '2016-01-01', 654321, '24174616256'),
('BRA', 'Texto do termo de compromisso do Facebook', 'Carta de avaliação do 112358', 'Mike Schroepfer',       'Facebook', '1',    '2015-12-31', '2015-07-01', '112358', '11104385910'),
('USA', 'Texto do termo de compromisso da Google', 'Carta de avaliação do 112358', 'Larry Page',            'Google',   '0',    '2016-06-30', '2016-01-01', '112358', '40078919665');


-- ----------------------------------------------------------------------------
-- Curso
-- Criado por: Eduardo Marinho (5A)

DROP TABLE IF EXISTS  tbl_curso;
CREATE TABLE IF NOT EXISTS tbl_Curso (
    sigla VARCHAR(10) NOT NULL,
    nome VARCHAR(30) NOT NULL,
    duracaomedia INT NOT NULL,
    duracaomaxima INT NOT NULL,
    PPPaprovado LONGTEXT NOT NULL,
    centro VARCHAR(10) NOT NULL,
    creditosNecessarios INT NOT NULL,
    creditosComplementares INT NOT NULL,
    creditosObrigatorios INT NOT NULL,
    creditosOptativos INT NOT NULL,
    PRIMARY KEY (sigla)
);


INSERT INTO tbl_Curso (sigla, nome, duracaomedia, duracaomaxima, PPPaprovado, centro, creditosNecessarios, creditosComplementares, creditosObrigatorios, creditosOptativos) VALUES
("ENC", "Engenharia de Computação", 5, 9, "Texto do PPP", "CCET", 272, 0, 260, 12),
("BCC", "Ciência da Computação", 5, 9, "Texto do PPP", "CCET", 212, 4, 154, 54),
("EP", "Engenharia de Produção", 5, 9, "Texto do PPP", "CCET", 262, 0, 250, 12),
("EC", "Engenharia Civil", 5, 9, "Texto do PPP", "CCET", 270, 0, 258, 12),
("EQ", "Engenharia Química", 5, 9, "Texto do PPP", "CCET", 274, 0, 262, 12);


-- ----------------------------------------------------------------------------
-- Matricula
-- Criado por: Pedro Padoveze (5A)

DROP TABLE IF EXISTS  tbl_matricula;
CREATE TABLE IF NOT EXISTS tbl_matricula (
    ira INT(5),
    creditos_obrigatorios INT(3),
    creditos_optativos INT(3),
    creditos_complementares INT(3),
    perfil INT(2),
    ano_ingresso INT(4),
    ra INT(6) NOT NULL,
    sigla VARCHAR(10) NOT NULL,
    FOREIGN KEY (ra)
        REFERENCES tbl_Estudante (ra),
    FOREIGN KEY (sigla)
        REFERENCES tbl_curso (sigla),
    PRIMARY KEY (ra , sigla)
);

INSERT INTO tbl_Matricula (sigla, ra, ira, creditos_obrigatorios, creditos_optativos, creditos_complementares, perfil, ano_ingresso) VALUES
("BCC", 524896, 12854, 100, 20, 4, 7, 2013),
("EnC", 425169, 9856, 140, 20, 4, 11, 2011),
("EnC", 334578, 7569, 155, 16, 4, 13, 2010),
("EQ", 654321, 20000, 0, 0, 0, 1, 2016),
("EP", 112358, 12985, 125, 12, 4, 9, 2012);


-- ----------------------------------------------------------------------------
-- Pré-Requisito
-- Criado por: Vitor Rocha (5A)

DROP TABLE IF EXISTS tbl_pre_requisito;
CREATE TABLE IF NOT EXISTS tbl_Pre_Requisito (
    disciplina VARCHAR(20) NOT NULL,
    preRequisito VARCHAR(20) NOT NULL,
    CONSTRAINT fk_prereq1 FOREIGN KEY (disciplina)
        REFERENCES tbl_Disciplina (codigo),
    CONSTRAINT fk_prereq2 FOREIGN KEY (preRequisito)
        REFERENCES tbl_Disciplina (codigo),
    CONSTRAINT pk_prereq PRIMARY KEY (disciplina , preRequisito)
);

INSERT INTO tbl_Pre_Requisito (disciplina, preRequisito) VALUES
('02.522-4', '02.521-6'),
('02.502-0', '02.507-0');


-- ----------------------------------------------------------------------------
-- Grade
-- Criado por: Eduardo Marinho (5A)

DROP TABLE IF EXISTS tbl_grade;
CREATE TABLE tbl_Grade (
    perfil INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    sigla VARCHAR(10) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    FOREIGN KEY (sigla)
        REFERENCES tbl_Curso (sigla),
    FOREIGN KEY (codigo)
        REFERENCES tbl_Disciplina (codigo),
    PRIMARY KEY (sigla , codigo)
);

INSERT INTO tbl_Grade (perfil, tipo, sigla, codigo)	VALUES
(1, "Obrigatória", "ENC", "02.507-0"),
(6, "Obrigatória", "ENC", "02.521-6"),
(7, "Obrigatória", "ENC", "02.522-4"),
(1, "Obrigatória", "BCC", "02.507-0"),
(6, "Obrigatória", "BCC", "02.521-6"),
(7, "Obrigatória", "BCC", "02.522-4");


-- ----------------------------------------------------------------------------
-- Prédio
-- Criado por: Grupo 6A

DROP TABLE IF EXISTS tbl_predio;
CREATE TABLE IF NOT EXISTS tbl_predio (
    sigla VARCHAR(5) NOT NULL,
    descricao VARCHAR(50),
    imagem VARCHAR(120),
    localizacao_geografica VARCHAR(80),
    mapa_localizacao VARCHAR(80),
    primeira_sala INT(3) NOT NULL,
    ultima_sala INT(3) NOT NULL,
    CONSTRAINT pk_predio PRIMARY KEY (sigla)
);


INSERT INTO tbl_predio VALUES
('AT-1','', 'http://www2.ufscar.br/servicos/img_ru.jpg', '','',3,17),
('AT-2','', 'http://www2.ufscar.br/uploads/44445_portal_sao_carlos_norte_atual_3609123126331919332.jpg', '','',26,44),
('AT-4','', 'http://www2.ufscar.br/vidaacademica/img_cienciaexata.jpg', '','',67,91);


-- ----------------------------------------------------------------------------
-- Sala
-- Criado por: Grupo 6A

DROP TABLE IF EXISTS tbl_sala;
CREATE TABLE IF NOT EXISTS tbl_sala (
    numero INT NOT NULL,
    predio VARCHAR(5) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    recursos VARCHAR(100) NOT NULL,
    caracteristicas VARCHAR(100) NOT NULL,
    capacidade_de_alunos INT NOT NULL,
    CONSTRAINT pk_sala PRIMARY KEY (numero , predio),
    CONSTRAINT sala_fk_predio FOREIGN KEY (predio)
        REFERENCES tbl_predio (sigla)
);  


DROP view IF EXISTS v_salas_com_grande_capacidade;
CREATE VIEW view_salas_com_grande_capacidade AS
SELECT *
FROM tbl_sala
WHERE capacidade_de_alunos >= 50;


DROP view IF EXISTS view_salas_com_media_capacidade;
CREATE VIEW view_salas_com_media_capacidade AS
SELECT *
FROM tbl_sala
WHERE capacidade_de_alunos > 30 AND capacidade_de_alunos < 50;


DROP view IF EXISTS view_salas_com_pequena_capacidade;
CREATE VIEW view_salas_com_pequena_capacidade AS
SELECT *
FROM tbl_sala
WHERE capacidade_de_alunos <= 30;


INSERT INTO tbl_sala (numero,predio,tipo,recursos,caracteristicas,capacidade_de_alunos) VALUES
(297,"at-1","aula teorica","55 carteiras. 1 projetor.","sala grande e com ar condicionado",55),
(200,"at-1","aula teorica","70 carteiras.","sala grande e com ventilador",70); 
 

-- ----------------------------------------------------------------------------
-- Alocação
-- Criado por: Grupo 5A

DROP TABLE IF EXISTS tbl_alocacao;
CREATE TABLE IF NOT EXISTS tbl_Alocacao (
    semestre INT(11) NOT NULL,
    ano INT(11) NOT NULL,
    codigoTurma VARCHAR(1) NOT NULL,
    codigoDisciplina VARCHAR(20) NOT NULL,
    numeroSala INT NOT NULL,
    siglaPredio VARCHAR(5) NOT NULL,
    CONSTRAINT alocacao_fk_turma FOREIGN KEY (codigoDisciplina , codigoTurma , semestre , ano)
        REFERENCES tbl_Turma (codigoDisciplina , codigoTurma , semestre , ano),
    CONSTRAINT alocacao_fk_sala FOREIGN KEY (numeroSala , siglaPredio)
        REFERENCES tbl_sala (numero , predio),
    PRIMARY KEY (semestre , ano , codigoTurma , codigoDisciplina , numeroSala , siglaPredio)
);


-- ----------------------------------------------------------------------------
-- Inscrição
-- Criado por: Grupo 5A

DROP TABLE IF EXISTS tbl_inscricao;
CREATE TABLE IF NOT EXISTS tbl_Inscricao (
    ra INT(6) NOT NULL,
    semestreTurma INT(1) NOT NULL,
    anoTurma INT(4) NOT NULL,
    codigoTurma VARCHAR(1) NOT NULL,
    codigoDisciplina VARCHAR(20) NOT NULL,
    media FLOAT,
    frequencia INT(3),
    resultado VARCHAR(20),
    prioridadeDeInscricao INT,
    statusDeSolicitacao VARCHAR(20),
    CONSTRAINT inscricao_fk_estudante FOREIGN KEY (ra)
        REFERENCES tbl_Estudante (ra),
    CONSTRAINT inscricao_fk_turma FOREIGN KEY (codigoDisciplina , codigoTurma , semestreTurma , anoTurma)
        REFERENCES tbl_Turma (codigoDisciplina , codigoTurma , semestre , ano),
    CONSTRAINT inscricao_pk PRIMARY KEY (ra , semestreTurma , anoTurma , codigoTurma , codigoDisciplina)
);


-- ----------------------------------------------------------------------------
-- Atividade
-- Criado por: Grupo 6A

DROP TABLE IF EXISTS tbl_atividade;
CREATE TABLE IF NOT EXISTS tbl_atividade (
    dataInicio DATE,
    dataTermino DATE,
    descricao VARCHAR(255) NOT NULL,
    responsaveis VARCHAR(50) NOT NULL,
    tipo INT(5) NOT NULL,
    CONSTRAINT pk_atividadePeriodo PRIMARY KEY (dataInicio , dataTermino)
);

INSERT INTO tbl_atividade VALUES
('2016-05-24','2016-06-24', 'Paralisação temporária', 'DCE', 20),
('2016-02-29','2016-04-14', 'Período para substituição do conceito R', 'Docentes', 5),
('2016-02-29','2016-05-09', 'Período para cancelamento de disciplina', 'Estudantes', 10),
('2016-07-22','2016-07-25', 'Período de inscricao nas disciplinas para o segundo período letivo', 'Estudantes', 10),
('2016-10-24','2016-10-28', 'Jornada Científica', 'Estudantes', 10);


-- ----------------------------------------------------------------------------
-- Proposta Intermediária
-- Criado por: Grupo 6A

DROP TABLE IF EXISTS tbl_proposta_int;
CREATE TABLE IF NOT EXISTS tbl_proposta_int (
    ano INT NOT NULL,
    semestre INT NOT NULL,
    data_submissao DATE,
    CONSTRAINT pk_proposta_int PRIMARY KEY (ano , semestre),
    CONSTRAINT prop_int_fk_calendario FOREIGN KEY (ano , semestre)
        REFERENCES tbl_calendario (ano , semestre)
);

INSERT INTO tbl_proposta_int(ano, semestre, data_submissao) VALUES
(2016, 1, '2016-07-30'), 
(2016, 2, '2016-12-15'), 
(2017, 1, '2017-07-30'), 
(2017, 2, '2017-12-15'), 
(2018, 1, '2018-07-30');


-- ----------------------------------------------------------------------------
-- [REVISAR] Plano de Ensino
-- Criado por: André Rocha (4A)

/*
DROP TABLE IF EXISTS  tbl_plano_de_ensino;
CREATE TABLE tbl_plano_de_ensino (
    procedimento_avaliacao VARCHAR(200) NOT NULL,
    recursos VARCHAR(200) NOT NULL,
    bibliografia_basica VARCHAR(200) NOT NULL,
    bibliografia_complementar VARCHAR(200),
    objetivos_gerais VARCHAR(200),
    objetivos_especificos VARCHAR(200) NOT NULL,
    estrategia_ensino VARCHAR(200) NOT NULL,
    atividades_alunos VARCHAR(200) NOT NULL,
    observacoes VARCHAR(200) NOT NULL,
    atividades_ead VARCHAR(200),
    data DATE NOT NULL,
    situacao INT(1) NOT NULL,
    duracao_topicos VARCHAR(1000) NOT NULL,
    pescd VARCHAR(200) NOT NULL,
    distribuicao_horas VARCHAR(200) NOT NULL,
    turma VARCHAR(100) NOT NULL,
    professor VARCHAR(100) NOT NULL,
    ementa VARCHAR(200),
    requisitos VARCHAR(100),
    idDocente CHAR(11) NOT NULL,
    codigoTurma CHAR(5) NOT NULL,
    CONSTRAINT idDocente_fk FOREIGN KEY (idDocente)
        REFERENCES tbl_docente (pessoa),
    CONSTRAINT codigoTurma_fk FOREIGN KEY (codigoTurma)
        REFERENCES tbl_codigo_turma (id),
    CONSTRAINT planoEnsino_pk PRIMARY KEY (idDocente , codigoTurma)
);
*/

-- ----------------------------------------------------------------------------
-- [REVISAR] Código Turma
-- Criado por: André Rocha (4A)

/*
DROP TABLE IF EXISTS tbl_codigo_turma;
CREATE TABLE tbl_codigo_turma (
    id CHAR(5) NOT NULL,
    codigoTurma VARCHAR(1) NOT NULL,
    codigoDisciplina VARCHAR(20) NOT NULL,
    semestre INT(11) NOT NULL,
    ano INT(11) NOT NULL,
    CONSTRAINT codigoTurma_fk FOREIGN KEY (codigoTurma , codigoDisciplina , semestre , ano)
        REFERENCES tbl_Turma (codigoTurma , codigoDisciplina , semestre , ano),
    CONSTRAINT codigoTurma_pk PRIMARY KEY (id)
);
*/

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- Estudante Views
DROP view IF EXISTS v_estudante;
CREATE OR replace VIEW v_estudante
AS
  SELECT pessoa_id,
         tbl_estudante.ra,
         sigla,
         ano_ingresso,
         ira
  FROM   tbl_estudante,
         tbl_matricula
  WHERE  tbl_estudante.ra = tbl_matricula.ra
  GROUP  BY pessoa_id; 
