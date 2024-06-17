El ejercicio consiste en crear una aplicación de escritorio utilizando el framework PyQt5, que simula un restaurante con capacidad para gestionar pedidos y carritos de compras. La aplicación debe tener las siguientes características:

    Conectar a una base de datos MySQL para obtener los productos, mesas y empleados.
    Crear una interfaz de usuario con una cuadrícula de productos que puede ser seleccionada y agregada al carrito de compras.
    Mostrar el contenido del carrito de compras en un listado.
    Permitir la selección de mesa y empleado para crear un pedido.
    Crear un nuevo pedido en la base de datos cuando se hace clic en el botón "Crear orden".
    Actualizar el carrito de compras y los totales al agregar o eliminar productos.

Para completar este ejercicio, se deben crear las siguientes clases:

    RestaurantApp: esta clase representa la aplicación y es responsable de manejar la conexión a la base de datos, mostrar la interfaz de usuario y gestionar los pedidos.
    Product: esta clase representa un producto y debe tener atributos como el id, nombre y precio del producto.
    Order: esta clase representa un pedido y debe tener atributos como el id, descripción y estado del pedido.

Se deben crear métodos para:

    Conectar a la base de datos y obtener los productos, mesas y empleados.
    Agregar productos al carrito de compras.
    Mostrar el contenido del carrito de compras en un listado.
    Permitir la selección de mesa y empleado para crear un pedido.
    Crear un nuevo pedido en la base de datos cuando se hace clic en el botón "Crear orden".
    Actualizar el carrito de compras y los totales al agregar o eliminar productos.

Se deben utilizar las siguientes tecnologías:

    Python 3.x
    PyQt5
    MySQL

Para completar este ejercicio, se recomienda seguir los pasos siguientes:

    Crear la clase RestaurantApp y definir los métodos para conectar a la base de datos y obtener los productos, mesas y empleados.
    Crear la cuadrícula de productos utilizando una tabla QTableWidget y agregar un método para seleccionar un producto y agregarlo al carrito de compras.
    Crear el listado del carrito de compras utilizando una lista QListWidget y agregar un método para actualizar el contenido del listado.
    Crear la selección de mesa y empleado utilizando comboboxes QComboBox y agregar un método para crear un nuevo pedido cuando se hace clic en el botón "Crear orden".
    Implementar los métodos para conectar a la base de datos, agregar productos al carrito de compras, mostrar el contenido del carrito de compras, permitir la selección de mesa y empleado y crear un nuevo pedido.
