import sys
import pymysql
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QVBoxLayout, QWidget, QListWidget,
    QListWidgetItem, QPushButton, QLabel, QHBoxLayout, QMessageBox,
    QLineEdit, QFormLayout
)
from PyQt5.QtGui import QFont, QTextDocument
from PyQt5.QtPrintSupport import QPrinter, QPrintDialog, QPrintPreviewDialog
from PyQt5 import QtCore
import platform

# Configuración de la conexión a la base de datos
db_host = 'localhost'
db_user = 'root'
db_password = ''
db_name = 'restaurante'

class FacturaApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.conn = pymysql.connect(host=db_host, user=db_user, password=db_password, db=db_name)
        self.loadCompletedOrders()

    def initUI(self):
        central_widget = QWidget()
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        self.setCentralWidget(central_widget)

        # Crear área de comandas completadas
        orders_layout = QVBoxLayout()
        orders_label = QLabel("Comandas completadas")
        orders_label.setFont(QFont("Arial", 16, QFont.Bold))
        orders_layout.addWidget(orders_label)

        self.orders_list = QListWidget()
        orders_layout.addWidget(self.orders_list)

        main_layout.addLayout(orders_layout)

        # Crear área de factura
        invoice_layout = QFormLayout()
        self.invoice_text = QLineEdit()
        invoice_layout.addRow("Factura:", self.invoice_text)

        main_layout.addLayout(invoice_layout)

        # Crear botones
        button_layout = QHBoxLayout()

        print_button = QPushButton("Imprimir factura")
        print_button.clicked.connect(self.printInvoice)
        button_layout.addWidget(print_button)

        preview_button = QPushButton("Vista previa")
        preview_button.clicked.connect(self.previewInvoice)
        button_layout.addWidget(preview_button)

        refresh_button = QPushButton("Refrescar comandas")
        refresh_button.clicked.connect(self.loadCompletedOrders)
        button_layout.addWidget(refresh_button)

        main_layout.addLayout(button_layout)

    def loadCompletedOrders(self):
        with self.conn.cursor() as cursor:
            sql = "SELECT c.id_comanda, c.id_mesa FROM comanda c WHERE c.completada = 1 AND c.pagado = 0"
            # INNER JOIN contiene_producto_comanda cc ON c.id_comanda = cc.id_comanda WHERE cc.completada=1
            cursor.execute(sql)
            orders = cursor.fetchall()

            self.orders_list.clear()
            for order in orders:
                item = QListWidgetItem(f"Comanda {order[0]}: mesa {order[1]}")
                self.orders_list.addItem(item)

    def generateInvoice(self, order_id):
        with self.conn.cursor() as cursor:
            # Obtener detalles de la comanda
            sql = "SELECT c.descripcion, m.id_mesa, e.nombre AS empleado FROM comanda c INNER JOIN Mesa m ON c.id_mesa = m.id_mesa INNER JOIN Empleado e ON c.id_empleado = e.id_empleado WHERE c.id_comanda = %s"
            cursor.execute(sql, (order_id,))
            order_details = cursor.fetchone()
            
            # Obtener productos de la comanda
            sql = "SELECT p.nombre, p.precio, ccp.cantidad FROM contiene_producto_comanda ccp INNER JOIN Producto p ON ccp.id_producto = p.id_producto WHERE ccp.id_comanda = %s AND ccp.completada = 1"
            cursor.execute(sql, (order_id,))
            order_items = cursor.fetchall()

            invoice_text = f"Factura\n\n"
            invoice_text += f"Comanda: {order_details[0]}\n"
            invoice_text += f"Mesa: {order_details[1]}\n"
            invoice_text += f"Empleado: {order_details[2]}\n\n"
            invoice_text += "Productos:\n"
            total = 0.0
            
            for item in order_items:
                invoice_text += f"{item[0]} - ${item[1]} x {item[2]} : {item[1]*item[2]}\n"
                total += float(item[1]*item[2])

            invoice_text += f"\nTotal: ${total:.2f}"
            return invoice_text

    def printInvoice(self):
        selected_items = self.orders_list.selectedItems()
        if not selected_items:
            QMessageBox.warning(self, "Advertencia", "Por favor, selecciona una comanda para generar la factura.")
            return
        order_id = int(selected_items[0].text().split()[1][:-1])
        invoice_text = self.generateInvoice(order_id)
        self.invoice_text.setText(invoice_text)
        try:
            printer = QPrinter()
            print_dialog = QPrintDialog(printer, self)
            if print_dialog.exec_() == QPrintDialog.Accepted:
                document = QTextDocument()
                document.setPlainText(self.invoice_text.text())
                document.print_(printer)
        except:
            return
        # Crear nueva comanda en la base de datos
        with self.conn.cursor() as cursor:
            sql = "UPDATE comanda SET pagado = 1 WHERE id_comanda = %s"
            cursor.execute(sql, (order_id))
            order_id = cursor.lastrowid
            self.conn.commit()

    def previewInvoice(self):
        selected_items = self.orders_list.selectedItems()
        if not selected_items:
            QMessageBox.warning(self, "Advertencia", "Por favor, selecciona una comanda para generar la vista previa de la factura.")
            return

        order_id = int(selected_items[0].text().split()[1][:-1])
        invoice_text = self.generateInvoice(order_id)
        self.invoice_text.setText(invoice_text)
        print(invoice_text)

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
    factura_app = FacturaApp()
    factura_app.show()
    sys.exit(app.exec_())
