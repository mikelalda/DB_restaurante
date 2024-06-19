-- 1. Consultar empleados y su estado de edad 
-- Consulta para listar los empleados junto con una clasificación de su edad (por ejemplo, joven, adulto, mayor).
select nombre, edad,
	case 
		when edad < 18 then 'joven'
		when edad > 70 then 'mayor'
		else 'adulto'
	end as 'estado de edad'
from empleado e;

-- 2. Consultar productos con clasificación de precio 
-- Consulta para listar los productos y clasificarlos según su precio (por ejemplo, barato, medio, caro).
select id_producto, Nombre, precio,
	case 
		when precio < 5 then 'barato'
		when precio between 5 and 10 then 'medio'
		when precio > 10 then 'caro'
	end as clasificación
from producto p;

select id_producto, Nombre, precio,
	case 
		when precio < 6.99 then 'barato'
		when precio >= 6.99 and precio < 10 then 'medio'
		else 'caro'
	end as clasificación
from producto p; 

-- 3. Consultar comandas y su estado de pago y completitud 
-- Consulta para listar las comandas con un estado legible sobre si están completadas y pagadas.
select *,
	case 
		when pagada = 1 and completada = 1 then 'completada y pagada'
		when pagada = 0 and completada = 1 then 'completada pero no pagada'
		else 'ni completada ni pagada'
	end	
from comanda c;

-- 4. Consultar ingredientes en el almacén con estado de inventario 
-- Consulta para listar los ingredientes en el almacén y clasificarlos según su cantidad (por ejemplo, bajo, medio, alto).
select Nombre,
	case 
		when cantidad < 15 then 'bajo'
		when cantidad between 15 and 50 then 'medio'
		else 'alto'
	end	as 'estado ingrediente'
from almacen a
join ingredientes i on a.id_ingrediente = i.id_ingrediente;
	
-- 5. Consultar productos de comandas con su estado de completitud 
-- Consulta para listar los productos de las comandas y mostrar si cada producto está completado.
select c.id_comanda, nombre, 
	case 
		when cpc.completado = 1 then 'completado'
		else 'no completado'
	end	as estado
from producto p 
join contiene_producto_comanda cpc on cpc.id_producto = p.id_producto 
join comanda c on cpc.id_comanda = c.id_comanda
order by c.id_comanda;
-- 6. Consultar ingredientes de productos con su estado de inventario 
-- Consulta para listar los ingredientes necesarios para los productos y clasificar su cantidad en inventario.
select p.Nombre, i.Nombre, a.cantidad 
from ingredientes i
join contiene_ingrediente_producto cip ON i.id_ingrediente = cip.id_ingrediente 
join producto p on p.id_producto = cip.id_producto
join almacen a on a.id_ingrediente = i.id_ingrediente 
order by cantidad;

select i.Nombre
		from almacen a 
		join ingredientes i on a.id_ingrediente = i.id_ingrediente
		where 1 = i.id_ingrediente;
		


create function warning (texto varchar(200))
returns bool
begin
	signal sqlstate '01000' set MESSAGE_TEXT = texto;
	return 1;
end;

drop trigger warning_trigger;
create trigger warning_trigger
after update 
on almacen for each row 
begin 
	set @temp = 0;
	set @warnin_text = concat('El producto ', 
		(select i.Nombre
		from almacen a 
		join ingredientes i on a.id_ingrediente = i.id_ingrediente
		where new.id_ingrediente = i.id_ingrediente),
	' está apunto de agotarse.');
 	case
 		when new.cantidad < 10 and new.id_ingrediente = 1 then set @temp = warning(@warnin_text);
 		when new.cantidad < 5 and new.id_ingrediente = 2 then set @temp = warning(@warnin_text);
 		when new.cantidad < 6 and new.id_ingrediente = 3 then set @temp = warning(@warnin_text);
 	end case;
end;
