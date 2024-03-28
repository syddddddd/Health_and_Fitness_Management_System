import psycopg2
from datetime import datetime

conn = psycopg2.connect(
    host="localhost",
    database="COMP3005_Final",
    user="postgres",
    password="student"
)

def main():

    while(True):
        print("---------------------------------")
        print("-Enter 0 to quit")
        print("-Enter 1 to display student table")
        print("-Enter 2 to add student")
        print("-Enter 3 to update student email")
        print("-Enter 4 to delete student")
        choice = int(input("Your choice: "))

        print("\n")
        break

main()