import java.sql.*;
import java.util.Scanner;

public class Main {

    // Defined the connection object as a static variable
    public static Connection connection;

    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/COMP3005_Final";
        String user = "postgres";
        String password = "student";

        try {
            Class.forName("org.postgresql.Driver");

            // Initialize the connection object
            connection = DriverManager.getConnection(url, user, password);

            // Check if connected
            /*
            if (connection != null) {
                System.out.println("Connected to PostgreSQL successfully!");
            } else {
                System.out.println("Failed to establish connection.");
            }
            */

            // login
            while (true){

                System.out.println("Health and Fitness Club Management System");
                System.out.println("-----------------------------------------");
                System.out.println("Member login:  0");
                System.out.println("Trainer login: 1");
                System.out.println("Admin login:   2");
                System.out.println("Exit program:  3");
                System.out.println();

                Scanner input = new Scanner(System.in);

                System.out.print("Please enter your choice: ");
                int choice = input.nextInt();

                if (choice == 3){
                    break;
                }

            }

            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
