CREATE TABLE alu
(
legajo INT NOT NULL,
nombre CHAR(30),
PRIMARY KEY(legajo)
);

CREATE TABLE materia
(
codigo INT NOT NULL,
nombre CHAR(30),
PRIMARY KEY(codigo)
);

CREATE TABLE profesor
(
legProf INT NOT NULL,
nombre CHAR(30),
antiguedad DATE,
PRIMARY KEY(legProf)
);

CREATE TABLE examen
(
legajo INT NOT NULL,
legProf INT NOT NULL,
nota DECIMAL(10,1),
fecha DATE NOT NULL,
codigo INT NOT NULL,
nroActa INT NOT NULL,
PRIMARY KEY(legajo,legProf,fecha,codigo),
FOREIGN KEY(legajo) REFERENCES alu ON DELETE CASCADE,
FOREIGN KEY(legProf) REFERENCES profesor ON DELETE CASCADE,
FOREIGN KEY(codigo) REFERENCES materia ON DELETE CASCADE
);