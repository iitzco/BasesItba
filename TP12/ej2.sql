CREATE TABLE  cuenta
(
nombre CHAR(20), saldo FLOAT, PRIMARY KEY(nombre)
);

CREATE TABLE  movimiento
(
nombre CHAR(20),
nroTrans INT,
monto FLOAT,
tipo CHAR(1),
fecha DATE,
PRIMARY KEY(nombre, nroTrans),
FOREIGN KEY(nombre) REFERENCES cuenta ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION nexttrans
RETURN int
AS
  ret int;
  
BEGIN
  SELECT max(nrotrans) INTO ret FROM movimiento;
  IF ret IS NULL THEN
    ret:=1;
    return ret;
  ELSE
    ret:=ret+1;
    return ret;
  END IF;
END;

insert into cuenta values('IITZCOVI',3000);

CREATE OR REPLACE PROCEDURE extraecajero
(monto IN NUMBER)
AS
  userName cuenta.nombre%type;
  saldo int;
  cantMov int;
  sumMonto int;
BEGIN

  SELECT user INTO userName FROM dual;
  SELECT saldo into saldo FROM cuenta WHERE nombre=userName;
  SELECT count(*) INTO cantMov FROM movimiento WHERE nombre = userName AND fecha = sysdate AND tipo='E';
  SELECT coalesce (sum(monto),0) INTO sumMonto FROM movimiento WHERE nombre = userName AND fecha = sysdate AND tipo='E';  
  
  IF monto>saldo THEN
    raise_application_error(-20000,'No hay fondos');
  ELSIF cantMov>4 THEN
     raise_application_error(-20001,'Muchas extracciones por hoy papi');
  ELSIF sumMonto+monto>1000 THEN
     raise_application_error(-20002,'Muchas plata por hoy papi');
  END IF;

END;

create or replace PROCEDURE operacion
(tipo IN CHAR,
montoPar IN NUMBER)
AS
  userName cuenta.nombre%type;
  fechaPar date;
BEGIN

  SELECT user INTO userName FROM dual;
  Select sysdate into fechaPar from dual;
  
  
  IF tipo = 'D' THEN
    INSERT INTO movimiento VALUES (userName,nexttrans(),montoPar,'D',fechaPar);
    UPDATE cuenta SET saldo = saldo + montoPar WHERE nombre=userName;
  ELSIF tipo = 'E' THEN
    extraecajero(montoPar);
     INSERT INTO movimiento VALUES (userName,nexttrans(),montoPar,'E',fechaPar);
      UPDATE cuenta SET saldo = saldo - montoPar WHERE nombre=userName;
  ELSE 
     raise_application_error(-20004,'No existe ese tipo de movimiento');
  END IF;
  
  EXCEPTION
    WHEN OTHERS THEN raise_application_error(-20003,'Error');

END;