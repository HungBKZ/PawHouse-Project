<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PawHouse - Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">PawHouse</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Trang Chủ</a></li>
                    <li class="nav-item"><a class="nav-link active" href="products.jsp">Sản Phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Dịch Vụ</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="bi bi-cart"></i> Giỏ Hàng</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Danh sách sản phẩm -->
    <section class="container py-5">
        <h2 class="text-center mb-4">Danh Mục Sản Phẩm</h2>
        <div class="row">
            <% List<Product> productList = (List<Product>) request.getAttribute("productList");
               if (productList != null) {
                   for (Product product : productList) { %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="<%= product.getProductImage() %>" class="card-img-top" alt="<%= product.getProductName() %>">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= product.getProductName() %></h5>
                        <p class="card-text"><%= product.getDescription() %></p>
                        <p class="fw-bold text-primary"><%= product.getPrice() %> VND</p>
                        <button class="btn btn-success">Mua Ngay</button>
                        <a href="addToCart.jsp?id=<%= product.getProductID() %>" class="btn btn-outline-primary">
                            <i class="bi bi-cart"></i> Thêm vào Giỏ
                        </a>
                    </div>
                </div>
            </div>
            <% } } else { %>
            <p class="text-center">Không có sản phẩm nào.</p>
            <% } %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer bg-dark text-white text-center py-4">
        <p>&copy; 2025 PawHouse. Tất cả các quyền được bảo lưu.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
