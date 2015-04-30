--4.2)

SELECT p1.nombre
FROM proveedor AS p1
WHERE p1.nroProv=ANY
(SELECT p2.nroProv FROM pedido AS p2 GROUP BY nroProv HAVING COUNT(distinct nroCli)>=ALL
(SELECT COUNT(distinct p3.nroCLi) FROM pedido AS p3 GROUP BY p3.nroProv));


--4.3)
SELECT prov.nombre 
FROM proveedor as prov
WHERE prov.nroprov<>ALL(
SELECT pe.nroprov 
FROM pedido AS pe, producto AS pr
WHERE pe.nroprod=pr.nroprod AND pr.genero='Ingles') AND prov.nroprov=ANY(SELECT nroprov FROM pedido);