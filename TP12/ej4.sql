--ej4

create or replace procedure ej4 as

total float;
editT editorial%rowtype;

cursor editC is select * from editorial;

begin

  dbms_output.put_line('Editorial       Libro         Factura Cantidad  Precio  Total');
  open editC;
  loop
    fetch editC into editT;
    exit when editC%NOTFOUND;
    dbms_output.put_line('.............................................................');
    dbms_output.put_line(editT.codEdit);
    
    listBooks(editT.codEdit);
    
    
    
  end loop;
  close editC;
  
  select sum(cantidad*precio) into total from detalle_factura,libro where libro.isbn=detalle_factura.isbn and libro.codedit=any(select codedit from editorial);
  dbms_output.put_line('.............................................................');
  dbms_output.put_line('                                      Total:'|| total);

end ej4;


--listBooks

create or replace procedure listBooks
(editParam editorial.codEdit%type) as

total float;
libroT libro%rowtype;
cursor bookC is select * from libro where codedit=editParam;

begin

  open bookC;
  
  loop
    fetch bookC into libroT;
    exit when bookC%NOTFOUND;
    
    dbms_output.put_line('               '||libroT.titulo);

    listBill(libroT.isbn);
    
    dbms_output.put_line('           ...........................');
  end loop;
  
  close bookC;
  
  select sum(cantidad*precio) into total from libro,detalle_factura where libro.isbn=detalle_factura.isbn and libro.codedit=editParam;
  dbms_output.put_line('               Total Editorial:'||total);
  


end listBooks;

--listBill

create or replace procedure listBill
(isbnParam libro.isbn%type) as

total float;
precioP float;
billT detalle_factura%rowtype;
cursor billC is select * from detalle_factura where isbn=isbnParam;

begin

  open billC;
  
  total:=0;
  
  loop
    fetch billC into billT;
    exit when billC%NOTFOUND;
    select precio into precioP from libro where isbn=billT.isbn;
    total:=total+(precioP*billT.cantidad);
    dbms_output.put_line('                   '||billT.codfact || '   '|| billT.cantidad||'   '||precioP||'    '||(precioP*billT.cantidad));

  end loop;
  
  close billC;
  
  dbms_output.put_line('                   Total Libro :'||total);
  


end listBill;