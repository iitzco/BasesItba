CREATE TABLE jugador
(
codigo CHAR(3) NOT NULL,
nombre CHAR(20),
telefono CHAR(9),
PRIMARY KEY(codigo)
);

CREATE TABLE penalizacion
(
codigo CHAR(3) NOT NULL,
fecha DATE NOT NULL,
monto INT,
PRIMARY KEY(codigo,fecha),
FOREIGN KEY (codigo) REFERENCES jugador ON DELETE CASCADE ON UPDATE RESTRICT
);

INSERT INTO jugador VALUES('A02','Barros','4542-8872');
INSERT INTO jugador VALUES('A03','Andrade','4652-7618');
INSERT INTO jugador VALUES('B04','Taranto','4314-2345');
INSERT INTO jugador (codigo, nombre) VALUES('B06','Vilar');
INSERT INTO jugador VALUES('R02','Sanchez','4785-6562');
INSERT INTO jugador VALUES('R07','Peirano','4612-3332');
INSERT INTO jugador VALUES('R11','Cardoso','4314-8102');

INSERT INTO penalizacion VALUES('B06','1998-10-24',120);
INSERT INTO penalizacion VALUES('A03','1998-03-04',100);
INSERT INTO penalizacion VALUES('A03','1999-05-12',150);
INSERT INTO penalizacion VALUES('B04','1999-05-12',120);
INSERT INTO penalizacion VALUES('R07','1999-07-15',100);
INSERT INTO penalizacion VALUES('R07','1998-10-30',120);
INSERT INTO penalizacion VALUES('R11','1999-07-18',150);

-- 2.3)
SELECT codigo,fecha 
FROM penalizacion
WHERE fecha<='1999-12-31' AND fecha>='1998-12-31' ;

-- 2.4)
SELECT nombre 
FROM jugador
WHERE jugador.codigo=ANY(SELECT penalizacion.codigo FROM penalizacion);

-- o

SELECT DISTINCT nombre 
FROM jugador,penalizacion
WHERE jugador.codigo=penalizacion.codigo;

-- 2.5)
SELECT nombre 
FROM jugador
WHERE jugador.codigo<>ALL(SELECT penalizacion.codigo from penalizacion);

-- o

SELECT nombre 
FROM jugador;

MINUS

SELECT DISTINCT nombre 
FROM jugador,penalizacion
WHERE jugador.codigo=penalizacion.codigo;

-- 2.6)
SELECT  jugador.nombre, penalizacion.fecha
FROM jugador LEFT OUTER JOIN penalizacion ON jugador.codigo=penalizacion.codigo
ORDER BY nombre,fecha;

-- 2.7)
DELETE FROM jugador WHERE nombre = 'ANdradE';
-- No se borraron tuplas.

-- 2.8)
DELETE FROM jugador WHERE nombre = 'Andrade';
-- Se borro la entrada correspondiende al nombre en jugador y ademas, por el cascade, se eliminaron las 2 penalizaciones que poseia.

-- 2.9)
SELECT * 
FROM jugador
WHERE telefono LIKE '4314-%'
ORDER BY codigo DESC;





