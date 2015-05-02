--1.2)
drop view equipo;
create view equipo (codigo,nombre,ultima,acumulado) as 
select jugador.codigo,jugador.nombre,coalesce(cast(max(fecha) as char(10)),'-'),coalesce(sum(monto),0)
from jugador left join penalizacion on jugador.codigo=penalizacion.codigo
group by jugador.codigo,jugador.nombre;

select * from equipo;

--1.3)
-- No se puede, es una vista
-- udpate equipo set nombre='Villares' where nombre='Vilar'

--1.4)
-- No se puede, es una vista
-- udpate equipo set acumulado=155 where nombre='Cardoso'

--1.5)
insert into penalizacion values ('R07','1998-11-30',200);

--1.6)
select codigo,nombre
from equipo
where acumulado = (select max(acumulado) from equipo);

--o

select e1.codigo,e1.nombre
from equipo as e1
where not exists (select * from equipo as e2 where e2.acumulado>e1.acumulado) ;

--1.7)
select nombre
from equipo
where acumulado< (select sum(monto) from penalizacion where year(fecha)=1998)/
                  (select count(*) from jugador);


--1.8)
select nombre
from equipo
where acumulado< (select avg(mon) from
(select sum(monto) as mon from penalizacion where year(fecha)=1998 group by codigo));

--1.9)
select nombre,case
        when acumulado=0 then 'Tranquilo'
        when acumulado<130 then 'Normal'
        when acumulado< 260 then 'Temperamental'
        else 'Violento'
        end
from equipo;


