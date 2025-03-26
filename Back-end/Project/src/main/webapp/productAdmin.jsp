<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProductAdmin" %>
<%@ page import="Model.ProductCategories" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - PawHouse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50; /* Xanh đậm trầm */
            --secondary-color: #34495e; /* Xanh xám nhạt */
            --success-color: #27ae60; /* Xanh lá trầm */
            --danger-color: #c0392b; /* Đỏ trầm */
            --light-bg: #ecf0f1; /* Màu nền nhạt */
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        body {
            background: #dfe4ea;
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: var(--primary-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 500;
            color: #F19530;
        }

        .navbar-brand:hover {
            color: #F19530;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        h2 {
            color: var(--primary-color);
            font-weight: 600;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.75rem;
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 2px;
            background: var(--primary-color);
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
        }

        .search-form .form-control {
            border: 1px solid #bdc3c7;
            border-radius: 5px 0 0 5px;
            padding: 8px 12px;
            transition: border-color 0.3s ease;
        }

        .search-form .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }

        .search-form .btn {
            border-radius: 0 5px 5px 0;
            padding: 8px 16px;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        .search-form .btn-success {
            background: var(--success-color);
            border: none;
        }

        .search-form .btn-success:hover {
            opacity: 0.9;
        }

        .table-container {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: var(--primary-color);
            color: #ffffff;
            padding: 12px;
            font-weight: 500;
            text-align: center;
            font-size: 0.95rem;
            border-bottom: none;
        }

        .table td {
            padding: 12px;
            vertical-align: middle;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
            background: #ffffff;
            transition: background 0.3s ease;
        }

        .table tr:hover td {
            background: #f5f6fa;
        }

        .table img {
            max-width: 50px;
            height: auto;
            border-radius: 4px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .btn-success {
            background: var(--success-color);
            border: none;
        }

        .btn-warning {
            background: #e67e22;
            border: none;
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .modal-content {
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        .modal-header {
            background: var(--primary-color);
            color: #ffffff;
            border-bottom: none;
        }

        .modal-title {
            font-weight: 500;
        }

        .modal-body .form-label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .modal-body .form-control, .modal-body .form-select {
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            padding: 8px 12px;
        }

        .modal-body .form-control:focus, .modal-body .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }

        @keyframes subtleFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .table tbody tr {
            animation: subtleFadeIn 0.4s ease-in;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1rem;
            }
            .table th, .table td {
                font-size: 0.85rem;
                padding: 8px;
            }
            .d-flex.justify-content-between {
                flex-direction: column;
                gap: 1rem;
            }
            .search-form {
                width: 100%;
            }
            .search-form .form-control {
                border-radius: 5px;
            }
            .search-form .btn {
                border-radius: 5px;
                margin-top: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
        </div>
    </nav>
    <div class="container">
        <h2>Quản Lý Sản Phẩm</h2>
        <div class="d-flex justify-content-between mb-3 align-items-center">
            <button class="btn btn-primary" onclick="openAddModal()">Thêm Sản Phẩm</button>
            <form method="get" action="/admin/products" class="search-form d-flex gap-2">
                <input type="text" class="form-control" name="search" placeholder="Tìm kiếm theo tên" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit" class="btn btn-success">Tìm</button>
            </form>
        </div>
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Danh Mục</th>
                        <th>Tên</th>
                        <th>Mô Tả</th>
                        <th>Giá</th>
                        <th>Kho</th>
                        <th>Hình ảnh</th>
                        <th>Trạng Thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<ProductAdmin> productList = (List<ProductAdmin>) request.getAttribute("productList");
                       if (productList != null) {
                           for(ProductAdmin product : productList) { %>
                    <tr>
                        <td><%= product.getProductID() %></td>
                        <td><%= product.getCategoryName() %></td>
                        <td><%= product.getProductName() %></td>
                        <td><%= product.getDescription() %></td>
                        <td><%= product.getPrice() %></td>
                        <td><%= product.getStock() %></td>
                        <td>
                            <% if (product.getProductImage() != null && !product.getProductImage().isEmpty()) { %>
                                <img src="<%= request.getContextPath() + "/" + product.getProductImage() %>" alt="<%= product.getProductName() %>">
                            <% } else { %>
                                Không có ảnh
                            <% } %>
                        </td>
                        <td><%= product.getProductStatus() == 1 ? "Hoạt động" : "Không hoạt động" %></td>
                        <td>
                            <div class="d-flex gap-2 justify-content-center">
                                <button class="btn btn-warning" onclick="openEditModal('<%= product.getProductID() %>', '<%= product.getCategoryID() %>', '<%= product.getProductName() %>', '<%= product.getDescription() %>', '<%= product.getPrice() %>', '<%= product.getStock() %>', '<%= product.getProductImage() %>', '<%= product.getProductStatus() %>')">Sửa</button>
                                <form method="post" action="/admin/products" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= product.getProductID() %>">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Sản Phẩm -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="productForm" method="post" action="/admin/products" enctype="multipart/form-data">
                        <input type="hidden" id="action" name="action">
                        <input type="hidden" id="productId" name="id">
                        <div class="mb-3">
                            <label class="form-label">Danh Mục</label>
                            <select class="form-select" id="categoryID" name="categoryID" required>
                                <% List<ProductCategories> categoryList = (List<ProductCategories>) request.getAttribute("categoryList");
                                   if (categoryList != null) {
                                       for(ProductCategories category : categoryList) { %>
                                    <option value="<%= category.getCategoryID() %>"><%= category.getCategoryName() %></option>
                                <% } } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-control" id="productName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô Tả</label>
                            <textarea class="form-control" id="description" name="description" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá</label>
                            <input type="number" class="form-control" id="productPrice" name="price" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Kho</label>
                            <input type="number" class="form-control" id="productStock" name="stock" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="productImage" name="image">
                            <input type="hidden" id="existingImage" name="existingImage">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Trạng Thái</label>
                            <select class="form-select" id="productStatus" name="status" required>
                                <option value="1">Hoạt động</option>
                                <option value="0">Không hoạt động</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success">Lưu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openAddModal() {
            document.getElementById("modalTitle").innerText = "Thêm Sản Phẩm";
            document.getElementById("action").value = "add";
            document.getElementById("productForm").reset();
            document.getElementById("productStock").value = 0; // Default stock là 0
            document.getElementById("productStatus").value = "0"; // Mặc định Không hoạt động
            document.getElementById("productStatus").disabled = true; // Vô hiệu hóa khi thêm mới
            new bootstrap.Modal(document.getElementById("productModal")).show();

            // Gắn sự kiện thay đổi cho stock khi thêm mới
            document.getElementById("productStock").oninput = function() {
                const stock = parseInt(this.value) || 0;
                const statusSelect = document.getElementById("productStatus");
                if (stock > 0) {
                    statusSelect.disabled = false; // Kích hoạt khi stock > 0
                } else {
                    statusSelect.value = "0"; // Đặt về Không hoạt động
                    statusSelect.disabled = true; // Vô hiệu hóa khi stock = 0
                }
            };
        }

        function openEditModal(id, category, name, description, price, stock, image, status) {
            document.getElementById("modalTitle").innerText = "Sửa Sản Phẩm";
            document.getElementById("action").value = "update";
            document.getElementById("productId").value = id;
            document.getElementById("categoryID").value = category;
            document.getElementById("productName").value = name;
            document.getElementById("description").value = description;
            document.getElementById("productPrice").value = price;
            document.getElementById("productStock").value = stock;
            document.getElementById("existingImage").value = image;
            document.getElementById("productStatus").value = status;

            // Logic cho trạng thái khi chỉnh sửa
            const stockValue = parseInt(stock) || 0;
            const statusSelect = document.getElementById("productStatus");
            if (stockValue === 0) {
                statusSelect.value = "0"; // Mặc định Không hoạt động
                statusSelect.disabled = true; // Vô hiệu hóa khi stock = 0
            } else {
                statusSelect.disabled = false; // Kích hoạt khi stock > 0
            }

            new bootstrap.Modal(document.getElementById("productModal")).show();

            // Gắn sự kiện thay đổi cho stock khi chỉnh sửa
            document.getElementById("productStock").oninput = function() {
                const stock = parseInt(this.value) || 0;
                if (stock > 0) {
                    statusSelect.disabled = false; // Kích hoạt khi stock > 0
                } else {
                    statusSelect.value = "0"; // Đặt về Không hoạt động
                    statusSelect.disabled = true; // Vô hiệu hóa khi stock = 0
                }
            };
        }
    </script>
</body>
</html>