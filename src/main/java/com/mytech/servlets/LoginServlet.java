package com.mytech.servlets;

import com.mytech.models.User;
import com.mytech.utils.JDBCUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class LoginServlet
*/
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Nếu người dùng truy cập trực tiếp qua GET, chuyển hướng đến trang login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe"); // Lấy giá trị checkbox

        User user = authenticate(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loginDate", System.currentTimeMillis());

            // Thêm cookie nếu chọn "Remember Me"
            if ("on".equals(rememberMe)) {
                Cookie usernameCookie = new Cookie("savedUsername", user.getUsername());
                usernameCookie.setMaxAge(30 * 24 * 60 * 60); // Cookie sống 30 ngày
                response.addCookie(usernameCookie);
            }

            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private User authenticate(String username, String password) {
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?")) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("image"),
                        rs.getString("role")
                    );
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi xác thực user: " + e.getMessage(), e);
        }
        return null;
    }
}
