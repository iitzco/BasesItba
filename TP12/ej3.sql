create or replace procedure JugadorXML
(jugadorP in JUGADOR.codigo%type, desde in date, hasta in date) as
    jugP jugador%rowtype;
    penP penalizacion%rowtype;
    sumMonto int;
    cursor cursorPen is select * from penalizacion where penalizacion.codigo = jugadorP and fecha>desde and fecha<hasta;
  begin
    select * into jugP from jugador where jugador.codigo=jugadorP;
    select coalesce(sum(monto),0) into sumMonto from penalizacion where penalizacion.codigo=jugadorP and fecha>desde and fecha<hasta;
    dbms_output.put_line('<jugador codigo="'||jugadorP||'">');
    dbms_output.put_line('  <nombre>'||jugP.nombre||'</nombre>');
    dbms_output.put_line('  <telefono>'||jugP.telefono||'</telefono>'); 
    dbms_output.put_line('  <penalizaciones total="'||sumMonto||'">');
    open cursorPen;
    
    loop
      fetch cursorPen into penP;
       exit when cursorPen%NOTFOUND;
       dbms_output.put_line('   <penalizacion>');
       dbms_output.put_line('     <fecha>'||penP.fecha||'</fecha>');
       dbms_output.put_line('     <monto>'||penP.monto||'</monto>');
       dbms_output.put_line('   </penalizacion>');
     
    end loop;
    
    close cursorPen;
    
    dbms_output.put_line('  </penalizaciones>');
  
  exception
    when others then dbms_output.put_line('Jugador Inexistente');
  
      
  END JugadorXML;
  