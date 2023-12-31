-- 1 )
DROP DATABASE IF EXISTS TRABALHO;
CREATE DATABASE IF NOT EXISTS TRABALHO;

 -- 2 )

DROP TABLE IF EXISTS TRABALHO.ALUNO;
CREATE TABLE IF NOT EXISTS TRABALHO.ALUNO(
    RA          INT             NOT NULL AUTO_INCREMENT,
    NOME_ALUNO  VARCHAR(250)    NOT NULL,
    SEXO_ALUNO  VARCHAR(1)      NOT NULL COMMENT "F - FEMININO / M - MASCULINO",
    CONSTRAINT PK_ALUNO PRIMARY KEY (RA)
)ENGINE=INNODB;

DROP TABLE IF EXISTS TRABALHO.TURMA;
CREATE TABLE IF NOT EXISTS TRABALHO.TURMA(
    NUM_TURMA           INT  NOT NULL AUTO_INCREMENT,
    DTA_INICIO_AULAS    DATE NOT NULL,
    DTA_FIM_AULAS       DATE NOT NULL,
    CONSTRAINT PK_TURMA PRIMARY KEY (NUM_TURMA)
)ENGINE=INNODB;

DROP TABLE IF EXISTS TRABALHO.MATRICULA;
CREATE TABLE IF NOT EXISTS TRABALHO.MATRICULA(
    NUM_MATRICULA               INT     NOT NULL AUTO_INCREMENT,
    DTA_MATRICULA               DATE    NOT NULL,
    DTA_CANCELAMENTO_MATRICULA  DATE,
    RA                          INT     NOT NULL,
    NUM_TURMA                   INT     NOT NULL,
    CONSTRAINT PK_MATRICULA PRIMARY KEY (NUM_MATRICULA),
    CONSTRAINT FK_MATRICULA_2_RA
        FOREIGN KEY (RA)
            REFERENCES TRABALHO.ALUNO (RA),
    CONSTRAINT FK_MATRICULA_2_TURMA
        FOREIGN KEY (NUM_TURMA)
            REFERENCES TRABALHO.TURMA (NUM_TURMA)
)ENGINE=INNODB;


DROP TABLE IF EXISTS TRABALHO.DISCIPLINA;
CREATE TABLE IF NOT EXISTS TRABALHO.DISCIPLINA(
    COD_DISCIPLINA  INT             NOT NULL AUTO_INCREMENT,
    NOM_DISCIPLINA  VARCHAR(250)    NOT NULL,
    CARGA_HORARIA   INT             NOT NULL,
    CONSTRAINT PK_DISCIPLINA PRIMARY KEY (COD_DISCIPLINA)
)ENGINE=INNODB;

DROP TABLE IF EXISTS TRABALHO.PROFESSOR;
CREATE TABLE IF NOT EXISTS TRABALHO.PROFESSOR(
    MATRICULA       INT             NOT NULL AUTO_INCREMENT,
    NOME_PROFESSOR  VARCHAR(250)    NOT NULL,
    TITULACAO       VARCHAR(100)    NOT NULL,
    SEXO_PROFESSOR  VARCHAR(1)      NOT NULL COMMENT "F - FEMININO / M - MASCULINO",
    CONSTRAINT PK_PROFESSOR PRIMARY KEY (MATRICULA)
)ENGINE=INNODB;

DROP TABLE IF EXISTS TRABALHO.DISCIPLINA_OFERECIDA;
CREATE TABLE IF NOT EXISTS TRABALHO.DISCIPLINA_OFERECIDA(
    NUM_DISCIPLINA_OFERECIDA    INT         NOT NULL AUTO_INCREMENT,
    SALA                        VARCHAR(10) NOT NULL,
    BLOCO                       VARCHAR(10) NOT NULL,
    DIA_SEMANA                  INT         NOT NULL COMMENT "DEVE SER ENTRE 1-DOMINGO E 7-SABADO",
    HOR_INICIO                  TIME        NOT NULL,
    HOR_FIM                     TIME        NOT NULL,
    MATRICULA                   INT         NOT NULL,
    NUM_TURMA                   INT         NOT NULL,
    COD_DISCIPLINA              INT         NOT NULL,
    CONSTRAINT PK_DISCIPLINA_OFERECIDA PRIMARY KEY (NUM_DISCIPLINA_OFERECIDA),
    CONSTRAINT FK_DISCIPLINA_OFERECIDA_2_TURMA
        FOREIGN KEY (NUM_TURMA)
            REFERENCES TRABALHO.TURMA (NUM_TURMA),
    CONSTRAINT FK_DISCIPLINA_OFERECIDA_2_DISCIPLINA
        FOREIGN KEY (COD_DISCIPLINA)
            REFERENCES TRABALHO.DISCIPLINA (COD_DISCIPLINA),
    CONSTRAINT FK_DISCIPLINA_OFERECIDA_2_PROFESSOR
        FOREIGN KEY (MATRICULA)
            REFERENCES TRABALHO.PROFESSOR (MATRICULA)
)ENGINE=INNODB;



