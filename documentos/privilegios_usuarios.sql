-- Crea los usuariosm de camarero y cocinero. 
-- Cambia los privilegios de las tablas para estos usuarios.

create user 'camarero'@'%' IDENTIFIED by 'camarero';
create user 'cocinero'@'%' IDENTIFIED by 'cocinero';
create user 'mikel'@'%' IDENTIFIED by 'patata_mango';
drop user 'mikel'@'%';

grant select, insert, update, delete on almacen to camarero;
grant select, insert, update, delete on ingredientes to camarero;
grant select, insert, update, delete on comanda to camarero;
grant select, insert, update, delete on contiene_producto_comanda to camarero;
grant select, insert, update, delete on contiene_ingrediente_producto to camarero;
grant select, insert, update, delete on producto to camarero;

grant select on ingredientes to cocinero;
grant select on comanda to cocinero;
grant select, update on contiene_producto_comanda to cocinero;
grant select on contiene_ingrediente_producto to cocinero;
grant select on producto to cocinero;
grant select, insert, update, delete on almacen to cocinero;

revoke select, insert, update, delete on almacen from cocinero;