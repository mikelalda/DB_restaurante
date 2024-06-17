
-- Insert a new employee
DELIMITER //
CREATE PROCEDURE InsertEmployee(
    IN p_nombre VARCHAR(255),
    IN p_direccion TEXT,
    IN p_nacimiento DATE,
    IN p_age INT
)
BEGIN
    INSERT INTO empleado (nombre, direccion, nacimiento, age)
    VALUES (p_nombre, p_direccion, p_nacimiento, p_age);
END //
DELIMITER ;

-- Insert a new product
DELIMITER //
CREATE PROCEDURE InsertProduct(
    IN p_tipo VARCHAR(255),
    IN p_descripcion TEXT,
    IN p_nombre VARCHAR(255),
    IN p_precio DECIMAL(10, 2)
)
BEGIN
    INSERT INTO producto (tipo, Descripcion, Nombre, precio)
    VALUES (p_tipo, p_descripcion, p_nombre, p_precio);
END //
DELIMITER ;

-- Insert a new ingredient
DELIMITER //
CREATE PROCEDURE InsertIngredient(
    IN p_nombre VARCHAR(255),
    IN p_tipo VARCHAR(255)
)
BEGIN
    INSERT INTO ingredientes (Nombre, Tipo)
    VALUES (p_nombre, p_tipo);
END //
DELIMITER ;

-- Insert a new order (comanda)
DELIMITER //
CREATE PROCEDURE InsertComanda(
    IN p_descripcion TEXT,
    IN p_id_mesa INT,
    IN p_id_empleado INT,
    IN p_completada BOOLEAN,
    IN p_pagado BOOLEAN
)
BEGIN
    INSERT INTO comanda (descripcion, id_mesa, id_empleado, completada, pagado)
    VALUES (p_descripcion, p_id_mesa, p_id_empleado, p_completada, p_pagado);
END //
DELIMITER ;

-- Link product to order (contiene_producto_comanda)
DELIMITER //
CREATE PROCEDURE LinkProductToOrder(
    IN p_id_producto INT,
    IN p_id_comanda INT,
    IN p_cantidad INT,
    IN p_completada BOOLEAN
)
BEGIN
    INSERT INTO contiene_producto_comanda (id_producto, id_comanda, cantidad, completada)
    VALUES (p_id_producto, p_id_comanda, p_cantidad, p_completada);
END //
DELIMITER ;

-- Link ingredient to product (contiene_ingrediente_producto)
DELIMITER //
CREATE PROCEDURE LinkIngredientToProduct(
    IN p_id_ingrediente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    INSERT INTO contiene_ingrediente_producto (id_ingrediente, id_producto, cantidad)
    VALUES (p_id_ingrediente, p_id_producto, p_cantidad);
END //
DELIMITER ;

-- Add ingredient to storage (almacen)
DELIMITER //
CREATE PROCEDURE AddIngredientToStorage(
    IN p_id_ingrediente INT,
    IN p_cantidad INT
)
BEGIN
    INSERT INTO almacen (id_ingrediente, cantidad)
    VALUES (p_id_ingrediente, p_cantidad);
END //
DELIMITER ;


-- Procedimiento completo de calculo de edad
-- Aquí está el procedimiento completo para añadir y actualizar empleados con el cálculo automático de la edad
-- Función para calcular la edad
DELIMITER //
CREATE FUNCTION CalculateAge(birthdate DATE) RETURNS INT
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
    RETURN age;
END //
DELIMITER ;

-- Trigger para actualizar la edad antes de insertar
DELIMITER //
CREATE TRIGGER BeforeInsertEmployee
BEFORE INSERT ON empleado
FOR EACH ROW
BEGIN
    SET NEW.age = CalculateAge(NEW.nacimiento);
END //
DELIMITER ;

-- Trigger para actualizar la edad antes de actualizar
DELIMITER //
CREATE TRIGGER BeforeUpdateEmployee
BEFORE UPDATE ON empleado
FOR EACH ROW
BEGIN
    SET NEW.age = CalculateAge(NEW.nacimiento);
END //
DELIMITER ;

-- Procedimiento para insertar un nuevo empleado
DELIMITER //
CREATE PROCEDURE InsertEmployee(
    IN p_nombre VARCHAR(255),
    IN p_direccion TEXT,
    IN p_nacimiento DATE
)
BEGIN
    INSERT INTO empleado (nombre, direccion, nacimiento)
    VALUES (p_nombre, p_direccion, p_nacimiento);
END //
DELIMITER ;

-- Procedimiento para actualizar un empleado
DELIMITER //
CREATE PROCEDURE UpdateEmployee(
    IN p_id_empleado INT,
    IN p_nombre VARCHAR(255),
    IN p_direccion TEXT,
    IN p_nacimiento DATE
)
BEGIN
    UPDATE empleado
    SET nombre = p_nombre,
        direccion = p_direccion,
        nacimiento = p_nacimiento
    WHERE id_empleado = p_id_empleado;
END //
DELIMITER ;


CALL InsertEmployee('Pedro Ramirez', 'Calle Luna 456', '1985-07-23');
CALL UpdateEmployee(1, 'Juan Perez', 'Calle Sol 123', '1990-05-15');