DROP TABLE IF EXISTS TRABALHO.AVALIACAO;
CREATE TABLE IF NOT EXISTS TRABALHO.AVALIACAO(
    SEQ_AVALIACAO_ALUNO         INT             NOT NULL,
    NOTA_A2                     DECIMAL(5,2)    NOT NULL COMMENT "DEVE ESTAR ENTRE 0 E 5",
    NOTA_A1                     DECIMAL(5,2)    NOT NULL COMMENT "DEVE ESTAR ENTRE 0 E 5",
    NOTA_AF                     DECIMAL(5,2)    COMMENT "DEVE ESTAR ENTRE 0 E 5",
    RA                          INT             NOT NULL,
    NUM_DISCIPLINA_OFERECIDA    INT             NOT NULL,
    CONSTRAINT PK_AVALIACAO PRIMARY KEY (SEQ_AVALIACAO_ALUNO),
    CONSTRAINT FK_AVALIACAO_2_ALUNO
        FOREIGN KEY (RA)
            REFERENCES TRABALHO.ALUNO (RA),
    CONSTRAINT FK_AVALIACAO_2_DISCIPLINA_OFERECIDA
        FOREIGN KEY (NUM_DISCIPLINA_OFERECIDA)
            REFERENCES TRABALHO.DISCIPLINA_OFERECIDA (NUM_DISCIPLINA_OFERECIDA)
)ENGINE=INNODB;

-- 3)
-- 3.1)
USE trabalho;

-- 3.1.1)
INSERT INTO TURMA (NUM_TURMA, DTA_INICIO_AULAS, DTA_FIM_AULAS)
VALUES
	(1, '2022-08-01', '2022-12-20'),
	(2, '2023-02-13', '2023-06-30');

-- 3.1.2)
INSERT INTO ALUNO (RA, NOME_ALUNO, SEXO_ALUNO)
VALUES
	(100001, 'Aline Machado Cardoso', 'F'),
	(100002, 'André da Silva Campos', 'M'),
	(100003, 'Beatriz Almeida Carvalho', 'F'),
	(100004, 'Bartolomeu Severos', 'M'),
	(100005, 'Celina Santos dos Reis', 'F'),
	(100006, 'Cauan Yan de Almeida', 'M'),
	(100007, 'Diana Mariana Castro', 'F'),
	(100008, 'Douglas Pereira Martins', 'M'),
	(100009, 'Edvalda Sabrina da Cruz', 'F'),
	(100010, 'Edvan Barros dos Santos', 'M'),
	(100011, 'Fabiana Araújo Fernandes', 'F'),
	(100012, 'Fernando dos Anjos', 'M'),
	(100013, 'Gabriela Marques de Outorga', 'F'),
	(100014, 'Geraldo Matos da Silva', 'M'),
	(100015, 'Isabela Cristina Gaudino', 'F'),
	(100016, 'Igor de Lima Torres', 'M'),
	(100017, 'Jaqueline Maria Sanches', 'F'),
	(100018, 'José de Andrade Belinarti', 'M'),
	(100019, 'Kelly Roberta Santoro', 'F'),
	(100020, 'Kelvin Marcos de Santana', 'M');
	
