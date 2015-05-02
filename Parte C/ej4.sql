-- R0=Tabla1
-- Ri=Ri-1 Union { T | (exists U)(Tabla1(U) and (exists V)(Ri-1(V) and U[ParienteDe]=V[Persona] and T[Persona]=U[Persona] and T[ParienteDe]=V[ParienteDe]) }


--SQL3
with recursive familiarDe
as
(
		(select * from Tabla1)
		Union
		(select familiarDe.Persona,Tabla1.ParienteDe from familiarDe,Tabla1 where familiarDe.ParienteDe=Tabla1.Persona)
)

select * from familiarDe;


--DB2
--Para db2 no hay que poner recursive...y ademas hay que ahregar union all
with familiarDe
as
(
		(select * from Tabla1)
		Union all
		(select familiarDe.Persona,Tabla1.ParienteDe from familiarDe,Tabla1 where familiarDe.ParienteDe=Tabla1.Persona)
)

select * from familiarDe;