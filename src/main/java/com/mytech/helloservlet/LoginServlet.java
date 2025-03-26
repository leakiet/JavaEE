package com.mytech.helloservlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class LoginServlet
*/
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Nếu người dùng truy cập trực tiếp qua GET, chuyển hướng đến trang login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Kiểm tra thông tin đăng nhập (logic mẫu)
        if (username != null && password != null && username.equals("admin") && password.equals("123")) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            // Chuyển hướng đến trang dashboard hoặc trang chính
            response.sendRedirect("index.jsp");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            // Quay lại trang login với thông báo lỗi
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
