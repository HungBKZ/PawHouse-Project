<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProductAdmin" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
            </div>
        </nav>
    <div class="container mt-4">
        <h2 class="text-center">Quản Lý Sản Phẩm</h2>
        <button class="btn btn-primary mb-3" onclick="openAddModal()">Thêm Sản Phẩm</button>
        <table class="table table-bordered">
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
                    <td><%= product.getCategoryID() %></td>
                    <td><%= product.getProductName() %></td>
                    <td><%= product.getDescription() %></td>
                    <td><%= product.getPrice() %></td>
                    <td><%= product.getStock() %></td>
                    <td>
                        <% if (product.getProductImage() != null && !product.getProductImage().isEmpty()) { %>
                            <img src="<%= request.getContextPath() + "/" + product.getProductImage() %>" width="50">
                        <% } else { %>
                            Không có ảnh
                        <% } %>
                    </td>
                    <td><%= product.getProductStatus() %></td>
                    <td>
                        <button class="btn btn-warning" onclick="openEditModal('<%= product.getProductID() %>', '<%= product.getCategoryID() %>', '<%= product.getProductName() %>', '<%= product.getDescription() %>', '<%= product.getPrice() %>', '<%= product.getStock() %>', '<%= product.getProductImage() %>', '<%= product.getProductStatus() %>')">Sửa</button>
                        <form method="post" action="/admin/products" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= product.getProductID() %>">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</button>
                        </form>
                    </td>
                </tr>
                <% } } %>
            </tbody>
        </table>
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
                            <select class="form-control" id="categoryID" name="categoryID" required>
                                <% for(int i = 1; i <= 15; i++) { %>
                                    <option value="<%= i %>"><%= i %></option>
                                <% } %>
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
                            <select class="form-control" id="productStatus" name="status" required>
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
            new bootstrap.Modal(document.getElementById("productModal")).show();
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
            new bootstrap.Modal(document.getElementById("productModal")).show();
        }
    </script>
</body>
</html>