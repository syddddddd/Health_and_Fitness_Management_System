
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

        self.currentUser = None
        self.username = None
        self.password = None
        self.id = -1

        self.setWindowTitle('Main Window')
        #self.setGeometry(100, 100, 400, 300)
        #self.button_open_dialog = QPushButton('Open Dialog', self)
        #self.button_open_dialog.setGeometry(150, 150, 100, 50)
        #self.button_open_dialog.clicked.connect(self.open_dialog)

        self.open_startup()

    def open_startup(self):
        userChoice = UserChoiceWindow()
        userChoice.show()

        if userChoice.exec_() == QDialog.Accepted:
            self.currentUser = userChoice.currentUser

            if userChoice.choice == 'register':
                self.open_register()

            else:
                self.open_login()


    def open_login(self):
        login = LoginWindow(self.currentUser)
        login.show()
        login.exec_()

    def open_register(self):
        register = RegisterWindow(self.currentUser)
        register.show()
        register.exec_()

        if self.currentUser == 'Member':
            self.setup_member_profile()

    def setup_member_profile(self):
        profile = SetupMemberProfile(self.currentUser)
        profile.show()
        profile.exec_()

class UserChoiceWindow(QDialog):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('User Window')

        self.currentUser = None
        self.choice = None

        layout = QVBoxLayout()
        label = QLabel('Welcome to blah blah blah!\nWould you like to create a new account or login?')

        self.dropdown = QComboBox()
        self.dropdown.addItem("Member")
        self.dropdown.addItem("Trainer")
        self.dropdown.addItem("Admin")

        reg_btn = QPushButton('Create Account', self)
        log_btn = QPushButton('Log In', self)

        reg_btn.clicked.connect(self.open_register)
        log_btn.clicked.connect(self.open_login)

        layout.addWidget(label)
        layout.addWidget(self.dropdown)
        layout.addWidget(reg_btn)
        layout.addWidget(log_btn)

        self.setLayout(layout)


    def open_register(self):
        self.currentUser = self.dropdown.currentText()
        self.choice = 'register'
        self.accept()

    def open_login(self):
        self.currentUser = self.dropdown.currentText()
        self.choice = 'login'
        self.accept()


class LoginWindow(QDialog):
    def __init__(self, currentUser):
        super().__init__()
        self.setWindowTitle(f'Login Window')
        #self.setGeometry(300, 300, 200, 150)

        row1 = QHBoxLayout()
        row2 = QHBoxLayout()
        layout = QVBoxLayout()

        label = QLabel('username:')
        self.username = QLineEdit()
        self.username.setMaxLength(40)
        self.username.setPlaceholderText("Enter your text")
        row1.addWidget(label)
        row1.addWidget(self.username)

        label2 = QLabel('password:')
        self.password = QLineEdit()
        self.password.setMaxLength(40)
        self.password.setPlaceholderText("Enter your text")
        row2.addWidget(label2)
        row2.addWidget(self.password)

        btn = QPushButton('Log In', self)
        btn.clicked.connect(self.log_in)

        layout.addLayout(row1)
        layout.addLayout(row2)
        layout.addWidget(btn)

        self.setLayout(layout)

    def log_in(self):
        #check username and password
        #if valid accept
        print(f'{self.username.text()}')
        self.accept()

