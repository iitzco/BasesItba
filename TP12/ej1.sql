CREATE OR REPLACE FUNCTION nombreprof (
plegajo IN NUMBER
) RETURN VARCHAR AS
nom profesor.nombre%type;
BEGIN
SELECT nombre INTO nom FROM profesor
WHERE legprof = plegajo; RETURN nom;
END nombreprof;

--Este esta mal...

CREATE OR REPLACE FUNCTION nombreprof (
plegajo IN NUMBER
) RETURN VARCHAR AS
nom profesor.nombre%type;
var int;
BEGIN
SELECT count(*) INTO var FROM profesor WHERE legprof==plegajo;
if var == 0
	nom:='No hay';
	return nom;
endif;
SELECT nombre INTO nom FROM profesor
WHERE legprof = plegajo; RETURN nom;
END nombreprof;

--Usando funcion de agregacion

CREATE OR REPLACE FUNCTION nombreprof (
plegajo IN NUMBER
) RETURN VARCHAR AS
nom profesor.nombre%type;
BEGIN
SELECT nombre INTO nom FROM profesor
WHERE legprof = plegajo; RETURN nom;

EXCEPTION 
	WHEN NO_DATA_FOUND THEN raise_application_error(-20001,'El Profesor no existe');
END nombreprof;

--El codigo debe ser < -20000
--Con excepcion