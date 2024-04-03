
import psycopg2
from datetime import datetime

conn = psycopg2.connect(
    host="localhost",
    database="Fitness",
    user="postgres",
    password="student"
)


#display student table
def getMemberProfile():
    cur = conn.cursor()
    cur.execute("SELECT * FROM students ORDER by student_id ")
    students = cur.fetchall()

    for student in students:
        print(student)

    conn.commit()
    cur.close()

#add member
def addMember(fname, lname, email, phoneNum, gender, username, password):
    cur = conn.cursor()
    added = False

    try:
        cur.execute(f"INSERT INTO Members (fname, lname, email, phone_number, gender, username, password) VALUES('{fname}','{lname}','{email}','{phoneNum}','{gender}','{username}','{password}');")
        print(f"added new member")
        added = True

    except Exception as e:
        print("cannot add member")
        print(e)

    finally:
        conn.commit()
        cur.close()
        return added

#add Trainer
def addTrainer(fname, lname, email, phoneNum, gender, username, password):
    cur = conn.cursor()
    added = False

    try:
        cur.execute(f"INSERT INTO Trainers (fname, lname, email, phone_number, gender, username, password) VALUES('{fname}','{lname}','{email}','{phoneNum}','{gender}','{username}','{password}');")
        print(f"added new member")
        added = True

    except Exception as e:
        print("cannot add member")
        print(e)

    finally:
        conn.commit()
        cur.close()
        return added

#add Admin
def addAdmin(fname, lname, email, phoneNum, username, password):
    cur = conn.cursor()
    added = False

    try:
        cur.execute(f"INSERT INTO Admins (fname, lname, email, phone_number, username, password) VALUES('{fname}','{lname}','{email}','{phoneNum}','{username}','{password}');")
        print(f"added new member")
        added = True

    except Exception as e:
        print("cannot add member")
        print(e)

    finally:
        conn.commit()
        cur.close()
        return added

#update student email in student table
def updateStudentEmail(student_id, new_email):
    cur = conn.cursor()
    try:
        cur.execute(f"UPDATE students SET email = '{new_email}' WHERE student_id = {student_id};")
        print("email changed\n")

    except Exception as e:
        print("email cannot be changed")
        print(e)

    finally:
        conn.commit()
        cur.close()

#delete student from student table
def deleteStudent(student_id):
    cur = conn.cursor()
    try:
        cur.execute(f"""DELETE from students WHERE student_id = {student_id}""")
        print("student deleted\n")

    except Exception as e:
        print("student cannot be deleted")
        print(e)

    finally:
        conn.commit()
        cur.close()





