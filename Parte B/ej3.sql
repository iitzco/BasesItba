--3.2)
SELECT codedit
FROM libro
GROUP BY codedit
HAVING COUNT(ISBN)=1;

SELECT codedit
FROM libro as l1
WHERE NOT EXISTS(SELECT * FROM libro as l2 WHERE l1.codedit=l2.codedit AND l1.ISBN<>l2.ISBN); 

--3.3)
SELECT titulo,autor
FROM libro
WHERE ISBN=ANY(SELECT ISBN FROM detalle_factura GROUP BY ISBN HAVING SUM(cantidad)>=ALL(SELECT SUM(cantidad) FROM detalle_factura GROUP BY ISBN));

--3.4)
SELECT codfact,fecha
FROM factura
WHERE codfact IN (SELECT detalle_factura.codfact FROM detalle_factura WHERE detalle_factura.isbn IN (SELECT l1.isbn FROM libro AS l1 WHERE l1.precio<=ALL(SELECT l2.precio FROM libro AS l2)));

--3.5)
SELECT editorial.nombre
FROM editorial JOIN libro ON libro.codedit=editorial.codedit
WHERE libro.precio = (SELECT MAX(l2.precio) FROM libro AS l2 WHERE l2.codedit IS NOT NULL);

--3.6)
SELECT editorial.nombre,CAST (0.2*(SUM(cantidad*precio))AS DECIMAL(10,2))
FROM libro,editorial,detalle_factura
WHERE libro.isbn=detalle_factura.isbn AND editorial.codedit=libro.codedit
GROUP BY editorial.codedit,editorial.nombre
ORDER BY editorial.nombre DESC;

--3.7)
SELECT codfact
FROM factura
WHERE codfact IN 
    (SELECT codfact FROM detalle_factura GROUP BY codfact HAVING SUM(cantidad)>=ALL
        (SELECT SUM(cantidad) FROM detalle_factura GROUP BY codfact));

SELECT detalle_factura.codfact
FROM factura JOIN detalle_factura ON factura.codfact=detalle_factura.codfact
GROUP BY detalle_factura.codfact
HAVING SUM(cantidad)>=ALL (SELECT SUM(cantidad) FROM detalle_factura GROUP BY codfact);


--3.8)
SELECT detalle_factura.codfact, SUM(cantidad)
FROM factura JOIN detalle_factura ON factura.codfact=detalle_factura.codfact
GROUP BY detalle_factura.codfact
HAVING SUM(cantidad)>=ALL (SELECT SUM(cantidad) FROM detalle_factura GROUP BY codfact);

