<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 - Không Tìm Thấy Trang</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .container {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .error-content {
        text-align: center;
        padding: 2rem;
    }
    .error-code {
        font-size: 6rem;
        font-weight: bold;
        color: #dc3545; /* Màu đỏ của Bootstrap */
    }
</style>
</head>
<body>
    <div class="container">
        <div class="error-content">
            <h1 class="error-code">404</h1>
            <h2>Oops! Trang không tìm thấy</h2>
            <p class="mt-3">Có vẻ như bạn đã đi lạc. Đừng lo, chúng tôi sẽ đưa bạn về nhà!</p>
            <a href="/" class="btn btn-primary mt-4">Quay về Trang Chủ</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>