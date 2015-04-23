--1.1) Hecho en la Parte A

--1.2)
SELECT MAX(monto)
FROM penalizacion;

--1.3)
SELECT MAX(monto) AS MAXIMO_98
FROM penalizacion
WHERE YEAR(fecha)=1998;


--1.4)
SELECT SUM(monto),nombre AS NOMBRE
FROM penalizacion JOIN jugador ON penalizacion.codigo=jugador.codigo
GROUP BY penalizacion.codigo,nombre
ORDER BY nombre;

--1.5)
SELECT SUM(monto)/8.5 AS DOLARES,nombre AS NOMBRE
FROM penalizacion JOIN jugador ON penalizacion.codigo=jugador.codigo
GROUP BY penalizacion.codigo,nombre
ORDER BY nombre;

--1.6)

SELECT nombre, COALESCE (CAST(MIN(fecha) AS CHAR(10)),'-')
FROM jugador LEFT JOIN penalizacion ON jugador.codigo=penalizacion.codigo
GROUP BY jugador.codigo,nombre;

--1.7)

SELECT nombre, COALESCE (SUBSTR(CAST(MIN(fecha) AS CHAR(10)),9,2) ||'-'||SUBSTR(CAST(MIN(fecha) AS CHAR(10)),6,2)||'-'||SUBSTR(CAST(MIN(fecha) AS CHAR(10)),1,4) ,'-')
FROM jugador LEFT JOIN penalizacion ON jugador.codigo=penalizacion.codigo
GROUP BY jugador.codigo,nombre;


