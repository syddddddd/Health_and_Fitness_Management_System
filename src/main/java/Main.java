import java.sql.*;

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
            if (connection != null) {
                System.out.println("Connected to PostgreSQL successfully!");
            } else {
                System.out.println("Failed to establish connection.");
            }

            // functions can go here

            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
