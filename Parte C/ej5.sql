-- R0=Tabla1
-- Ri=Ri-1 Union { T | (exists U)(Ri-1(U) and (exists V)(Tabla2(V) and U[HizoNegociosCon]=V[Persona] and T[Persona]=U[Persona] and T[HizoNegociosCon]=V[SocioDe]) }


--SQL3
with recursive negocios
as
(
		(select * from Tabla1)
		Union
		(select negocios.persona,tabla2.SocioDe as HizoNegociosCon from negocios,tabla2 where negocios.HizoNegociosCon=tabla2.persona;
)

select * from familiarDe;


--DB2
--Para db2 no hay que poner recursive...y ademas hay que ahregar union all
with negocios
as
(
		(select * from Tabla1)
		Union all
		(select negocios.persona,tabla2.SocioDe as HizoNegociosCon from negocios,tabla2 where negocios.HizoNegociosCon=tabla2.persona;
)

select * from familiarDe;