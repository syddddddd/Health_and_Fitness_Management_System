
import psycopg2
from datetime import datetime
import sys
from PyQt5.QtWidgets import \
    QApplication, \
    QMainWindow, \
    QPushButton, \
    QLabel, \
    QDialog, \
    QVBoxLayout, \
    QComboBox, \
    QLineEdit, \
    QHBoxLayout
#from comp3005Functions import *

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.current_user = None

        self.setWindowTitle('Main Window')
        #self.setGeometry(100, 100, 400, 300)
        #self.button_open_dialog = QPushButton('Open Dialog', self)
        #self.button_open_dialog.setGeometry(150, 150, 100, 50)
        #self.button_open_dialog.clicked.connect(self.open_dialog)

        self.open_startup()

    def open_startup(self):
        userChoice = UserChoiceWindow()
        userChoice.show()
        userChoice.exec()
        self.open_login()

    def open_login(self):
        login = LoginWindow()
        login.show()
        login.exec_()


        #dialog.exec_()


class UserChoiceWindow(QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('User Window')

        layout = QVBoxLayout()
        label = QLabel('Choose a something something')
        layout.addWidget(label)

        self.dropdown = QComboBox()
        self.dropdown.addItem("Member")
        self.dropdown.addItem("Trainer")
        self.dropdown.addItem("Admin")
        layout.addWidget(self.dropdown)

        # self.setGeometry(200, 200, 300, 200)
        btn = QPushButton('Open Widget', self)
        # btn.setGeometry(50, 50, 100, 50)
        btn.clicked.connect(self.open_widget)
        layout.addWidget(btn)

        self.setLayout(layout)

    def open_widget(self):
        MainWindow.current_user = self.dropdown.currentText()
        self.accept()



class LoginWindow(QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle(f'{MainWindow.current_user} Login Window')
        #self.setGeometry(300, 300, 200, 150)

        row1 = QHBoxLayout()
        row2 = QHBoxLayout()
        layout = QVBoxLayout()

        label = QLabel(f'username:')
        username = QLineEdit()
        username.setMaxLength(40)
        username.setPlaceholderText("Enter your text")
        row1.addWidget(label)
        row1.addWidget(username)

        label2 = QLabel(f'password:')
        password = QLineEdit()
        password.setMaxLength(40)
        password.setPlaceholderText("Enter your text")
        row2.addWidget(label2)
        row2.addWidget(password)


        layout.addLayout(row1)
        layout.addLayout(row2)

        self.setLayout(layout)


# app = QApplication(sys.argv)
# app.current_user = None
#
# main_w = MainWindow()
# main_w2 = MainWindow()
# # main_window.show()
# #userChoice = userChoiceWindow()
# #widget = WidgetWindow()
#
# #userChoice.show()
# app.exec_()
if __name__ == '__main__':
    app = QApplication(sys.argv)
    app.current_user = None

    main_w = MainWindow()
    # main_window.show()
    # userChoice = userChoiceWindow()
    # widget = WidgetWindow()
    # userChoice.show()
    app.exec_()



    #sys.exit(app.exec_())

# app = QApplication(sys.argv)
#
# label = QLabel('Hello, World!')
# label.show()
#
# widget = QWidget()
#
# sys.exit(app.exec_())

#main()

