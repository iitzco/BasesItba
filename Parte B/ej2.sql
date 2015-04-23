
--2.2)
SELECT legajo
FROM inscripcion
GROUP BY legajo
HAVING COUNT(DISTINCT codigo)>=2;

--2.3)
SELECT nombre
FROM alumno JOIN inscripcion ON alumno.legajo=inscripcion.legajo
GROUP BY alumno.legajo,nombre
HAVING COUNT(DISTINCT codigo)=(SELECT COUNT(codigo) FROM curso);

SELECT nombre
FROM alumno AS alu
WHERE NOT EXISTS(SELECT * FROM curso AS c WHERE NOT EXISTS (SELECT * FROM inscripcion AS i WHERE i.legajo=alu.legajo AND i.codigo=c.codigo));


--2.5)
SELECT DISTINCT ano
FROM inscripcion as i1
WHERE NOT EXISTS(SELECT * FROM inscripcion AS i2,alumno WHERE i1.ano=i2.ano AND alumno.legajo=i2.legajo AND alumno.sexo='F');

--2.6)

SELECT ano
FROM (SELECT ano,COUNT(legajo) FROM inscripcion GROUP BY ano) AS auxi(ano,cant)
WHERE cant>=ALL((SELECT COUNT(legajo) FROM inscripcion GROUP BY ano));

SELECT ano
FROM inscripcion
GROUP BY ano
HAVING COUNT(*)>=ALL(SELECT COUNT(*) FROM inscripcion GROUP BY ano)

--2.7)

SELECT nombre,COUNT(codigo) AS total 
FROM alumno,inscripcion
WHERE alumno.legajo=inscripcion.legajo
GROUP BY inscripcion.legajo,nombre
ORDER BY nombre;

--2.8)
SELECT nombre,COUNT(DISTINCT codigo) AS total 
FROM alumno,inscripcion
WHERE alumno.legajo=inscripcion.legajo
GROUP BY inscripcion.legajo,nombre
ORDER BY nombre;

--2.9)
SELECT nombre,COUNT(DISTINCT codigo) AS total 
FROM alumno,inscripcion
WHERE alumno.legajo=inscripcion.legajo AND alumno.carrera='electronica'
GROUP BY inscripcion.legajo,nombre
ORDER BY nombre;

--2.10)
SELECT carrera,COUNT(DISTINCT legajo) AS total 
FROM alumno
GROUP BY carrera;

--2.11)
SELECT carrera 
FROM alumno as a1
GROUP BY carrera
HAVING COUNT(legajo)>=ALL(SELECT COUNT(legajo) FROM alumno as a2 GROUP BY a2.carrera);


--2.12)
SELECT nombre
FROM alumno
WHERE NOT EXISTS (SELECT * FROM curso WHERE nombre LIKE 'Programacion%' AND NOT EXISTS (SELECT * FROM inscripcion WHERE alumno.legajo=inscripcion.legajo AND inscripcion.codigo=curso.codigo));

--2.13)
SELECT nombre
FROM alumno

MINUS

SELECT nombre
FROM alumno
WHERE NOT EXISTS (SELECT * FROM curso WHERE nombre LIKE 'Programacion%' AND NOT EXISTS (SELECT * FROM inscripcion WHERE alumno.legajo=inscripcion.legajo AND inscripcion.codigo=curso.codigo));

------------ 

SELECT nombre
FROM alumno
WHERE EXISTS (SELECT * FROM curso WHERE nombre LIKE 'Programacion%' AND NOT EXISTS (SELECT * FROM inscripcion WHERE alumno.legajo=inscripcion.legajo AND inscripcion.codigo=curso.codigo));