-- 3.1.3)
INSERT INTO PROFESSOR (MATRICULA, NOME_PROFESSOR, TITULACAO, SEXO_PROFESSOR)
VALUES
	(201, 'Alexandra dos Santos Marques', 'Mestre', 'F'),
	(202, 'Vanderlei Wagner de Carvalho', 'Mestre', 'M'),
	(203, 'Eliana Sabino de Araújo', 'Doutora', 'F'),
	(204, 'Marcos Ferreira da Silva', 'Doutor', 'M');
	
-- 3.1.4)
INSERT INTO DISCIPLINA (COD_DISCIPLINA, NOM_DISCIPLINA, CARGA_HORARIA)
VALUES
	(3001, 'Modelagem de Negócios e Requisitos', 60),
	(3002, 'Programação de Computadores', 80),
	(3003, 'Programação Web', 60),
	(3004, 'Banco de Dados', 80);

-- 3.2)	
-- 3.2.1) 
INSERT INTO MATRICULA (NUM_MATRICULA, DTA_MATRICULA, DTA_CANCELAMENTO_MATRICULA, RA, NUM_TURMA)
VALUES 
	(901, '2022-07-15', NULL, 100001, 1),
	(902, '2022-07-15', NULL, 100002, 1),
	(903, '2022-07-15', NULL, 100003, 1),
	(904, '2022-07-15', NULL, 100004, 1),
	(905, '2022-07-15', NULL, 100005, 1),
	(906, '2022-07-15', NULL, 100006, 1),
	(907, '2022-07-15', NULL, 100007, 1),
	(908, '2022-07-15', NULL, 100008, 1),
	(909, '2022-07-15', NULL, 100009, 1),
	(910, '2022-07-15', NULL, 100010, 1),
	(911, '2022-07-16', NULL, 100011, 2),
	(912, '2022-07-16', NULL, 100012, 2),
	(913, '2022-07-16', NULL, 100013, 2),
	(914, '2022-07-16', NULL, 100014, 2),
	(915, '2022-07-16', NULL, 100015, 2),
	(916, '2022-07-16', NULL, 100016, 2), 
	(917, '2022-07-16', NULL, 100017, 2),
	(918, '2022-07-16', NULL, 100018, 2),
	(919, '2022-07-16', NULL, 100019, 2), 
	(920, '2022-07-16', NULL, 100020, 2);
	
-- 3.2.2)
INSERT INTO DISCIPLINA_OFERECIDA (NUM_DISCIPLINA_OFERECIDA, SALA, BLOCO, DIA_SEMANA, HOR_INICIO, HOR_FIM, MATRICULA, NUM_TURMA, COD_DISCIPLINA)
VALUES
	(1, 'A301', 'A', 2, '19:10', '21:50', 201, 1, 3001), 
	(2, 'Lab Inf. 3', 'B', 3, '19:10', '21:50', 202, 1, 3002),
	(3, 'Lab Inf. 3', 'B', 4, '19:10', '21:50', 203, 1, 3003),
	(4, 'Lab Inf. 3', 'B', 5, '19:10', '21:50', 204, 1, 3004),
	(5, 'Lab Inf. 4', 'B', 6, '19:10', '21:50', 201, 2, 3002),
	(6, 'A302', 'A', 3, '19:10', '21:50', 202, 2, 3001), 
	(7, 'Lab Inf. 4', 'B', 4, '19:10', '21:50', 203, 2, 3004),
	(8, 'Lab Inf. 4', 'B', 5, '19:10', '21:50', 204, 2, 3003);
	
