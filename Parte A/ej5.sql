CREATE TABLE proveedor
(
nroProv INT NOT NULL,
nombre CHAR(30),
ciudad CHAR(30),
PRIMARY KEY(nroProv)
);

CREATE TABLE producto
(
nroProd INT NOT NULL,
descripcion CHAR(50),

PRIMARY KEY(nroProd)
);


CREATE TABLE cliente
(
nroCli INT NOT NULL,
nombre CHAR(30),
ciudad CHAR(30),
PRIMARY KEY(nroCli)
);

CREATE TABLE pedido
(
nroCli INT NOT NULL,
nroProv INT NOT NULL,
nroProd INT NOT NULL,
cantidad INT,
fecha DATE NOT NULL,
PRIMARY KEY(nroCli,nroProv,nroProd,fecha),
FOREIGN KEY(nroCli) REFERENCES cliente ON DELETE CASCADE,
FOREIGN KEY(nroProv) REFERENCES proveedor ON DELETE CASCADE,
FOREIGN KEY(nroProd) REFERENCES producto ON DELETE CASCADE
);


--5.3)
SELECT cliente.nombre
FROM cliente,producto,pedido
WHERE cliente.nroCli=pedido.nroCli AND pedido.nroProd=producto.nroProd AND producto.descripcion='Pagina 12' AND cliente.ciudad='Capital Federal';

--5.4)
SELECT c1.nombre, c2.nombre
FROM cliente AS c1, cliente AS c2
WHERE c1.nroCli<c2.nroCli AND c1.ciudad=c2.ciudad

--5.5)

(SELECT nroCli AS col1,nombre,ciudad
FROM cliente
WHERE ciudad='Capital Federal')

UNION

(SELECT nroProv AS col1,nombre,ciudad
FROM proveedor
WHERE ciudad='Capital Federal');

--5.6)
(SELECT nroCli AS col1
FROM cliente
WHERE ciudad='Capital Federal')

UNION

(SELECT nroProv AS col1
FROM proveedor
WHERE ciudad='Capital Federal');
--EL union saca repetidos

--5.7)
ALTER TABLE producto ADD genero CHAR(20);
ALTER TABLE cliente ADD direccion CHAR(30);

--5.8)
update cliente set direccion='Tucuman 110' where nroCli=10; 
update cliente set direccion='Alvear 1256' where nroCli=20;
update cliente set direccion='25 de Mayo 1400' where nroCli=30; 
update cliente set direccion='25 de Mayo 420' where nroCli=40; 
update cliente set direccion='Viamonte 6822' where nroCli=50;
update cliente set direccion='Alem 500' where nroCli=60;
update cliente set direccion='Madero 399' where nroCli=70; 
update cliente set direccion='Francia 200' where nroCli=80; 
update cliente set direccion='Lima 189' where nroCli=90;



