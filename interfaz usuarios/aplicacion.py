import sys
import pymysql
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QGridLayout, QLabel, QPushButton, QLineEdit,
    QWidget, QVBoxLayout, QHBoxLayout, QListWidget, QListWidgetItem, QComboBox
)
from PyQt5.QtGui import QPixmap, QFont
from PyQt5.QtCore import Qt

# Configuración de la conexión a la base de datos
db_host = 'localhost'
db_user = 'root'
db_password = ''
db_name = 'restaurante'

class RestaurantApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.cart = []
        self.total = 0.0
        self.conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
        self.loadData()

    def initUI(self):
        # Crear layout principal
        central_widget = QWidget()
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        self.setCentralWidget(central_widget)

        # Crear cuadrícula de productos
        product_grid_layout = QGridLayout()
        main_layout.addLayout(product_grid_layout)

        # Crear carrito de compras
        cart_layout = QVBoxLayout()
        cart_label = QLabel("Carrito de compras")
        cart_label.setFont(QFont("Arial", 14, QFont.Bold))
        cart_layout.addWidget(cart_label)

        self.cart_list = QListWidget()
        cart_layout.addWidget(self.cart_list)

        main_layout.addLayout(cart_layout)

        # Crear sección de total y asignar mesa/empleado
        bottom_layout = QHBoxLayout()

        total_layout = QVBoxLayout()
        total_label = QLabel("Total:")
        total_label.setFont(QFont("Arial", 12, QFont.Bold))
        total_layout.addWidget(total_label)

        self.total_value = QLabel("$0.00")
        total_layout.addWidget(self.total_value)

        bottom_layout.addLayout(total_layout)

        table_layout = QVBoxLayout()
        table_label = QLabel("Asignar mesa:")
        table_label.setFont(QFont("Arial", 12, QFont.Bold))
        table_layout.addWidget(table_label)
        self.table_layout = table_layout
        bottom_layout.addLayout(table_layout)

        employee_layout = QVBoxLayout()
        employee_label = QLabel("Asignar empleado:")
        employee_label.setFont(QFont("Arial", 12, QFont.Bold))
        employee_layout.addWidget(employee_label)
        self.employee_layout = employee_layout
        bottom_layout.addLayout(employee_layout)

        order_button = QPushButton("Crear Orden")
        order_button.clicked.connect(self.createOrder)
        bottom_layout.addWidget(order_button)

        main_layout.addLayout(bottom_layout)

    def loadData(self):
        # Cargar datos de la base de datos
        with self.conn.cursor() as cursor:
            # Obtener productos
            cursor.execute("SELECT id_producto, nombre, descripcion, precio FROM producto")
            self.products = cursor.fetchall()

            # Obtener mesas
            cursor.execute("SELECT id_mesa, capacidad, ubicacion FROM mesa")
            self.tables = cursor.fetchall()

            # Obtener empleados
            cursor.execute("SELECT id_empleado, nombre, direccion FROM empleado")
            self.employees = cursor.fetchall()

        # Actualizar la interfaz de usuario con los datos cargados
        self.updateProductGrid()
        self.updateTableComboBox()
        self.updateEmployeeComboBox()

    def updateProductGrid(self):
        # Crear cuadrícula de productos
        product_grid = QGridLayout()
        row, col = 0, 0
        for product in self.products:
            product_button = QPushButton()
            product_button.setText(f"{product[1]}\n{product[2]}\n${product[3]}")
            product_button.clicked.connect(lambda _, p=product: self.addToCart(p))
            product_grid.addWidget(product_button, row, col)
            col += 1
            if col > 3:
                row += 1
                col = 0

        main_layout = self.centralWidget().layout()
        main_layout.addLayout(product_grid)

    def updateTableComboBox(self):
        self.table_combo = QComboBox()
        for table in self.tables:
            self.table_combo.addItem(f"Mesa {table[0]} (Capacidad: {table[1]}, Ubicación: {table[2]})")
        self.table_layout.addWidget(self.table_combo)

    def updateEmployeeComboBox(self):
        self.employee_combo = QComboBox()
        for employee in self.employees:
            self.employee_combo.addItem(f"{employee[0]} {employee[1]} ({employee[2]})")
        self.employee_layout.addWidget(self.employee_combo)

    def addToCart(self, product):
        item = QListWidgetItem(f"{product[1]} - ${product[3]}")
        self.cart_list.addItem(item)
        self.cart.append(product)
        self.updateTotal()

    def updateTotal(self):
        self.total = sum(item[3] for item in self.cart)
        self.total_value.setText(f"${self.total:.2f}")

    def createOrder(self):
        table_id = self.table_combo.currentText().split(' ')[1]
        employee_id = self.employee_combo.currentText().split(' ')[0]

        # Crear nueva comanda en la base de datos
        with self.conn.cursor() as cursor:
            sql = "INSERT INTO comanda (descripcion, id_mesa, id_empleado) VALUES (%s, %s, %s)"
            description = f"Comanda para la Mesa {table_id}"
            cursor.execute(sql, (description, table_id, employee_id))
            order_id = cursor.lastrowid
            self.conn.commit()

            # Agregar productos a la comanda
            product_dict = {}
            for product in self.cart:
                id_producto = product[0]
                if id_producto in product_dict:
                    product_dict[id_producto] += 1
                else:
                    product_dict[id_producto] = 1
            for product_id, cantidad in product_dict.items():
                row = (order_id, product_id, cantidad)
                sql = "INSERT INTO contiene_producto_comanda (id_comanda, id_producto, cantidad) VALUES (%s, %s, %s)"
                cursor.execute(sql, row)
                self.conn.commit()


        # Limpiar carrito y totales
        self.cart.clear()
        self.cart_list.clear()
        self.total = 0.0
        self.total_value.setText("$0.00")

        print(f"Orden creada con ID: {order_id}")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    restaurant_app = RestaurantApp()
    restaurant_app.show()
    sys.exit(app.exec_())