-- 3.2.3) 
INSERT INTO AVALIACAO (SEQ_AVALIACAO_ALUNO, NOTA_A2, NOTA_A1, NOTA_AF, RA, NUM_DISCIPLINA_OFERECIDA)
VALUES 
	(1, 0, 0, NULL, 100001, 1),
	(2, 0, 0, NULL, 100001, 2),
	(3, 0, 0, NULL, 100001, 3),
	(4, 0, 0, NULL, 100001, 4),
	(5, 5, 5, NULL, 100002, 1),
	(6, 5, 4, NULL, 100002, 2),
	(7, 4, 5, NULL, 100002, 3),
	(8, 5, 5, NULL, 100002, 4),
	(9, 3, 3, NULL, 100003, 1),
	(10, 4, 2, NULL, 100003, 2),
	(11, 3, 5, NULL, 100003, 3),
	(12, 5, 2, NULL, 100003, 4),
	(13, 5, 5, NULL, 100004, 1),
	(14, 4, 3, NULL, 100004, 2),
	(15, 3, 3, NULL, 100004, 3),
	(16, 4, 4, NULL, 100004, 4),
	(17, 2, 5, NULL, 100005, 1),
	(18, 3, 4, NULL, 100005, 2),
	(19, 4, 2, NULL, 100005, 3),
	(20, 5, 2, NULL, 100005, 4),
	(21, 2, 2, 4, 100006, 1),
	(22, 1, 3, 5, 100006, 2),
	(23, 3, 2, 3, 100006, 3),
	(24, 1, 1, 5, 100006, 4),
	(25, 3, 2, 1, 100007, 1),
	(26, 1, 4, 1, 100007, 2),
	(27, 1, 2, 2, 100007, 3),
	(28, 1, 3, 1, 100007, 4),
	(29, 2, 3, 2, 100008, 1),
	(30, 1, 1, 3, 100008, 2),
	(31, 3, 1, 2, 100008, 3),
	(32, 2, 1, 3, 100008, 4),
	(33, 4, 1, 1, 100009, 1),
	(34, 3, 1, 2, 100009, 2),
	(35, 1, 2, 2, 100009, 3),
	(36, 3, 1, 1, 100009, 4),
	(37, 3, 1, 2, 100010, 1),
	(38, 2, 1, 3, 100010, 2),
	(39, 1, 1, 4, 100010, 3),
	(40, 1, 0, 1, 100010, 4);
	
	
-- 3.2.4)
INSERT INTO AVALIACAO (SEQ_AVALIACAO_ALUNO, NOTA_A2, NOTA_A1, NOTA_AF, RA, NUM_DISCIPLINA_OFERECIDA)
VALUES 
	(41, 0, 0, NULL, 100011, 1),
	(42, 0, 0, NULL, 100011, 2),
	(43, 0, 0, NULL, 100011, 3),
	(44, 0, 0, NULL, 100011, 4),
	(45, 3, 3, NULL, 100012, 1),
	(46, 2, 5, NULL, 100012, 2),
	(47, 1, 5, NULL, 100012, 3),
	(48, 4, 2, NULL, 100012, 4),
	(49, 4, 4, NULL, 100013, 1),
	(50, 5, 3, NULL, 100013, 2),
	(51, 4, 2, NULL, 100013, 3),
	(52, 4, 5, NULL, 100013, 4),
	(53, 1, 5, NULL, 100014, 1),
	(54, 3, 5, NULL, 100014, 2),
	(55, 5, 4, NULL, 100014, 3),
	(56, 2, 5, NULL, 100014, 4),
	(57, 5, 2, NULL, 100015, 1),
	(58, 2, 4, NULL, 100015, 2),
	(59, 5, 1, NULL, 100015, 3),
	(60, 4, 3, NULL, 100015, 4),
	(61, 1, 1, NULL, 100016, 1),
	(62, 0, 2, NULL, 100016, 2),
	(63, 2, 3, NULL, 100016, 3),
	(64, 0, 4, NULL, 100016, 4),
	(65, 2, 1, NULL, 100017, 1),
	(66, 1, 3, NULL, 100017, 2),
	(67, 3, 2, NULL, 100017, 3),
	(68, 0, 4, NULL, 100017, 4),
	(69, 1, 1, NULL, 100018, 1),
	(70, 4, 0, NULL, 100018, 2),
	(71, 2, 2, NULL, 100018, 3),
	(72, 1, 3, NULL, 100018, 4),
	(73, 2, 3, NULL, 100019, 1),
	(74, 4, 1, NULL, 100019, 2),
	(75, 3, 1, NULL, 100019, 3),
	(76, 2, 2, NULL, 100019, 4),
	(77, 2, 0, NULL, 100020, 1),
	(78, 1, 3, NULL, 100020, 2),
	(79, 3, 2, NULL, 100020, 3),
	(80, 4, 1, NULL, 100020, 4);

