--3.2)
select nombre, direccion, ciudad
from cliente
where nrocli=
(select nrocli from pedido where fecha=(select min(fecha) from pedido)); 

--3.3)
select nombre, direccion, ciudad
from cliente
where nrocli=
(select nrocli from pedido where fecha=(select min(fecha) from pedido join producto on pedido.nroprod=producto.nroprod where genero='Chismes')); 

--3.4)
select nombre, ciudad
from proveedor
where not exists (select * from pedido where pedido.nroprov=proveedor.nroprov);

--3.5)
select ciudad,descripcion,sum(cantidad)
from (pedido join cliente on pedido.nrocli=cliente.nrocli) join producto on pedido.nroprod=producto.nroprod
group by ciudad,descripcion
order by ciudad;

--3.6)
select nombre,ciudad
from cliente
where not exists
(select * from pedido where pedido.nrocli=cliente.nrocli and nroprov<>all
(select nroprov from proveedor where proveedor.ciudad=cliente.ciudad))
and exists
(select * from pedido where pedido.nrocli=cliente.nrocli);

--3.7)
select distinct  nombre, genero
from cliente,producto
where not exists
(select * from pedido where cliente.nrocli=pedido.nrocli and pedido.nroprod<>all
(select p.nroprod from producto as p where p.genero=producto.genero))
and exists
(select * from pedido where cliente.nrocli=pedido.nrocli);

--3.8)
select c1.nombre,c2.nombre,p1.fecha
from cliente as c1 join pedido as p1 on c1.nrocli=p1.nrocli, cliente as c2 join pedido as p2 on c2.nrocli=p2.nrocli
where c1.nombre<c2.nombre and 
(select min(fecha) from pedido where c1.nrocli=pedido.nrocli)=(select min(fecha) from pedido where c2.nrocli=pedido.nrocli);

--3.9)
select nombre, sum(cantidad)
from cliente join pedido on cliente.nrocli=pedido.nrocli
group by cliente.nrocli,nombre
having sum(cantidad)>
(select avg(auxi.cant)
from (select sum(cantidad)
from pedido
group by nrocli) as auxi(cant));

select nombre, sum(cantidad)
from cliente join pedido on cliente.nrocli=pedido.nrocli
group by cliente.nrocli,nombre
having sum(cantidad)>
(select avg(auxi.cant)
from (select coalesce(sum(cantidad),0)
from cliente left join pedido on cliente.nrocli=pedido.nrocli
group by cliente.nrocli) as auxi(cant));

--3.10)
update pedido set nroprov=40 where nroprov=10 and (nroprod=1 or nroprod=11);
select * from pedido;

--3.11)
select nombre
from (proveedor join pedido on proveedor.nroprov=pedido.nroprov) join producto on pedido.nroprod=producto.nroprod
group by proveedor.nroprov,nombre
having count(distinct genero)>=3;

