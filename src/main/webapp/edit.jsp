<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mytech.models.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh Sửa Sản Phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .container { padding: 2rem; max-width: 600px; }
    .form-group img { width: 100px; height: auto; margin-bottom: 10px; }
</style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Chỉnh Sửa Sản Phẩm</h1>
        <% 
            Product product = (Product) request.getAttribute("product");
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
                return;
            }
        %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="/products?action=update" method="post">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="form-group mb-3">
                <label for="name" class="form-label">Tên sản phẩm</label>
                <input type="text" class="form-control" id="name" name="name" 
                       value="<%= product.getName() %>" required>
            </div>
            <div class="form-group mb-3">
                <label for="image" class="form-label">Hình ảnh</label>
                <img src="<%= product.getImage() %>" alt="<%= product.getName() %>">
                <input type="text" class="form-control" id="image" name="image" 
                       value="<%= product.getImage() %>" required>
            </div>
            <div class="form-group mb-3">
                <label for="price" class="form-label">Giá</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" 
                       value="<%= String.format("%.2f", product.getPrice()) %>" required>
            </div>
            <div class="form-group mb-3">
                <label for="description" class="form-label">Mô tả</label>
                <textarea class="form-control" id="description" name="description" rows="3" required><%= product.getDescription() %></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật</button>
            <a href="/products" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>