-- 4)
-- 4.1 )
SELECT 
    P.NOME_PROFESSOR AS 'PROFESSOR', 
    P.TITULACAO AS 'TITULO' , 
    D.NOM_DISCIPLINA AS 'DISCIPLINA', 
    T.DTA_INICIO_AULAS AS 'INÍCIO AULAS', 
    T.DTA_FIM_AULAS AS 'FIM AULAS', 
    COUNT(M.RA) AS 'QTDE ALUNOS', 
    DO.SALA AS 'SALA', 
    DO.BLOCO AS 'BLOCO', 
    CASE 
        WHEN DO.DIA_SEMANA = 1 THEN 'Domingo' 
        WHEN DO.DIA_SEMANA = 2 THEN 'Segunda-feira' 
        WHEN DO.DIA_SEMANA = 3 THEN 'Terça-feira' 
        WHEN DO.DIA_SEMANA = 4 THEN 'Quarta-feira' 
        WHEN DO.DIA_SEMANA = 5 THEN 'Quinta-feira' 
        WHEN DO.DIA_SEMANA = 6 THEN 'Sexta-feira' 
        WHEN DO.DIA_SEMANA = 7 THEN 'Sábado' 
    END AS' DIA SEMANA', 
    DO.HOR_INICIO AS 'HORÁRIO INÍCIO', 
    DO.HOR_FIM AS 'HORÁRIO FIM' 
FROM 
    TRABALHO.PROFESSOR P 
    JOIN TRABALHO.DISCIPLINA_OFERECIDA DO ON P.MATRICULA = DO.MATRICULA 
    JOIN TRABALHO.TURMA T ON T.NUM_TURMA = DO.NUM_TURMA 
    JOIN TRABALHO.DISCIPLINA D ON D.COD_DISCIPLINA = DO.COD_DISCIPLINA 
    JOIN TRABALHO.MATRICULA M ON M.NUM_TURMA = DO.NUM_TURMA 
	
GROUP BY 
    P.NOME_PROFESSOR, 
    P.TITULACAO, 
    D.NOM_DISCIPLINA, 
    T.DTA_INICIO_AULAS, 
    T.DTA_FIM_AULAS, 
    DO.SALA, 
    DO.BLOCO, 
    DO.DIA_SEMANA, 
    DO.HOR_INICIO, 
    DO.HOR_FIM;

-- 4.2 )
SELECT 
    d.NOM_DISCIPLINA AS 'DISCIPLINA',
    p.NOME_PROFESSOR AS 'PROFESSOR',
    do.BLOCO, 
    do.SALA,
    t.NUM_TURMA,
    CASE 
        WHEN do.DIA_SEMANA = 1 THEN 'Domingo'
        WHEN do.DIA_SEMANA = 2 THEN 'Segunda-feira'
        WHEN do.DIA_SEMANA = 3 THEN 'Terça-feira'
        WHEN do.DIA_SEMANA = 4 THEN 'Quarta-feira'
        WHEN do.DIA_SEMANA = 5 THEN 'Quinta-feira'
        WHEN do.DIA_SEMANA = 6 THEN 'Sexta-feira'
        WHEN do.DIA_SEMANA = 7 THEN 'Sábado'
    END AS 'DIA SEMANA',
    do.HOR_INICIO AS 'HORÁRIO DE INÍCIO',
    do.HOR_FIM AS 'HORÁRIO DE FIM',
    al.RA AS 'RA',
    al.NOME_ALUNO AS 'NOME'
    
FROM 
    TRABALHO.DISCIPLINA_OFERECIDA do
     INNER JOIN
     TRABALHO.PROFESSOR p ON p.MATRICULA = do.MATRICULA
     INNER JOIN 
     TRABALHO.TURMA t ON t.NUM_TURMA = do.NUM_TURMA 
     INNER JOIN 
     TRABALHO.DISCIPLINA d ON d.COD_DISCIPLINA = do.COD_DISCIPLINA
     INNER JOIN
     TRABALHO.MATRICULA m ON m.NUM_TURMA = t.NUM_TURMA
     INNER JOIN 
     TRABALHO.ALUNO al ON al.RA = m.RA
	 WHERE 
     t.NUM_TURMA IS NOT NULL
	 
ORDER BY 
    d.NOM_DISCIPLINA,
    do.SALA,
    do.BLOCO,
    do.DIA_SEMANA,
    do.HOR_INICIO,
    al.NOME_ALUNO;
    
  -- 4.3 )
