<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mytech.models.Product" %> <!-- Thay com.yourpackage bằng package thực tế -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh Sách Sản Phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .container { padding: 2rem; }
    .table img { width: 100px; height: auto; }
    .action-btn { margin-right: 5px; }
</style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Danh Sách Sản Phẩm</h1>
        <a href="products?action=insertProduct" class="btn btn-primary mb-3">Thêm Sản Phẩm</a>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Hình</th>
                    <th>Giá</th>
                    <th>Mô tả</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null) {
                        for (Product product : products) {
                %>
                    <tr>
                        <td><%= product.getId() %></td>
                        <td><%= product.getName() %></td>
                        <td><img src="<%= product.getImage() %>" alt="<%= product.getName() %>"></td>
                        <td><%= String.format("%.2f", product.getPrice()) %> $</td>
                        <td><%= product.getDescription() %></td>
                        <td>
                            <a href="products?action=addCart&id=<%= product.getId() %>" class="btn btn-info btn-sm action-btn">Add To Card</a>
                            <a href="products?action=update&id=<%= product.getId() %>" class="btn btn-warning btn-sm action-btn">Edit</a>
                            <a href="products?action=delete&id=<%= product.getId() %>" class="btn btn-danger btn-sm action-btn" 
                               onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">Delete</a>
                        </td>
                    </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>