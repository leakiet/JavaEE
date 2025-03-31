<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.mytech.models.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .container {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .content {
        text-align: center;
        padding: 2rem;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="content">
            <h1>Chào mừng đến với ứng dụng</h1>
            
            <% 
                // Kiểm tra xem người dùng đã đăng nhập chưa
                User user = (User) session.getAttribute("user");
                if (user != null) { 
                	// Lấy loginDate từ session
                    Long loginTime = (Long) session.getAttribute("loginDate");
                    String loginDateStr = "";
                    if (loginTime != null) {
                        // Chuyển mili giây thành định dạng ngày giờ
                        Date loginDate = new Date(loginTime);
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        loginDateStr = sdf.format(loginDate);
                    }
            %>
                <div class="mt-4">
                    <h3>Xin chào, <%= user.getUsername() %>!</h3>
                     <h3>Login at: <%= loginDateStr %>!</h3>
                    <a href="/logout" class="btn btn-danger mt-3">Đăng xuất</a>
                    <a href="/profile" class="btn btn-primary mt-3">Xem thông tin cá nhân</a>
                    <a href="/products" class="btn btn-primary mt-3">Sản Phẩm</a>
                </div>
                
            <% } else { %>
                <div class="mt-4">
                    <p>Vui lòng đăng nhập để tiếp tục</p>
                    <a href="/login" class="btn btn-primary">Đăng nhập</a>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>