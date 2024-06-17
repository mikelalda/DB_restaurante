CREATE FUNCTION CalcularEdad(@fecha_nacimiento DATE)
RETURNS INT
AS
BEGIN
    DECLARE @edad INT
    SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE())
    RETURN @edad
END;


-- Pasar datos
-- trigger para clacular la edad con funcion
-- Crear trigger
CREATE TRIGGER calc_age
BEFORE INSERT
ON empleado FOR EACH ROW
BEGIN
    SET NEW.age = (CalcularEdad(nacimiento));
END; 