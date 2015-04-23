CREATE TABLE alumno
(
legajo INT NOT NULL,
nombre CHAR(20),
sexo CHAR,
carrera CHAR(20), 
PRIMARY KEY(legajo)
);

CREATE TABLE curso
(
codigo INT NOT NULL,
nombre CHAR(30),
PRIMARY KEY(codigo)
);

CREATE TABLE inscripcion
(
codigo INT NOT NULL,
legajo INT NOT NULL,
ano INT NOT NULL,
PRIMARY KEY(codigo,legajo,ano)
FOREIGN KEY (codigo) REFERENCES curso ON DELETE CASCADE ON UPDATE RESTRICT
FOREIGN KEY (legajo) REFERENCES alumno ON DELETE CASCADE ON UPDATE RESTRICT
);


INSERT INTO alumno VALUES(30001,'Lopez, Ana','F', 'informatica');
INSERT INTO alumno VALUES(30002,'Garcia, Juan','M','electronica');
INSERT INTO alumno VALUES(30003,'Arevalo, Jose','M','electronica');
INSERT INTO alumno VALUES(30004 'Abrojos, Paula' 'F','informatica');
INSERT INTO alumno VALUES(30005 'Patan, Pamela' 'F','informatica');


INSERT INTO curso VALUES(1,'Base de Datos I');
INSERT INTO curso VALUES(2,'Programacion I');
INSERT INTO curso VALUES(3,'Estructuras y Algoritmos');
INSERT INTO curso VALUES(4, 'Introduccion a la Computacion');
INSERT INTO curso VALUES(5, 'Programacion IV');

INSERT INTO inscripcion VALUES(1,30001,1998);
INSERT INTO inscripcion VALUES(1,30005,1998);
INSERT INTO inscripcion VALUES(2,30001,1998);
INSERT INTO inscripcion VALUES(2,30005,1998);
INSERT INTO inscripcion VALUES(3,30005,1999);
INSERT INTO inscripcion VALUES(4,30001,1999);
INSERT INTO inscripcion VALUES(4,30002,1999);
INSERT INTO inscripcion VALUES(4,30002,1998);
INSERT INTO inscripcion VALUES(4,30005,1998);
INSERT INTO inscripcion VALUES(5,30001,1999);
INSERT INTO inscripcion VALUES(5,30005,1999);
INSERT INTO inscripcion VALUES(5,30005,1998);



commit;

--3.3)
SELECT nombre
FROM alumno
WHERE EXISTS(SELECT * FROM inscripcion WHERE inscripcion.codigo=alumno.codigo AND ano=1998);

SELECT DISTINCT nombre
FROM alumno,inscripcionSELECT nombre
FROM alumno
WHERE legajo=ANY(SELECT legajo FROM inscripcion WHERE ano=1998);
WHERE inscripcion.codigo=alumno.codigo AND ano=1998;


--3.4)
SELECT DISTINCT alumno.legajo
FROM alumno,inscripcion AS i1,inscripcion AS i2
WHERE alumno.legajo=i1.legajo AND alumno.legajo=i2.legajo AND i1.codigo<>i2.codigo;

SELECT legajo
FROM alumno
WHERE EXISTS(SELECT * FROM inscripcion AS i1,inscripcion AS i2 WHERE alumno.legajo=i1.legajo AND alumno.legajo=i2.legajo AND i1.codigo<>i2.codigo);

SELECT legajo
FROM alumno
WHERE legajo=ANY(SELECT i1.legajo FROM inscripcion AS i1,inscripcion AS i2 WHERE WHERE alumno.legajo=i1.legajo AND alumno.legajo=i2.legajo AND i1.codigo<>i2.codigo);

--3.5)
SELECT curso.nombre
FROM curso
WHERE codigo<>ALL(SELECT codigo FROM alumno,inscripcion WHERE alumno.nombre='Lopez, Ana' AND alumno.legajo=inscripcion.legajo );

SELECT curso.nombre
FROM curso
WHERE NOT EXISTS(SELECT * FROM alumno,inscripcion WHERE alumno.nombre='Lopez, Ana' AND alumno.legajo=inscripcion.legajo AND curso.codigo=inscripcion.codigo );


--3.6)
SELECT DISTINCT alumno.nombre
FROM alumno,inscripcion,curso
WHERE alumno.legajo=inscripcion.legajo AND inscripcion.codigo=curso.codigo AND curso.nombre LIKE 'Programacion%'
ORDER BY alumno.nombre DESC;

SELECT nombre
FROM alumno
WHERE legajo=ANY(SELECT legajo FROM inscripcion,curso WHERE curso.codigo=inscripcion.codigo AND curso.nombre LIKE'Programacion%')
ORDER BY nombre DESC;