class RegisterWindow(QDialog):
    def __init__(self, currentUser):
        super().__init__()
        self.setWindowTitle(f'Registration Window')

        form = QHBoxLayout()
        col1 = QVBoxLayout()
        col2 = QVBoxLayout()

        personalLabel = QLabel('PERSONAL INFO')
        spaceLabel = QLabel('')
        col1.addWidget(personalLabel)
        col2.addWidget(spaceLabel)

        fnameLabel = QLabel('First Name:')
        self.first = QLineEdit()
        self.first.setMaxLength(40)
        self.first.setPlaceholderText("Enter your text")
        col1.addWidget(fnameLabel)
        col2.addWidget(self.first)

        lnameLabel = QLabel('Last Name:')
        self.last = QLineEdit()
        self.last.setMaxLength(40)
        self.last.setPlaceholderText("Enter your text")
        col1.addWidget(lnameLabel)
        col2.addWidget(self.last)

        userLabel = QLabel('Username:')
        self.username = QLineEdit()
        self.username.setMaxLength(40)
        self.username.setPlaceholderText("Enter your text")
        col1.addWidget(userLabel)
        col2.addWidget(self.username)

        passLabel = QLabel('Password:')
        self.password = QLineEdit()
        self.password.setMaxLength(40)
        self.password.setPlaceholderText("Enter your text")
        col1.addWidget(passLabel)
        col2.addWidget(self.password)

        emailLabel = QLabel('Email:')
        self.email = QLineEdit()
        self.email.setMaxLength(40)
        self.email.setPlaceholderText("Enter your text")
        col1.addWidget(emailLabel)
        col2.addWidget(self.email)

        phoneLabel = QLabel('Phone Number:')
        self.phoneNum = QLineEdit()
        self.phoneNum.setMaxLength(40)
        self.phoneNum.setPlaceholderText("Enter your text")
        col1.addWidget(phoneLabel)
        col2.addWidget(self.phoneNum)

        birthLabel = QLabel('Birthday:')
        self.birthday = QLineEdit()
        self.birthday.setMaxLength(40)
        self.birthday.setPlaceholderText("Enter your text")
        col1.addWidget(birthLabel)
        col2.addWidget(self.birthday)

        if currentUser == 'Trainer':
            genderLabel = QLabel('Gender:')
            self.gender = QComboBox()
            self.gender.addItem('other')
            self.gender.addItem('male')
            self.gender.addItem('female')
            col1.addWidget(genderLabel)
            col2.addWidget(self.gender)

        btn = QPushButton('Register', self)
        btn.clicked.connect(self.registered)
        col1.addWidget(spaceLabel)
        col2.addWidget(btn)

        form.addLayout(col1)
        form.addLayout(col2)

        self.setLayout(form)

    def registered(self):
        #check database if null
        self.accept()

class SetupMemberProfile(QDialog):
    def __init__(self, currentUser):
        super().__init__()
        self.setWindowTitle(f'Fitness Profile')

        form = QHBoxLayout()
        col1 = QVBoxLayout()
        col2 = QVBoxLayout()

        healthLabel = QLabel('HEALTH METRICS')
        spaceLabel = QLabel('')
        col1.addWidget(healthLabel)
        col2.addWidget(spaceLabel)

        currWeightLabel = QLabel('Current Weight:')
        self.currWeight = QLineEdit()
        self.currWeight.setMaxLength(40)
        self.currWeight.setPlaceholderText("Enter your text")
        col1.addWidget(currWeightLabel)
        col2.addWidget(self.currWeight)

        heightLabel = QLabel('Height:')
        self.height = QLineEdit()
        self.height.setMaxLength(40)
        self.height.setPlaceholderText("Enter your text")
        col1.addWidget(heightLabel)
        col2.addWidget(self.height)

        goalLabel = QLabel('GOALS')
        col1.addWidget(goalLabel)
        col2.addWidget(spaceLabel)

        goalWeightLabel = QLabel('Desired Weight:')
        self.goalWeight = QLineEdit()
        self.goalWeight.setMaxLength(40)
        self.goalWeight.setPlaceholderText("Enter your text")
        col1.addWidget(goalWeightLabel)
        col2.addWidget(self.goalWeight)

        distLabel = QLabel('Distance:')
        self.dist = QLineEdit()
        self.dist.setMaxLength(40)
        self.dist.setPlaceholderText("Enter your text")
        col1.addWidget(distLabel)
        col2.addWidget(self.dist)

        timeLabel = QLabel('Time to reach Distance:')
        self.time = QLineEdit()
        self.time.setMaxLength(40)
        self.time.setPlaceholderText("Enter your text")
        col1.addWidget(timeLabel)
        col2.addWidget(self.time)

        form.addLayout(col1)
        form.addLayout(col2)

        self.setLayout(form)







# app = QApplication(sys.argv)
# app.currentUseruser = None
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
    app.currentUser = None

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

