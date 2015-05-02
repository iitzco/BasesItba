--2.2)
select titulo,cantidad
from libro, detalle_factura
where libro.isbn=detalle_factura.isbn and codfact=any
(select codfact from factura where fecha = 
(select min(fecha) from 
(select fecha from factura where month(fecha)=9 and codfact=any
(select codfact from detalle_factura,libro where detalle_factura.isbn=libro.isbn and titulo='Blancanieves')))+6 days);

--2.3)
select distinct titulo
from libro join detalle_factura on libro.isbn=detalle_factura.isbn
where codfact=any(
select codfact from factura where fecha>='1999-09-20' and fecha<='1999-09-30');

--2.4)
select periodo,sum(cantidad)
from (select case
              when (fecha>='1999-09-01' and fecha<='1999-09-07') then 'Primeros 7 dias'
              when (fecha>='1999-09-24' and fecha<='1999-09-30') then 'Ultimos 7 dias'
              end as periodo , cantidad
      from factura join detalle_factura on factura.codfact=detalle_factura.codfact
      where (fecha>='1999-09-01' and fecha<='1999-09-07') or (fecha>='1999-09-24' and fecha<='1999-09-30'))
group by periodo;
      

--2.5)
select month(fecha)-1 as mes,day(fecha)-1 as dia
from factura
where fecha=
(select max(fecha)
from factura
where month(fecha)=9 and year(fecha)=1999);

--2.6)
select nombre
from editorial
where not exists 
(select * from factura where not exists
(select * from detalle_factura where factura.codfact=detalle_factura.codfact and detalle_factura.isbn=any
(select isbn from libro where libro.codedit=editorial.codedit)));

--2.7)
UPDATE detalle_factura SET ISBN = '15030109' WHERE codFact= 1003;
select nombre
from editorial
where not exists 
(select * from factura where not exists
(select * from detalle_factura where factura.codfact=detalle_factura.codfact and detalle_factura.isbn=any
(select isbn from libro where libro.codedit=editorial.codedit)));
ROLLBACK;

--2.8)
create view vista
as
(select detalle_factura.codfact,sum(cantidad * precio) as monto
from detalle_factura,libro
where libro.isbn=detalle_factura.isbn
group by detalle_factura.codfact);

update factura set monto= (select monto from vista where vista.codfact=factura.codfact);

drop view vista;

--2.9)
select factura.codfact,sum(cantidad)
from factura join detalle_factura on factura.codfact=detalle_factura.codfact
where monto>=all(select monto from factura)
group by factura.codfact;

--2.10)
select titulo
from libro
where isbn=any
(select isbn from detalle_factura group by isbn having sum(cantidad)=
(select min(cant) from (select sum(cantidad) as cant from detalle_factura group by isbn)));

--2.11)
select isbn
from detalle_factura
where not exists
(select * from factura where detalle_factura.codfact=factura.codfact and fecha >='1999-09-01' and fecha <='1999-09-15')
and exists
(select * from factura where detalle_factura.codfact=factura.codfact);

--2.12)
select distinct d1.codfact
from detalle_factura as d1, detalle_factura as d2
where d1.codfact=d2.codfact and d1.nrolinea<>d2.nrolinea and d1.isbn=d2.isbn;

--2.13)
INSERT INTO detalle_factura VALUES(1004, 3, '15030109', 5);
select distinct d1.codfact
from detalle_factura as d1, detalle_factura as d2
where d1.codfact=d2.codfact and d1.nrolinea<>d2.nrolinea and d1.isbn=d2.isbn;
ROLLBACK;

--2.14)
select codfact
from factura
where not exists
(select *
from detalle_factura as d1 join libro as l1 on d1.isbn=l1.isbn, detalle_factura as d2 join libro as l2 on d2.isbn=l2.isbn
where d1.codfact=d2.codfact and d1.codfact=factura.codfact and ((l1.codedit<>l2.codedit) or (l1.codedit is null and  l2.codedit is not  null) or (l1.codedit is not null and  l2.codedit is null)));

--2.15)
select titulo, factura.codfact, (precio/monto)*100
from libro,factura
where exists(select * from detalle_factura where libro.isbn=detalle_factura.isbn and detalle_factura.codfact=factura.codfact)
and (precio/monto)*100<25;

--2.16)
select nombre,pais, case
                      when codedit like 'BO%' then 'Boston'
                      when codedit like 'WO%' then 'Waterloo'
                      when codedit like 'XA%' then 'Desconocida'
                      end as ciudad
from editorial;
