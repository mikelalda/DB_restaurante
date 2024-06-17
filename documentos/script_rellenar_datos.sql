-- Insertando datos en la tabla INGREDIENTES
INSERT INTO INGREDIENTES (Nombre, Tipo) VALUES
('Tomate', 'Verdura'), ('Lechuga', 'Verdura'), ('Cebolla', 'Verdura'), ('Carne de Res', 'Carne'), ('Pollo', 'Carne'),
('Camarones', 'Mariscos'), ('Queso Mozzarella', 'Lácteo'), ('Queso Cheddar', 'Lácteo'), ('Arroz', 'Cereal'), ('Papas', 'Tubérculo'),
('Aceite de Oliva', 'Aceite'), ('Sal', 'Condimento'), ('Pimienta', 'Condimento'), ('Ajo', 'Condimento'), ('Albahaca', 'Hierba'),
('Chocolate', 'Dulce'), ('Azúcar', 'Dulce'), ('Harina', 'Cereal'), ('Huevos', 'Lácteo'), ('Leche', 'Lácteo');

-- Insertando datos en la tabla MESA
INSERT INTO MESA (capacidad, ubicacion) VALUES
(2, 'Salón Principal'), (4, 'Salón Principal'), (6, 'Salón Principal'), (8, 'Salón Principal'), (10, 'Salón Principal'),
(4, 'Terraza'), (6, 'Terraza'), (8, 'Terraza'), (4, 'Sala Privada'), (6, 'Sala Privada');

-- Insertando datos en la tabla PRODUCTO
INSERT INTO PRODUCTO (tipo, Descripcion, Nombre, precio) VALUES
('Entrada', 'Ensalada fresca con lechuga, tomate, cebolla y aderezo italiano', 'Ensalada César', 7.99),
('Entrada', 'Rollitos de pollo crujientes con salsa agridulce', 'Rollitos de Pollo', 6.99),
('Plato Fuerte', 'Filete de res a la parrilla con papas fritas y ensalada', 'Filete de Res', 18.99),
('Plato Fuerte', 'Espagueti con camarones y salsa de tomate', 'Espagueti con Camarones', 16.99),
('Plato Fuerte', 'Pollo asado con arroz y verduras', 'Pollo Asado', 14.99),
('Postre', 'Pastel de chocolate con glaseado de chocolate y crema batida', 'Pastel de Chocolate', 6.99),
('Bebida', 'Refresco de cola', 'Refresco', 2.99),
('Bebida', 'Limonada natural', 'Limonada', 3.99);

-- Insertando datos en la tabla EMPLEADO
INSERT INTO EMPLEADO (nombre, direccion) VALUES
('Juan Pérez', 'Calle Principal 123, Ciudad','1996-05-02'),
('María García', 'Avenida Central 456, Ciudad','1996-05-02'),
('Pedro Rodríguez', 'Calle Secundaria 789, Ciudad','1996-05-02'),
('Ana Martínez', 'Avenida Norte 012, Ciudad','1996-05-02'),
('Luis Hernández', 'Calle Sur 345, Ciudad','1996-05-02'),
('Sofía Torres', 'Avenida Oeste 678, Ciudad','1996-05-02'),
('Carlos Ramírez', 'Calle Este 901, Ciudad','1996-05-02'),
('Laura Sánchez', 'Avenida Principal 234, Ciudad','1996-05-02'),
('Diego González', 'Calle Norte 567, Ciudad','1996-05-02'),
('Lucía Flores', 'Avenida Sur 890, Ciudad','1996-05-02');

-- Insertando datos en la tabla COMANDA
INSERT INTO COMANDA (descripcion, id_mesa, id_empleado) VALUES
('Comanda Mesa 1', 1, 1), ('Comanda Mesa 2', 2, 2), ('Comanda Mesa 3', 3, 3),
('Comanda Mesa 4', 4, 4), ('Comanda Mesa 5', 5, 5), ('Comanda Mesa 6', 6, 6),
('Comanda Mesa 7', 7, 7), ('Comanda Mesa 8', 8, 8), ('Comanda Mesa 9', 9, 9),
('Comanda Mesa 10', 10, 10);

-- Insertando datos en la tabla CONTIENE_INGREDIENTE_PRODUCTO
INSERT INTO CONTIENE_INGREDIENTE_PRODUCTO (id_ingrediente, id_producto) VALUES
(2, 1), (1, 1), (3, 1), (4, 3), (10, 3), (2, 3), (5, 4), (6, 4), (1, 4), (9, 5), (5, 5), (2, 5), (3, 5), (16, 6), (17, 6), (7, 6), (8, 6);

-- Insertando datos en la tabla CONTIENE_PRODUCTO_COMANDA
INSERT INTO CONTIENE_PRODUCTO_COMANDA (id_producto, id_comanda) VALUES
(1, 1), (3, 1), (7, 1), (2, 2), (4, 2), (8, 2), (5, 3), (6, 3), (1, 4), (3, 4), (7, 4),
(2, 5), (4, 5), (8, 5), (5, 6), (6, 6), (1, 7), (3, 7), (7, 7), (2, 8), (4, 8), (8, 8),
(5, 9), (6, 9), (1, 10), (3, 10), (7, 10);