-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS restaurante;


-- Tabla INGREDIENTES
CREATE TABLE INGREDIENTES (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Tipo VARCHAR(20) NOT NULL
);

-- Tabla MESA
CREATE TABLE MESA (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    capacidad INT NOT NULL,
    ubicacion VARCHAR(50) NOT NULL
);

-- Tabla PRODUCTO
CREATE TABLE PRODUCTO (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Tabla EMPLEADO
CREATE TABLE EMPLEADO (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    nacimiento DATE NOT NULL
);

-- Script para clacular la edad
ALTER TABLE EMPLEADO
ADD anos INTEGER AS (TIMESTAMPDIFF(YEAR,nacimiento, CURDATE()));

-- Script para clacular la edad con funcion
ALTER TABLE EMPLEADO
ADD anos INTEGER AS (CalcularEdad(nacimiento));

-- Tabla COMANDA
CREATE TABLE COMANDA (
    id_comanda INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    id_mesa INT NOT NULL,
    id_empleado INT NOT NULL,
    completada BOOL DEFAULT 0,
    pagado BOOL DEFAULT 0,
    FOREIGN KEY (id_mesa) REFERENCES MESA(id_mesa),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

-- Tabla CONTIENE (Relación entre INGREDIENTES y PRODUCTO)
CREATE TABLE CONTIENE_INGREDIENTE_PRODUCTO (
    id_ingrediente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_ingrediente, id_producto),
    FOREIGN KEY (id_ingrediente) REFERENCES INGREDIENTES(id_ingrediente),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);

-- Tabla CONTIENE (Relación entre PRODUCTO y COMANDA)
CREATE TABLE CONTIENE_PRODUCTO_COMANDA (
    id_producto INT NOT NULL,
    id_comanda INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    completada BOOL DEFAULT 0,
    PRIMARY KEY (id_producto, id_comanda),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    FOREIGN KEY (id_comanda) REFERENCES COMANDA(id_comanda)
);


