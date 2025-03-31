<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.mytech.models.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông Tin Cá Nhân</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .container { min-height: 100vh; display: flex; align-items: center; justify-content: center; }
    .profile-content { text-align: center; padding: 2rem; max-width: 500px; }
    .profile-img { width: 150px; height: 150px; border-radius: 50%; object-fit: cover; }
</style>
</head>
<body>
    <div class="container">
        <div class="profile-content">
            <h1>Thông Tin Cá Nhân</h1>
            <% 
                User user = (User) session.getAttribute("user");
                Long loginTime = (Long) session.getAttribute("loginDate");
                String loginDateStr = "";
                if (loginTime != null) {
                    Date loginDate = new Date(loginTime);
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                    loginDateStr = sdf.format(loginDate);
                }
            %>
            <div class="mt-4">
                <!-- Hiển thị thông báo lỗi nếu có -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>

                <!-- Hiển thị ảnh -->
                <% if (user.getImage() != null && !user.getImage().isEmpty()) { %>
                    <img src="/<%= user.getImage() %>" 
                         alt="Avatar" class="profile-img mb-3">
                <% } else { %>
                    <img src="https://via.placeholder.com/150" alt="Default Avatar" class="profile-img mb-3">
                <% } %>

                <!-- Form Upload -->
                <form action="/profile?action=upload" 
                      method="post" enctype="multipart/form-data" class="mt-3">
                    <div class="mb-3">
                        <label for="imageFile" class="form-label">Chọn ảnh:</label>
                        <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                    </div>
                    <button type="submit" class="btn btn-primary">Upload</button>
                </form>

                <!-- Nút Download -->
                <% if (user.getImage() != null && !user.getImage().isEmpty()) { %>
                    <a href="/profile?action=download" 
                       class="btn btn-success mt-3">Download</a>
                <% } %>

                <p><strong>Tên đăng nhập:</strong> <%= user.getUsername() %></p>
                <p><strong>Vai trò:</strong> <%= user.getRole() %></p>
                <p><strong>Thời gian đăng nhập:</strong> <%= loginDateStr %></p>
                <a href="/index.jsp" class="btn btn-secondary mt-3">Quay lại Trang Chủ</a>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>