SELECT 
d.NOM_DISCIPLINA, p.NOME_PROFESSOR, dof.SALA, dof.BLOCO,
    CASE dof.DIA_SEMANA
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-feira'
        WHEN 3 THEN 'Terça-feira'
        WHEN 4 THEN 'Quarta-feira'
        WHEN 5 THEN 'Quinta-feira'
        WHEN 6 THEN 'Sexta-feira'
        ELSE 'Sábado'
    END AS DIA_SEMANA, 
	#(a.NOTA_A2 + a.NOTA_A1)  <= 5.74 AS 'REPROVADO TESTE',
    #IF (a.RA > 100010 AND a.NOTA_AF IS NULL, 1, 0) = 1 AS 'AF(PENDENTE TESTE)',
    #IF (a.NOTA_A2 > a.NOTA_A1, a.NOTA_A2 + a.NOTA_AF, a.NOTA_A1 + a.NOTA_AF) AS 'NOTA FINAL TESTE APROVADO',
    TIME_FORMAT(dof.HOR_INICIO, '%H:%i') AS HOR_INICIO,
    TIME_FORMAT(dof.HOR_FIM, '%H:%i') AS HOR_FIM,
    a.RA, al.NOME_ALUNO, a.NOTA_A2, a.NOTA_A1, a.NOTA_AF,
   # IF(a.NOTA_A2 > a.NOTA_A1, a.NOTA_A2 + a.NOTA_AF, a.NOTA_A1 + a.NOTA_AF) AS 'NOTA FINAL',
    
    CASE
        WHEN (a.NOTA_A2 + a.NOTA_A1)  >= 5.75 THEN 'APROVADO'
        WHEN IF(a.NOTA_A2 > a.NOTA_A1, a.NOTA_A2 + a.NOTA_AF, a.NOTA_A1 + a.NOTA_AF) >= 5.75  THEN 'AF(APROVADO)'
        WHEN IF (a.RA > 100010 AND a.NOTA_AF IS NULL AND (a.NOTA_A2 + a.NOTA_A1) >= 1 , 1, 0) = 1 THEN 'AF(PENDENTE)' 
        WHEN IF(a.NOTA_A2 < a.NOTA_A1, a.NOTA_A1 + a.NOTA_AF, a.NOTA_A1 + a.NOTA_AF) <= 5.74  THEN 'AF(REPROVADO)'
		WHEN (a.NOTA_A2 + a.NOTA_A1)  <= 5.74 THEN 'REPROVADO'
        ELSE 'REPROVADO FINAL'
    END AS SITUACAO_ALUNO
FROM TRABALHO.TURMA t
INNER JOIN
TRABALHO.DISCIPLINA_OFERECIDA dof ON dof.NUM_TURMA = t.NUM_TURMA
INNER JOIN 
TRABALHO.DISCIPLINA d ON d.COD_DISCIPLINA = dof.COD_DISCIPLINA
INNER JOIN
TRABALHO.PROFESSOR p ON p.MATRICULA = dof.MATRICULA
INNER JOIN
TRABALHO.AVALIACAO a ON a.NUM_DISCIPLINA_OFERECIDA = dof.NUM_DISCIPLINA_OFERECIDA
INNER JOIN 
TRABALHO.MATRICULA m ON m.RA = a.RA 
INNER JOIN 
TRABALHO.ALUNO al ON al.RA = m.RA
WHERE t.NUM_TURMA IS NOT NULL AND m.NUM_TURMA = 1;



