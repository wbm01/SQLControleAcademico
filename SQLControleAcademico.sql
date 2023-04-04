CREATE DATABASE ControleAcademico

CREATE TABLE Aluno(
RA INT NOT NULL,
Nome VARCHAR(50) NOT NULL,

CONSTRAINT PK_Aluno PRIMARY KEY(RA)
);

CREATE TABLE Matricula(
    ID INT IDENTITY (1,1), --Identity é um auto incrementador e o 1,1 diz que vai começar do 1 e irá de 1 em 1
    RA_Matricula INT NOT NULL,
    Ano INT NOT NULL,
    Semestre INT NOT NULL,

    CONSTRAINT PK_Matricula PRIMARY KEY(ID),
    CONSTRAINT FK_Matricula FOREIGN KEY(RA_Matricula) REFERENCES Aluno(RA),
    CONSTRAINT UN_Matricula UNIQUE (RA_Matricula, Ano, Semestre)
);

CREATE TABLE Disciplina(
    CodigoDisciplina INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Carga_Horaria INT NOT NULL,

    CONSTRAINT PK_Disciplina PRIMARY KEY(CodigoDisciplina)
);

CREATE TABLE Item_Matricula(
    ID_Item INT NOT NULL,
    Codigo_Item INT NOT NULL,
    Nota1 DECIMAL(4,2), --4 dígitos onde 2 são casas decimais
    Nota2 DECIMAL(4,2),
    Substitutiva DECIMAL(4,2),
    Situacao VARCHAR(50) NOT NULL,
    Falta INT NOT NULL,

    CONSTRAINT PK_Item PRIMARY KEY(ID_Item, Codigo_Item),
    CONSTRAINT FK_Item FOREIGN KEY(ID_Item) REFERENCES Matricula(ID),
    CONSTRAINT FK_ItemCodigo FOREIGN KEY(Codigo_Item) REFERENCES Disciplina(CodigoDisciplina)
);

INSERT INTO ALUNO VALUES(1, 'Willian');

INSERT INTO ALUNO (Nome, RA) VALUES ('Ana Maria', 2);

INSERT INTO ALUNO VALUES(3, 'Felipe');

SELECT*FROM ALUNO

SELECT*FROM DISCIPLINA

INSERT INTO DISCIPLINA VALUES(1, 'Banco de Dados', 80), (2, 'IA', 80), (3, 'SO', 60);

INSERT INTO MATRICULA VALUES(2, 2023, 1);

UPDATE DISCIPLINA SET Nome = 'Inteligência Artificial', Carga_Horaria = 100
WHERE CodigoDisciplina = 2;

--Disciplinas da matrícula de cada aluno
--VER
ALTER TABLE Item_Matricula ALTER COLUMN 
Nota1 DECIMAL(4,2);

ALTER TABLE Item_Matricula ALTER COLUMN 
Nota2 DECIMAL(4,2);

ALTER TABLE Item_Matricula ALTER COLUMN 
Substitutiva DECIMAL(4,2);

INSERT INTO Item_Matricula (ID_Item, Codigo_Item, Falta, Situacao) VALUES (1,3,0, 'Matriculado');

DROP TABLE Item_Matricula

select*from item_matricula;

INSERT INTO Item_Matricula (ID_Item, Codigo_Item, Falta, Situacao) VALUES (2,1,0, 'Matriculado');


SELECT m.ano, m.semestre, m.id, a.nome, d.nome, im.nota1, im.nota2, im.Substitutiva, im.Falta, im.Situacao, im.id_item, d.codigodisciplina,a.ra
FROM Aluno a JOIN Matricula m ON a.ra = m.RA_Matricula
JOIN Item_Matricula im ON m.id = im.id_item
JOIN Disciplina d ON im.codigo_item = d.codigodisciplina
WHERE a.nome = 'Willian'

UPDATE Item_Matricula SET Nota1 = 7, Nota2 = 2, Substitutiva = 8 WHERE Codigo_Item = 1;
UPDATE Item_Matricula SET Nota1 = 5, Nota2 = 0, Substitutiva = 10 WHERE Codigo_Item = 2;
UPDATE Item_Matricula SET Nota1 = 10, Nota2 = 2, Substitutiva = 4 WHERE Codigo_Item = 3;

SELECT m.ano, m.semestre, m.id, a.nome, d.nome, im.nota1, im.nota2, im.Substitutiva,
CASE
WHEN (Substitutiva IS NULL) THEN (NOTA1 + NOTA2)/2
WHEN (Substitutiva > Nota1) AND (Nota1<Nota2) THEN (Substitutiva+Nota2)/2
WHEN (Substitutiva > Nota2) AND (Nota2<Nota1) THEN (Substitutiva+Nota1)/2
END AS 'Media'
FROM Aluno a JOIN Matricula m ON a.ra = m.RA_Matricula
JOIN Item_Matricula im ON m.id = im.id_item
JOIN Disciplina d ON im.codigo_Item = d.codigodisciplina
WHERE a.nome = 'Willian'



 