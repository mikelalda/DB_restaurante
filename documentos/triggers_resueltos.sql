-- Crear una nueva tabla para la BD restaurante que se llame almacen.
-- En ella se guardaran los datos de ingredientes y las cantidades existentes.
-- cuando se completen las comandas (contiene_producto_comanda), se tendra que
-- restar de ingredientes la cantidad utilizada.
CREATE TABLE almacen(
    id_ingrediente INTEGER PRIMARY KEY,
    cantidad INTEGER NOT NULL DEFAULT 0
    FOREIGN KEY ingrediente (id_ingrediente) REFERENCES ingredientes(id_ingrediente);
);


INSERT almacen (id_ingrediente)  SELECT id_ingrediente FROM ingredientes;

UPDATE almacen 
SET cantidad = (SELECT round(1+ rand() * 49));


CREATE TRIGGER tr_actualizar_almacen
AFTER UPDATE ON contiene_producto_comanda
FOR EACH ROW
BEGIN
    IF NEW.completada = 1 THEN
        UPDATE almacen a
        JOIN contiene_ingrediente_producto ip ON a.id_ingrediente = ip.id_ingrediente
        JOIN producto p ON ip.id_producto = p.id_producto
        SET a.cantidad = a.cantidad - (
            SELECT SUM(cpc.cantidad * COALESCE(new.cantidad, 1))
            FROM contiene_producto_comanda cpc
            WHERE cpc.id_comanda = NEW.id_comanda
              AND cpc.id_producto = ip.id_producto
              AND cpc.completada = 1
        )
        WHERE EXISTS (
            SELECT 1
            FROM contiene_producto_comanda
            WHERE id_comanda = NEW.id_comanda
              AND id_producto = ip.id_producto
        );
    END IF;
END;

-- Cuando se completen todos los contiene_producto_comanda de la comanda, que se actualice una columna llamada completada en comanda.
-- Realizar los cambios nedesarios para ello
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




-- En caso de no tener ingredientes para el producto seleccionado, que
-- el camarero no pueda elegir ese producto y muestre un error de que no hay ingredientes
CREATE TRIGGER tr_verificar_ingredientes
BEFORE INSERT ON contiene_producto_comanda
FOR EACH ROW
BEGIN
    DECLARE cant_ingredientes INT;
    
    SELECT SUM(a.cantidad * COALESCE(NEW.cantidad, 1)) INTO cant_ingredientes
    FROM almacen a
    JOIN contiene_ingrediente_producto cip ON a.id_ingrediente = cip.id_ingrediente
    JOIN producto p ON cip.id_producto = p.id_producto
    WHERE cip.id_producto = NEW.id_producto
    GROUP BY cip.id_producto;
    
    IF cant_ingredientes <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay ingredientes suficientes para este producto.';
    END IF;
END;


-- Cuando en el almacen la cantidad del ingrediente sea menor que 10, que salte un 
-- aviso para poder comprar mas y reponer. SQLSTATE = '01000'
CREATE TRIGGER tr_aviso_compra_ingredientes
AFTER UPDATE ON almacen
FOR EACH ROW
BEGIN
	SET @text = concat('Aviso: La cantidad del ingrediente ', (SELECT nombre FROM ingredientes WHERE id_ingrediente = NEW.id_ingrediente), ' es menor que 10. Considere comprar más.');
    IF NEW.cantidad < 10 THEN
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = @text;
    END IF;
END;

