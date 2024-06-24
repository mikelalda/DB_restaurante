import sys
import pymysql
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QVBoxLayout, QWidget, QListWidget,
    QListWidgetItem, QPushButton, QLabel, QHBoxLayout, QMessageBox
)
from PyQt5.QtGui import QFont
from PyQt5 import QtCore
import platform

# Configuración de la conexión a la base de datos
db_host = 'localhost'
db_user = 'root'
db_password = ''
db_name = 'restaurante'

class CocinaApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
        self.loadOrders()

    def initUI(self):
        central_widget = QWidget()
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        self.setCentralWidget(central_widget)

        # Crear área de comandas
        orders_layout = QVBoxLayout()
        orders_label = QLabel("Comandas pendientes")
        orders_label.setFont(QFont("Arial", 16, QFont.Bold))
        orders_layout.addWidget(orders_label)

        self.orders_list = QListWidget()
        orders_layout.addWidget(self.orders_list)

        main_layout.addLayout(orders_layout)

        # Crear botón de completar comanda
        complete_layout = QHBoxLayout()
        complete_button = QPushButton("Completar comanda")
        complete_button.clicked.connect(self.completeOrder)
        complete_layout.addWidget(complete_button)

        refresh_button = QPushButton("Refrescar comandas")
        refresh_button.clicked.connect(self.loadOrders)
        complete_layout.addWidget(refresh_button)

        main_layout.addLayout(complete_layout)

    def loadOrders(self):
        with self.conn.cursor() as cursor:
            sql = "SELECT c.id_comanda, c.descripcion FROM comanda c"
            cursor.execute(sql)
            orders = cursor.fetchall()

            self.orders_list.clear()
            for order in orders:
                sql = f"SELECT c.id_producto, c.cantidad FROM contiene_producto_comanda c WHERE c.id_comanda = {order[0]} AND c.completada = 0"
                cursor.execute(sql)
                productos = cursor.fetchall()
                for producto in productos:
                    sql = f"SELECT c.Nombre, c.Descripcion FROM producto c WHERE c.id_producto = {producto[0]}"
                    cursor.execute(sql)
                    elemento = cursor.fetchall()
                    item = QListWidgetItem(f"Comanda {order[0]}-{producto[1]}x {producto[0]}: {elemento[0][0]} - {elemento[0][1]} - {order[1]}")
                    self.orders_list.addItem(item)

    def completeOrder(self):
        selected_items = self.orders_list.selectedItems()
        if not selected_items:
            QMessageBox.warning(self, "Advertencia", "Por favor, selecciona una comanda para completar.")
            return

        with self.conn.cursor() as cursor:
            for item in selected_items:
                comanda = item.text().split('-')[0].split(' ')[-1]
                producto = item.text().split('-')[1].split(':')[0].split(' ')[-1]
                sql = f"UPDATE contiene_producto_comanda SET completada=1 WHERE id_producto={producto} AND id_comanda={comanda}"
                cursor.execute(sql)
                self.conn.commit()

        self.loadOrders()

def load_style_sheet():
    f = QtCore.QFile("interfaz_usuarios/style.css")
    f.open(QtCore.QFile.ReadOnly | QtCore.QFile.Text)
    ts = QtCore.QTextStream(f)
    stylesheet = ts.readAll()
    if platform.system().lower() == 'darwin':  # see issue #12 on github
        mac_fix = '''
        QDockWidget::title
        {
            background-color: #31363b;
            text-align: center;
            height: 12px;
        }
        '''
        stylesheet += mac_fix
    return stylesheet

if __name__ == '__main__':
    app = QApplication(sys.argv)
    app.setStyleSheet(load_style_sheet())
    cocina_app = CocinaApp()
    cocina_app.show()
    sys.exit(app.exec_())
    
