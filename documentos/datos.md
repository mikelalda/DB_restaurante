# Tablas de Datos

## INGREDIENTES
| id_ingrediente | nombre             | tipo       |
|----------------|--------------------|------------|
| 1              | Tomate             | Verdura    |
| 2              | Lechuga            | Verdura    |
| 3              | Cebolla            | Verdura    |
| 4              | Carne de Res       | Carne      |
| 5              | Pollo              | Carne      |
| 6              | Camarones          | Mariscos   |
| 7              | Queso Mozzarella   | Lácteo     |
| 8              | Queso Cheddar      | Lácteo     |
| 9              | Arroz              | Cereal     |
| 10             | Papas              | Tubérculo  |
| 11             | Aceite de Oliva    | Aceite     |
| 12             | Sal                | Condimento |
| 13             | Pimienta           | Condimento |
| 14             | Ajo                | Condimento |
| 15             | Albahaca           | Hierba     |
| 16             | Chocolate          | Dulce      |
| 17             | Azúcar             | Dulce      |
| 18             | Harina             | Cereal     |
| 19             | Huevos             | Lácteo     |
| 20             | Leche              | Lácteo     |

## MESA
| id_mesa | capacidad | ubicacion        |
|---------|-----------|------------------|
| 1       | 2         | Salón Principal  |
| 2       | 4         | Salón Principal  |
| 3       | 6         | Salón Principal  |
| 4       | 8         | Salón Principal  |
| 5       | 10        | Salón Principal  |
| 6       | 4         | Terraza          |
| 7       | 6         | Terraza          |
| 8       | 8         | Terraza          |
| 9       | 4         | Sala Privada     |
| 10      | 6         | Sala Privada     |

## PRODUCTO
| id_producto | nombre              | descripcion        | tipo      | precio |
|-------------|---------------------|--------------------|-----------|--------|
| 1           | Ensalada            | Ensalada de Tomate | Entrada   | 5.00   |
| 2           | Sopa                | Sopa de Pollo      | Entrada   | 7.50   |
| 3           | Bistec              | Bistec de Res      | Principal | 15.00  |
| 4           | Pollo               | Pollo Asado        | Principal | 12.00  |
| 5           | Paella              | Paella de Mariscos | Principal | 18.00  |
| 6           | Tarta               | Tarta de Queso     | Postre    | 6.00   |
| 7           | Helado              | Helado de Chocolate| Postre    | 4.50   |
| 8           | Jugo                | Jugo de Naranja    | Bebida    | 3.00   |
| 9           | Café                | Café               | Bebida    | 2.50   |

## EMPLEADO
| id_empleado | nombre       | direccion                        |
|-------------|--------------|----------------------------------|
| 1           | Juan Perez   | Calle Falsa 123                  |
| 2           | Maria Lopez  | Av. Siempre Viva 742             |
| 3           | Carlos Ruiz  | Boulevard de los Sueños Rotos 456|
| 4           | Ana Garcia   | Calle de la Amargura 789         |

## COMANDA
| id_comanda | descripcion | id_empleado | id_mesa |
|------------|-------------|-------------|---------|
| 1          | Comanda 1   | 1           | 1       |
| 2          | Comanda 2   | 2           | 2       |
| 3          | Comanda 3   | 3           | 3       |
| 4          | Comanda 4   | 4           | 4       |

## INGREDIENTES_PRODUCTO
| id_ingrediente | id_producto |
|----------------|-------------|
| 1              | 1           |
| 2              | 1           |
| 3              | 2           |
| 4              | 3           |
| 5              | 4           |
| 6              | 5           |
| 7              | 6           |
| 8              | 7           |
| 9              | 8           |
| 10             | 9           |

## COMANDA_PRODUCTO
| id_comanda | id_producto |
|------------|-------------|
| 1          | 1           |
| 1          | 2           |
| 2          | 3           |
| 2          | 4           |
| 3          | 5           |
| 3          | 6           |
| 4          | 7           |
| 4          | 8           |
| 4          | 9           |
