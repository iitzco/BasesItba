--5.2)
select nombre
from alu

minus

select nombre
from alu
where not exists (select * from materia where not exists(select * from examen where materia.codigo=examen.codigo and examen.legajo=alu.legajo and examen.nota>=4));

select nombre
from alu
where legajo=any(select legajo from examen where nota>=4 group by legajo having count(distinct codigo)<(select count(codigo) from materia)); 

--5.3)
select legprof
from profesor
where not exists(select * from alu where not exists(select * from examen where profesor.legprof=examen.legprof and alu.legajo=examen.legajo));

--5.4)
select distinct profesor.legprof, codigo
from profesor,examen
where not exists(select * from alu where not exists(select * from examen as e where e.codigo=examen.codigo and e.legajo=alu.legajo and e.legprof=profesor.legprof));

select legprof, codigo
from examen
group by legprof,codigo
having count(distinct legajo)=(select count(legajo) from alu);

--5.5)
select distinct e1.nroacta
from examen as e1, examen as e2
where e1.nroacta=e2.nroacta and e1.legprof<>e2.legprof;

select nroacta
from examen
group by nroacta
having count(distinct legprof)>1; 

--5.6)
update examen set legprof=239 where nroacta=144;
update examen set legprof=239 where nroacta=111;
update examen set nroacta=777 where nroacta=144 and codigo=20;
update examen set nota=2 where legajo=12500 and nroacta=676;

--5.7)
select distinct legprof
from examen
where legajo = any(
select e1.legajo from examen as e1 where not exists(
select * from materia where not exists(
select * from examen as e2 where e1.legajo=e2.legajo and e2.codigo=materia.codigo and e2.nota>=4)));

--5.8)
select legajo, avg(nota)
from examen
where legajo=any(select legajo from examen where nota>=4 group by legajo having count(distinct codigo)=(select count(codigo) from materia))
group by (legajo);

--5.9)
select nombre, nroacta
from profesor JOIN examen as e2 on profesor.legprof=e2.legprof
where e2.legajo=any(select e1.legajo from examen as e1 where nota>=4 group by e1.legajo having count(distinct e1.codigo)=(select count(codigo) from materia)) 
and e2.fecha=(select max(examen.fecha) from examen where examen.legajo=e2.legajo);

