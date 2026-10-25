package com.collegeevent.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	private static final String URL =
	    "jdbc:mysql://localhost:3306/college_event_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";


    private static final String USER = "";
    private static final String PASSWORD = ""; // Your MySQL password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                "MySQL JDBC driver is missing from the application's runtime classpath.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}