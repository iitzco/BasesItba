CREATE TABLE editorial
(
codEdit CHAR(3) NOT NULL,
direccion CHAR(20),
nombre CHAR(20),
pais CHAR(20),
PRIMARY KEY(codEdit)
);

CREATE TABLE factura
(
codFact INT NOT NULL,
fecha DATE,
monto FLOAT,
PRIMARY KEY(codFact)
);

CREATE TABLE libro
(
ISBN CHAR(8) NOT NULL,
titulo CHAR(30),
autor CHAR(30),
codEdit CHAR(3),
genero CHAR(20),
precio FLOAT,
PRIMARY KEY(ISBN),
FOREIGN KEY (codEdit) REFERENCES editorial ON DELETE SET NULL
);

CREATE TABLE detalle_factura
(
codFact INT NOT NULL,
nroLinea INT NOT NULL,
ISBN CHAR(8),
cantidad INT,
PRIMARY KEY(codFact,nroLinea),
FOREIGN KEY (codFact) REFERENCES factura ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (ISBN) REFERENCES libro ON DELETE CASCADE ON UPDATE RESTRICT
);

--4.4)

SELECT titulo,autor,precio
FROM libro
WHERE genero='Infantil';

--4.5)
SELECT titulo,nombre
FROM libro,editorial
WHERE libro.codEdit=editorial.codEdit AND precio<27.5

--4.6)
SELECT titulo
FROM libro
ORDER BY titulo ASC;

--4.7)
SELECT titulo,nombre
FROM libro,editorial
WHERE libro.codEdit=editorial.codEdit AND pais='Canada';

--4.8)
SELECT ISBN,titulo
FROM libro
WHERE precio>50 AND ISBN=ANY(SELECT ISBN FROM detalle_factura);

--4.9)
SELECT nombre
FROM editorial
WHERE codEdit=ANY(SELECT codEdit FROM libro WHERE genero='Computacion') AND pais='USA';

--4.10)
SELECT DISTINCT titulo
FROM libro
WHERE ISBN=ANY(SELECT ISBN FROM detalle_factura WHERE codFact=ANY(SELECT codFact FROM factura WHERE fecha<='1999-09-10' AND fecha>='1999-09-01'));


SELECT DISTINCT titulo
FROM libro,factura,detalle_factura
WHERE libro.ISBN=detalle_factura.ISBN AND detalle_factura.codFact=factura.codFact AND fecha<='1999-09-10' AND fecha>='1999-09-01';
