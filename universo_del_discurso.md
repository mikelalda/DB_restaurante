# UNIVERSO DEL DISCURSO
## RESTAURANTE
En este restaurante, se manejan diferentes entidades y relaciones para llevar a cabo sus operaciones diarias de manera eficiente. A continuación, se describe cada una de ellas y cómo interactúan entre sí:

1. Ingredientes:
   - El restaurante mantiene un inventario de diferentes ingredientes que se utilizan para preparar los platillos en su menú.
   - Cada ingrediente tiene un identificador único (id_ingrediente), un nombre y un tipo (por ejemplo, verdura, carne, lácteo, etc.).
2. Productos:
   - El menú del restaurante está compuesto por diferentes productos o platillos.
   - Cada producto tiene un identificador único (id_producto), un tipo (por ejemplo, entrada, plato fuerte, postre), una descripción, un nombre y un precio.
   - Los productos están compuestos por uno o más ingredientes, lo cual se registra en la relación "CONTIENE" entre las entidades INGREDIENTES y PRODUCTO.
3. Mesas:
   - El restaurante cuenta con varias mesas para atender a los comensales.
   - Cada mesa tiene un identificador único (id_mesa), una capacidad (número de personas que puede acomodar) y una ubicación dentro del establecimiento.
4. Comandas:
   - Cuando un grupo de comensales se sienta en una mesa, se crea una comanda para registrar sus pedidos.
   - Cada comanda tiene un identificador único (id_comanda), una descripción (por ejemplo, "Comanda para la Mesa 5") y está asociada a una mesa específica (id_mesa) y a un empleado encargado de atenderla (id_empleado).
   - Los productos que se piden en una comanda se registran en la relación "CONTIENE" entre las entidades PRODUCTO y COMANDA.
5. Empleados:
   - El restaurante tiene varios empleados que se encargan de atender a los comensales.
   - Cada empleado tiene un identificador único (id_empleado), un nombre y una dirección.
   - Cada comanda se asigna a un empleado específico, quien es responsable de tomarla, entregarla en la cocina y servir los platillos a los comensales.



El flujo de operación en el restaurante sería el siguiente:

1. Un grupo de comensales llega y se les asigna una mesa disponible según su capacidad requerida.
3. Un empleado toma la orden de los comensales y crea una nueva comanda asociada a esa mesa y a él mismo.
4. El empleado registra en la comanda los productos que pidieron los comensales, los cuales se componen de diferentes ingredientes según la relación "CONTIENE".
5. La comanda se envía a la cocina, donde se preparan los platillos utilizando los ingredientes correspondientes.
6. El empleado asignado a la comanda recibe los platillos y los sirve a los comensales en la mesa asignada.
7. Al finalizar, se emite la cuenta total de la comanda según los precios de los productos pedidos.
   De esta manera, el restaurante puede llevar un control adecuado de las mesas, las comandas, los pedidos de los comensales, los ingredientes utilizados y los empleados encargados de atender cada comanda, lo que permite un servicio eficiente y una gestión adecuada de los recursos.
