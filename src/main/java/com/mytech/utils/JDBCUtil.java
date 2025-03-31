package com.mytech.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    // Thông tin kết nối database
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/petshop?allowPublicKeyRetrieval=true&useSSL=false";
    private static final String JDBC_USER = "root"; // Thay bằng username của bạn
    private static final String JDBC_PASSWORD = "Kal27011993"; // Thay bằng password của bạn

    // Load driver chỉ một lần khi class được nạp
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Không tìm thấy MySQL JDBC Driver.", e);
        }
    }

    // Phương thức lấy kết nối
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi kết nối database: " + e.getMessage(), e);
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Trong thực tế, nên dùng logger
            }
        }
    }
}
