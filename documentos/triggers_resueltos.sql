-- Crear una nueva tabla para la BD restaurante que se llame almacen.
-- En ella se guardaran los datos de ingredientes y las cantidades existentes.
-- cuando se completen las comandas (contiene_producto_comanda), se tendra que
-- restar de ingredientes la cantidad utilizada.
create table almacen(
id_ingrediente int primary key,
cantidad float,
foreign key (id_ingrediente) references ingredientes(id_ingrediente)
);

alter table almacen
MODIFY column cantidad float default 0;

select id_ingrediente, round(rand()*100)
from ingredientes i;

insert almacen values(1,1);
delete from almacen;

insert almacen (id_ingrediente, cantidad) 
(select id_ingrediente, round(rand()*100) from ingredientes i);

alter table contiene_producto_comanda 
add completado bool default 0;

alter table contiene_ingrediente_producto 
add cantidad float;

select floor(RAND() * 10);

update contiene_ingrediente_producto 
set cantidad = 1 + floor(RAND() * 9);

select distinct cpc.id_producto, cpc.cantidad, cip.id_ingrediente, cip.cantidad, cpc.cantidad*cip.cantidad as 'cantidad a restar'
from contiene_producto_comanda cpc
join producto p on p.id_producto = cpc.id_producto
join contiene_ingrediente_producto cip on p.id_producto = cip.id_producto
where 1 = cpc.id_producto;

drop trigger producto_completado;
create trigger producto_completado
after update 
on contiene_producto_comanda for each row
begin 
	update almacen 
	set cantidad = cantidad - (select distinct cpc.cantidad*cip.cantidad
								from contiene_producto_comanda cpc
								join producto p on p.id_producto = cpc.id_producto
								join contiene_ingrediente_producto cip on p.id_producto = cip.id_producto
								group by id_ingrediente
								having new.id_producto = cpc.id_producto)
	where id_ingrediente in (select distinct cip.id_ingrediente
								from contiene_producto_comanda cpc
								join producto p on p.id_producto = cpc.id_producto
								join contiene_ingrediente_producto cip on p.id_producto = cip.id_producto
								where new.id_producto = p.id_producto);
end;


-- Cuando se completen todos los contiene_producto_comanda de la comanda, que se actualice una columna llamada completada en comanda.
-- Realizar los cambios nedesarios para ello
alter table comanda 
add completada bool default 0;

select *
from contiene_producto_comanda cpc 
where completado = 0 and id_comanda = 45;

drop trigger comanda_completada;
create trigger comanda_completada
after update 
on contiene_producto_comanda for each row 
begin 
	if not exists (select *
		from contiene_producto_comanda cpc 
		where cpc.completado = 0 and cpc.id_comanda = new.id_comanda)
	then
		update comanda 
		set completada = 1
		where new.id_comanda = id_comanda;
	end if;
end;

UPDATE contiene_producto_comanda
SET completado=1
WHERE id_comanda=44;

set @cantidades = (select cantidad from almacen a where id_ingrediente = 1);
select @cantidades;
-- Cuando en el almacen la cantidad del ingrediente sea menor que 10, que salte un 
-- aviso (warning) para poder comprar mas y reponer. SQLSTATE = '01000'

drop trigger warning;
create trigger warning
after update 
on almacen for each row 
begin 
	set @warnin_text = concat('El producto ', new.id_ingrediente, ' está apunto de agotarse.');	
	if new.cantidad < 10 then 
		signal sqlstate '01000' set MESSAGE_TEXT=@warnin_text;
	end if;
end;

update almacen 
set cantidad = 8
where id_ingrediente =1;
show warnings;

-- realiza los cambios para que podamos saber si la comanda ha sido pagada o no
alter table comanda 
add pagada bool default 0;



