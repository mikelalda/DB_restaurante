CREATE TRIGGER check_completada
AFTER UPDATE
ON contiene_producto_comanda FOR EACH row
BEGIN
    IF NOT EXISTS (
        SELECT completada
        FROM contiene_producto_comanda
        WHERE id_comanda = NEW.id_comanda AND completada = 0
    ) THEN
		UPDATE restaurante.comanda 
		SET completada = 1 
		WHERE id_comanda = NEW.id_comanda;
    END IF;
END

-- No es lo correcto, se tendria que hacer el script al crear la tabla
-- añadir columna
ALTER TABLE empleado
ADD age INTEGER;
-- Crear trigger
CREATE TRIGGER calc_age
BEFORE INSERT
ON empleado FOR EACH ROW
BEGIN
    SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.nacimiento, CURDATE());
END;
