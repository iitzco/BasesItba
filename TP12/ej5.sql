create or replace function masCaro
(codeditParam editorial.codedit%type)
return libro.precio%type
as

maximo libro.precio%type;

cant int;


begin


  select count(*) into cant from editorial where editorial.codedit=codeditParam;
  
  
  if (cant=0) then
    return -1;
  end if;
 
  select max(precio) into maximo from libro where codedit=codeditParam;
  if  maximo is null then
    return 0;
  end if;
    
  
  return maximo;
  
  
end masCaro;


create or replace procedure librosMasCaros
as

libroP libro%rowtype;

cursor edit is select * from libro where precio=mascaro(codedit);

begin
  open edit;
  
  loop
    fetch edit into libroP;
    exit when edit%NOTFOUND;
    dbms_output.put_line(libroP.titulo || '-------'|| libroP.codedit || '-------' || libroP.precio);
    
  end loop;
  close edit;


end;