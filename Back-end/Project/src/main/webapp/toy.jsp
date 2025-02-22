<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đồ Chơi Thú Cưng - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }
        .container {
            margin-top: 20px;
        }
        .category-sidebar {
            background: white;
            padding: 20px;
            border-radius: 10px;
        }
        .product-card {
            background: white;
            padding: 15px;
            border-radius: 10px;
            transition: 0.3s;
            text-align: center;
        }
        .product-card img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .product-card:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
    </style>
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
                    <li class="nav-item"><a class="nav-link active" href="toy.jsp">Đồ Chơi</a></li>
                    <li class="nav-item"><a class="nav-link" href="products.jsp">Sản Phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Dịch Vụ</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Banner -->
    <section class="container-fluid p-0">
        <img src="./imgs/toys.png" class="w-100" alt="Đồ Chơi Thú Cưng" />
    </section>

    <!-- Danh sách sản phẩm -->
    <div class="container">
        <div class="row">
            <!-- Sidebar Categories -->
            <div class="col-md-3">
                <div class="category-sidebar">
                    <h5>Categories</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">All Products</a></li>
                        <li><a href="#">Dog Toys</a></li>
                        <li><a href="#">Cat Toys</a></li>
                        <li><a href="#">Bird Toys</a></li>
                    </ul>
                </div>
            </div>
            <!-- Search and Sort -->
            <div class="col-md-9">
                <div class="d-flex justify-content-between mb-3">
                    <input type="text" class="form-control w-50" id="searchBox" placeholder="Search...">
                    <select class="form-select w-25" id="sortOptions">
                        <option value="name_asc">Name (A-Z)</option>
                        <option value="name_desc">Name (Z-A)</option>
                        <option value="price_low">Price - Low to High</option>
                        <option value="price_high">Price - High to Low</option>
                        <option value="newest">Newest Arrivals</option>
                    </select>
                </div>
                <div class="row" id="productGrid">
                    <% List<Product> toyList = (List<Product>) request.getAttribute("toyList");
                       if (toyList != null) {
                           for (Product product : toyList) { %>
                    <div class="col-md-4 mb-4 product-item" data-name="<%= product.getProductName() %>" data-price="<%= product.getPrice() %>">
                        <div class="product-card">
                            <img src="<%= product.getProductImage() %>" alt="<%= product.getProductName() %>">
                            <h5><%= product.getProductName() %></h5>
                            <p><%= product.getDescription() %></p>
                            <p class="fw-bold text-primary"><%= product.getPrice() %> VND</p>
                            <button class="btn btn-success">Mua Ngay</button>
                            <a href="addToCart.jsp?id=<%= product.getProductID() %>" class="btn btn-outline-primary">
                                <i class="bi bi-cart"></i> Thêm vào Giỏ
                            </a>
                        </div>
                    </div>
                    <% } } else { %>
                    <p class="text-center">Không có sản phẩm nào.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById("searchBox").addEventListener("input", function() {
            let searchQuery = this.value.toLowerCase();
            document.querySelectorAll(".product-item").forEach(item => {
                let name = item.getAttribute("data-name").toLowerCase();
                item.style.display = name.includes(searchQuery) ? "block" : "none";
            });
        });
        
        document.getElementById("sortOptions").addEventListener("change", function() {
            let products = Array.from(document.querySelectorAll(".product-item"));
            let sortBy = this.value;
            
            products.sort((a, b) => {
                let priceA = parseFloat(a.getAttribute("data-price"));
                let priceB = parseFloat(b.getAttribute("data-price"));
                let nameA = a.getAttribute("data-name").toLowerCase();
                let nameB = b.getAttribute("data-name").toLowerCase();
                
                if (sortBy === "price_low") return priceA - priceB;
                if (sortBy === "price_high") return priceB - priceA;
                if (sortBy === "name_asc") return nameA.localeCompare(nameB);
                if (sortBy === "name_desc") return nameB.localeCompare(nameA);
                return 0;
            });
            
            let container = document.getElementById("productGrid");
            products.forEach(p => container.appendChild(p));
        });
    </script>

    <!-- Footer -->
    <footer class="footer bg-dark text-white text-center py-4">
        <p>&copy; 2025 PawHouse. Tất cả các quyền được bảo lưu.</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>