-- 4.4)
SELECT
  D.NOM_DISCIPLINA AS 'DISCIPLINA',
  P.NOME_PROFESSOR AS 'PROFESSOR',
  P.TITULACAO AS 'TITULO',
  DO.BLOCO,
  DO.SALA,
  DO.HOR_INICIO AS 'HORÁRIO INÍCIO',
  DO.HOR_FIM AS 'HORÁRIO FIM',
  COUNT(DISTINCT m.RA) AS 'MATRICULADOS',
  SUM(CASE WHEN M.DTA_CANCELAMENTO_MATRICULA IS NOT NULL THEN 1 ELSE 0 END) AS 'MATRÍCULAS CANCELADAS',
  COUNT(DISTINCT CASE WHEN (a.NOTA_A2 + a.NOTA_A1) >= 5.75 AND a.NOTA_AF IS NULL THEN m.RA END)  AS 'APROVADOS DIRETO',
  CONCAT(ROUND((COUNT(DISTINCT CASE WHEN a.NOTA_A2 + a.NOTA_A1 >= 5.75 THEN m.RA END) * 100 / COUNT(DISTINCT m.RA)), 2), '%') AS '% APROVADOS DIRETO',
  COUNT(DISTINCT CASE WHEN (a.NOTA_A2 + a.NOTA_A1) <= 0.74 AND a.NOTA_AF IS NULL  THEN m.RA END) AS 'REPROVADOS DIRETO',
  CONCAT(ROUND((COUNT(DISTINCT CASE WHEN (a.NOTA_A2 + a.NOTA_A1) <= 0.74  AND a.NOTA_AF IS NULL THEN m.RA END) * 100 / COUNT(DISTINCT m.RA)), 2), '%') AS '% REPROVADOS DIRETO',
  COUNT(DISTINCT CASE WHEN a.NOTA_A2 + a.NOTA_A1 <= 5.74 AND a.NOTA_A2 + a.NOTA_A1 >= 0.75 THEN m.RA END) AS 'ALUNOS AF',
  CONCAT(ROUND((COUNT(DISTINCT CASE WHEN a.NOTA_A2 + a.NOTA_A1 <= 5.74 AND a.NOTA_A2 + a.NOTA_A1 >= 0.75 THEN m.RA END) * 100 / COUNT(DISTINCT m.RA)), 2), '%') AS '% ALUNOS AF',
  COUNT(DISTINCT CASE WHEN IF(a.NOTA_A2 > a.NOTA_A1, a.NOTA_A2 + a.NOTA_AF, a.NOTA_A1 + a.NOTA_AF) >= 5.75 THEN m.RA END) AS 'APROVADOS AF',
  CONCAT(ROUND((COUNT(DISTINCT CASE WHEN IF(a.NOTA_A2 > a.NOTA_A1, a.NOTA_A2 + a.NOTA_AF, a.NOTA_A1 + a.NOTA_AF) >= 5.75 THEN m.RA END) * 100 / COUNT(DISTINCT m.RA )), 2), '%') AS '% APROVADOS AF',
  COUNT(DISTINCT CASE  WHEN IF(a.NOTA_A2 < a.NOTA_A1, a.NOTA_A1 + a.NOTA_AF, a.NOTA_A2 + a.NOTA_AF) <= 5.74 THEN m.RA END) AS 'REPROVADOS AF',
  CONCAT(ROUND((COUNT(DISTINCT CASE WHEN IF(a.NOTA_A2 < a.NOTA_A1, a.NOTA_A1 + a.NOTA_AF, a.NOTA_A2 + a.NOTA_AF) <= 5.74 THEN m.RA END) * 100 / COUNT(DISTINCT m.RA)), 2), '%') AS '% REPROVADOS AF'

FROM
   TRABALHO.DISCIPLINA_OFERECIDA DO
INNER JOIN 
TRABALHO.DISCIPLINA d ON d.COD_DISCIPLINA = DO.COD_DISCIPLINA
INNER JOIN
TRABALHO.PROFESSOR p ON p.MATRICULA = DO.MATRICULA
INNER JOIN
TRABALHO.TURMA t ON t.NUM_TURMA = DO.NUM_TURMA
LEFT JOIN
TRABALHO.AVALIACAO a ON a.NUM_DISCIPLINA_OFERECIDA = DO.NUM_DISCIPLINA_OFERECIDA
INNER JOIN 
TRABALHO.MATRICULA m ON m.RA = a.RA  
INNER JOIN 
TRABALHO.ALUNO al ON al.RA = m.RA
WHERE
  M.NUM_TURMA IN (1, 2)
GROUP BY
  D.NOM_DISCIPLINA,
  P.NOME_PROFESSOR,
  P.TITULACAO,
  DO.SALA,
  DO.BLOCO,
  DO.HOR_INICIO,
  DO.HOR_FIM
ORDER BY
  D.NOM_DISCIPLINA,
  P.NOME_PROFESSOR,
  DO.HOR_INICIO,
  DO.HOR_FIM;
