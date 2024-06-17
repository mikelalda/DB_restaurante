-- Mostrar todos los ingredientes de tipo verdura:
SELECT Nombre 
FROM INGREDIENTES
WHERE Tipo = 'tipo_ingrediente';

-- Obtener la mesa con mayor capacidad:
SELECT id_mesa, capacidad
FROM MESA
ORDER BY capacidad DESC
LIMIT 1;

-- Listar todos los productos de un tipo específico, ordenados por precio ascendente:
SELECT Nombre, Descripcion, precio
FROM PRODUCTO
WHERE tipo = 'tipo_producto'
ORDER BY precio ASC;


-- Obtener los empleados mayores de cierta edad:
SELECT nombre, anos
FROM EMPLEADO
WHERE anos > edad_limite;

-- Mostrar las comandas pendientes de pagar, indicando la mesa y ubicacion:
SELECT c.id_comanda, c.descripcion, m.ubicacion, e.nombre AS empleado
FROM COMANDA c
JOIN MESA m ON c.id_mesa = m.id_mesa
JOIN EMPLEADO e ON c.id_empleado = e.id_empleado
WHERE c.pagado = 0;

-- Listar los productos que contienen un ingrediente específico:
SELECT p.Nombre, p.Descripcion
FROM PRODUCTO p
JOIN CONTIENE_INGREDIENTE_PRODUCTO cip ON p.id_producto = cip.id_producto
JOIN INGREDIENTES i ON cip.id_ingrediente = i.id_ingrediente
WHERE i.Nombre = 'nombre_ingrediente';

-- Obtener las comandas completadas por un empleado en particular:
SELECT c.id_comanda, c.descripcion
FROM COMANDA c
JOIN EMPLEADO e ON c.id_empleado = e.id_empleado
WHERE e.nombre = 'nombre_empleado' AND c.completada = 1;

-- Calcular el total de ventas por producto:
SELECT p.Nombre, SUM(cpc.cantidad * p.precio) AS total_ventas
FROM PRODUCTO p
JOIN CONTIENE_PRODUCTO_COMANDA cpc ON p.id_producto = cpc.id_producto
JOIN COMANDA c ON cpc.id_comanda = c.id_comanda
WHERE c.pagado = 1
GROUP BY p.Nombre;