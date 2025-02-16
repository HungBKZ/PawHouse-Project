package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    private static final String serverName = "localhost";
    private static final String dbName = "PawHouseProject";
    private static final String portNumber = "1433";
    private static final String instance = "";
    private static final String userID = "sa";
    private static final String password = "12345";
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}
