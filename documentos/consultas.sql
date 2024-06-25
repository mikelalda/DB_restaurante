-- Mostrar todos los ingredientes de tipo verdura:
select *
from ingredientes i 
where Tipo = 'verdura';

-- Obtener la mesa con mayor capacidad:
select id_mesa, max(capacidad)
from mesa m ;

-- Listar todos los productos de un tipo específico, ordenados por precio ascendente:
select *
from producto p 
where tipo = 'Entrada'
order by precio;

-- Obtener los empleados mayores de cierta edad:
alter table empleado 
add edad int;

update empleado 
set edad = round(rand()*100) + 16;  

select *
from empleado e 
where edad > 25;

-- Mostrar las comandas pendientes de pagar, indicando la mesa y ubicacion:
select c.id_comanda , m.id_mesa, m.ubicacion 
from comanda c 
join mesa m on c.id_mesa = m.id_mesa 
where pagada = 0;

-- Listar los productos que contienen un ingrediente específico:
select  p.*, i.Nombre 
from producto p 
join contiene_ingrediente_producto cip on cip.id_producto=p.id_producto 
join ingredientes i on cip.id_ingrediente = i.id_ingrediente 
where i.Nombre = 'tomate';

-- Obtener las comandas completadas por un empleado en particular:
select *
from comanda c 
join empleado e on e.id_empleado = c.id_empleado 
where c.completada = 1 and e.nombre = 'María García';


-- Calcular el total de ventas por producto:
select cpc.id_producto, sum(cpc.cantidad * p.precio) as total_ventas
from contiene_producto_comanda cpc 
join producto p on cpc.id_producto = p.id_producto
group by cpc.id_producto ;

