<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .login-container {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f5f5f5;
    }
    .login-form {
        width: 100%;
        max-width: 400px;
        padding: 2rem;
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
</style>
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2 class="text-center mb-4">Đăng Nhập</h2>
            
            <!-- Hiển thị thông báo lỗi nếu có -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           placeholder="Nhập tên đăng nhập" required>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Nhập mật khẩu" required>
                </div>
                
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                </div>
                
                <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
            </form>
            
            <div class="mt-3 text-center">
                <a href="register.jsp" class="text-decoration-none">Chưa có tài khoản? Đăng ký</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional, chỉ cần nếu muốn dùng các component tương tác) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>