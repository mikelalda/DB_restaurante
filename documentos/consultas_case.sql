-- 1. Consultar empleados y su estado de edad
-- Consulta para listar los empleados junto con una clasificación de su edad (por ejemplo, joven, adulto, mayor).
SELECT 
    id_empleado,
    nombre,
    direccion,
    nacimiento,
    age,
    CASE 
        WHEN age < 25 THEN 'Joven'
        WHEN age BETWEEN 25 AND 50 THEN 'Adulto'
        ELSE 'Mayor'
    END AS estado_edad
FROM empleado;

-- 2. Consultar productos con clasificación de precio
-- Consulta para listar los productos y clasificarlos según su precio (por ejemplo, barato, medio, caro).
SELECT 
    id_producto,
    Nombre AS nombre_producto,
    precio,
    CASE 
        WHEN precio < 5 THEN 'Barato'
        WHEN precio BETWEEN 5 AND 15 THEN 'Medio'
        ELSE 'Caro'
    END AS clasificacion_precio
FROM producto;

-- 3. Consultar comandas y su estado de pago y completitud
-- Consulta para listar las comandas con un estado legible sobre si están completadas y pagadas.
SELECT 
    id_comanda,
    descripcion,
    id_mesa,
    id_empleado,
    CASE 
        WHEN completada = TRUE THEN 'Completada'
        ELSE 'Pendiente'
    END AS estado_completada,
    CASE 
        WHEN pagado = TRUE THEN 'Pagado'
        ELSE 'No Pagado'
    END AS estado_pagado
FROM comanda;

-- 4. Consultar ingredientes en el almacén con estado de inventario
-- Consulta para listar los ingredientes en el almacén y clasificarlos según su cantidad (por ejemplo, bajo, medio, alto).
SELECT 
    a.id_ingrediente,
    i.Nombre AS nombre_ingrediente,
    a.cantidad,
    CASE 
        WHEN a.cantidad < 50 THEN 'Bajo'
        WHEN a.cantidad BETWEEN 50 AND 200 THEN 'Medio'
        ELSE 'Alto'
    END AS estado_inventario
FROM almacen a
JOIN ingredientes i ON a.id_ingrediente = i.id_ingrediente;

-- 5. Consultar productos de comandas con su estado de completitud
-- Consulta para listar los productos de las comandas y mostrar si cada producto está completado.
SELECT 
    cpc.id_comanda,
    cpc.id_producto,
    p.Nombre AS nombre_producto,
    cpc.cantidad,
    CASE 
        WHEN cpc.completada = TRUE THEN 'Completada'
        ELSE 'Pendiente'
    END AS estado_completada
FROM contiene_producto_comanda cpc
JOIN producto p ON cpc.id_producto = p.id_producto;

-- 6. Consultar ingredientes de productos con su estado de inventario
-- Consulta para listar los ingredientes necesarios para los productos y clasificar su cantidad en inventario.

SELECT 
    cip.id_producto,
    p.Nombre AS nombre_producto,
    cip.id_ingrediente,
    i.Nombre AS nombre_ingrediente,
    cip.cantidad AS cantidad_necesaria,
    a.cantidad AS cantidad_en_almacen,
    CASE 
        WHEN a.cantidad < cip.cantidad THEN 'Falta'
        ELSE 'Suficiente'
    END AS estado_inventario
FROM contiene_ingrediente_producto cip
JOIN producto p ON cip.id_producto = p.id_producto
JOIN ingredientes i ON cip.id_ingrediente = i.id_ingrediente
JOIN almacen a ON cip.id_ingrediente = a.id_ingrediente;