<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                String username = (String) session.getAttribute("username");
                if (username != null) { 
            %>
                <div class="mt-4">
                    <h3>Xin chào, <%= username %>!</h3>
                    <a href="LogoutServlet" class="btn btn-danger mt-3">Đăng xuất</a>
                </div>
            <% } else { %>
                <div class="mt-4">
                    <p>Vui lòng đăng nhập để tiếp tục</p>
                    <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>