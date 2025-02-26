<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Phụ Kiện Thú Cưng - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
        }

        /* Sidebar Categories */
        .category-sidebar {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .category-sidebar h5 {
            font-weight: bold;
            color: #333;
        }

        .category-sidebar ul li a {
            text-decoration: none;
            color: #333;
            font-size: 1rem;
            display: block;
            padding: 8px 0;
            transition: 0.3s;
        }

        .category-sidebar ul li a:hover {
            color: #ff6600;
            font-weight: bold;
        }

        /* Product Card */
        .product-card {
            background: white;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            transition: 0.3s;
            position: relative;
            overflow: hidden;
        }

        .product-card img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            transition: transform 0.3s;
        }

        .product-card:hover img {
            transform: scale(1.1);
        }

        .product-card h5 {
            font-weight: bold;
            margin-top: 10px;
            font-size: 1.1rem;
        }

        .product-card .price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #ff6600;
        }

        .product-card .btn {
            transition: 0.3s;
            font-size: 0.9rem;
        }

        .product-card .btn:hover {
            transform: scale(1.1);
        }

        /* Search & Sort */
        .search-sort-container {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <!-- Banner -->
    <section class="container-fluid p-0">
        <img src="./imgs/bannerphukien.jpg" class="w-100" alt="Phụ kiện Thú Cưng" />
    </section>

    <!-- Danh sách phụ kiện -->
    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar Categories -->
            <div class="col-md-3">
                <div class="category-sidebar">
                    <h5>Danh Mục</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Tất Cả Sản Phẩm</a></li>
                        <li><a href="#">Vòng Cổ & Dây Dắt</a></li>
                        <li><a href="#">Giường & Đệm</a></li>
                        <li><a href="#">Lồng & Túi Đựng</a></li>
                        <li><a href="#">Dụng Cụ Chăm Sóc</a></li>
                    </ul>
                </div>
            </div>

            <!-- Search and Sort -->
            <div class="col-md-9">
                <div class="search-sort-container d-flex justify-content-between mb-3">
                    <input type="text" class="form-control w-50" id="searchBox" placeholder="Tìm kiếm sản phẩm...">
                    <select class="form-select w-25" id="sortOptions">
                        <option value="name_asc">Tên (A-Z)</option>
                        <option value="name_desc">Tên (Z-A)</option>
                        <option value="price_low">Giá - Thấp đến Cao</option>
                        <option value="price_high">Giá - Cao đến Thấp</option>
                        <option value="newest">Sản phẩm mới nhất</option>
                    </select>
                </div>

                <!-- Product List -->
                <div class="row" id="productGrid">
                    <% List<Product> accessoryList = (List<Product>) request.getAttribute("accessoryList");
                       if (accessoryList != null) {
                           for (Product product : accessoryList) { %>
                    <div class="col-md-4 mb-4 product-item" data-name="<%= product.getProductName() %>" data-price="<%= product.getPrice() %>">
                        <div class="product-card shadow">
                            <img src="<%= product.getProductImage() %>" alt="<%= product.getProductName() %>">
                            <h5><%= product.getProductName() %></h5>
                            <p class="price"><%= product.getPrice() %> VND</p>
                            <button class="btn btn-success w-100">Mua Ngay</button>
                            <a href="addToCart.jsp?id=<%= product.getProductID() %>" class="btn btn-outline-primary w-100 mt-2">
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
        document.getElementById("searchBox").addEventListener("input", function () {
            let searchQuery = this.value.toLowerCase();
            document.querySelectorAll(".product-item").forEach(item => {
                let name = item.getAttribute("data-name").toLowerCase();
                item.style.display = name.includes(searchQuery) ? "block" : "none";
            });
        });

        document.getElementById("sortOptions").addEventListener("change", function () {
            let products = Array.from(document.querySelectorAll(".product-item"));
            let sortBy = this.value;

            products.sort((a, b) => {
                let priceA = parseFloat(a.getAttribute("data-price"));
                let priceB = parseFloat(b.getAttribute("data-price"));
                let nameA = a.getAttribute("data-name").toLowerCase();
                let nameB = b.getAttribute("data-name").toLowerCase();

                return sortBy === "price_low" ? priceA - priceB :
                       sortBy === "price_high" ? priceB - priceA :
                       sortBy === "name_asc" ? nameA.localeCompare(nameB) :
                       sortBy === "name_desc" ? nameB.localeCompare(nameA) : 0;
            });

            let container = document.getElementById("productGrid");
            products.forEach(p => container.appendChild(p));
        });
    </script>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>
