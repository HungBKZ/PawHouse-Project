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
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
        }

        /* Tiêu đề */
        .section-title {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Product Card */
        .product-card {
            background: white;
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            transition: 0.3s;
            position: relative;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            max-width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 12px;
        }

        .product-card h5 {
            font-weight: bold;
            margin-top: 10px;
            font-size: 1.2rem;
        }

        .product-card .price {
            font-size: 1.3rem;
            font-weight: bold;
            color: #ff6600;
        }

        .product-card .btn {
            font-size: 1rem;
            transition: 0.3s;
        }

        .product-card .btn:hover {
            transform: scale(1.05);
        }

        /* Bộ lọc sản phẩm */
        .filter-container {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <!-- Bộ lọc sản phẩm -->
    <section class="container py-4">
        <div class="row">
            <div class="col-md-4">
                <div class="filter-container">
                    <h5 class="fw-bold">Bộ Lọc Sản Phẩm</h5>
                    <input type="text" class="form-control mb-3" id="searchBox" placeholder="Tìm kiếm sản phẩm...">
                    <select class="form-select" id="sortOptions">
                        <option value="name_asc">Tên (A-Z)</option>
                        <option value="name_desc">Tên (Z-A)</option>
                        <option value="price_low">Giá - Thấp đến Cao</option>
                        <option value="price_high">Giá - Cao đến Thấp</option>
                        <option value="newest">Sản phẩm mới nhất</option>
                    </select>
                </div>
            </div>
            <div class="col-md-8">
                <h2 class="section-title text-center mb-4">Danh Mục Sản Phẩm</h2>
                <div class="row" id="productGrid">
                    <% List<Product> productList = (List<Product>) request.getAttribute("productList");
                       if (productList != null) {
                           for (Product product : productList) { %>
                    <div class="col-md-4 mb-4 product-item" data-name="<%= product.getProductName() %>" data-price="<%= product.getPrice() %>">
                        <div class="product-card shadow">
                            <img src="<%= product.getProductImage() %>" class="card-img-top" alt="<%= product.getProductName() %>">
                            <div class="card-body text-center">
                                <h5 class="card-title"><%= product.getProductName() %></h5>
                                <p class="card-text"><%= product.getDescription() %></p>
                                <p class="price"><%= product.getPrice() %> VND</p>
                                <button class="btn btn-success w-100">Mua Ngay</button>
                                <a href="addToCart.jsp?id=<%= product.getProductID() %>" class="btn btn-outline-primary w-100 mt-2">
                                    <i class="bi bi-cart"></i> Thêm vào Giỏ
                                </a>
                            </div>
                        </div>
                    </div>
                    <% } } else { %>
                    <p class="text-center">Không có sản phẩm nào.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
