<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thức Ăn Thú Cưng - PawHouse</title>
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

            /* Banner Section */
            .pet-food-banner {
                background: #f2f2f2;
                padding: 60px 0;
                position: relative;
                overflow: hidden;
            }

            /* Tiêu đề chính */
            .banner-text h1 {
                font-size: 60px;
                font-weight: bold;
                color: #ff9900;
            }

            /* Tiêu đề phụ */
            .banner-text h3 {
                font-size: 30px;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }

            /* Mô tả */
            .banner-text p {
                font-size: 16px;
                color: #555;
                max-width: 400px;
                line-height: 1.6;
            }

            /* Hình ảnh thú cưng */
            .banner-image {
                max-width: 100%;
                height: auto;
                position: relative;
            }

            /* Nút ORDER NOW */
            .order-btn {
                position: absolute;
                top: 70%; /* Đưa lên giữa ảnh */
                left: 10%; /* Đưa sang bên trái */
                transform: translateY(-50%); /* Căn giữa theo chiều dọc */
                background: #00a991;
                color: white;
                padding: 15px 40px; /* Kéo dài chiều ngang */
                border-radius: 50px; /* Bo góc tròn */
                font-size: 20px;
                font-weight: bold;
                text-decoration: none;
                box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.2); /* Thêm đổ bóng */
                transition: all 0.3s ease-in-out;
            }

            /* Hiệu ứng hover */
            .order-btn:hover {
                background: #008b76;
                box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.3); /* Đổ bóng mạnh hơn khi hover */
                transform: translateY(-50%) translateX(5px); /* Hiệu ứng dịch chuyển nhẹ khi hover */
            }

            /* Responsive cho màn hình nhỏ */
            @media (max-width: 768px) {
                .order-btn {
                    top: 55%; /* Điều chỉnh vị trí trên mobile */
                    left: 50%;
                    transform: translateX(-50%) translateY(-50%); /* Căn giữa trên màn hình nhỏ */
                    font-size: 18px;
                    padding: 12px 30px;
                }
            }


        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Banner Thức Ăn Thú Cưng -->
        <section class="pet-food-banner">
            <div class="container">
     <!-- Hình ảnh thú cưng bên phải có nút ORDER NOW -->
                <div class=" text-center position-relative">
                    <img src="imgs/dog.jpg" alt="Pet Food" class="banner-image">
                    <a href="products.jsp" class="btn order-btn">ORDER NOW</a>
                </div>
            </div>
        </div>
    </section>


    <!-- Danh sách sản phẩm -->
    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar Categories -->
            <div class="col-md-3">
                <div class="category-sidebar">
                    <h5>Danh Mục</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Thức Ăn Chó</a></li>
                        <li><a href="#">Thức Ăn Mèo</a></li>
                        <li><a href="#">Thức Ăn Chim</a></li>
                        <li><a href="#">Thức Ăn Cá</a></li>
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
                    <% List<Product> foodList = (List<Product>) request.getAttribute("foodList");
                        if (foodList != null) {
                            for (Product product : foodList) {%>
                    <div class="col-md-4 mb-4 product-item" data-name="<%= product.getProductName()%>" data-price="<%= product.getPrice()%>">
                        <div class="product-card shadow">
                            <img src="<%= product.getProductImage()%>" alt="<%= product.getProductName()%>">
                            <h5><%= product.getProductName()%></h5>
                            <p class="price"><%= product.getPrice()%> VND</p>
                            <button class="btn btn-success w-100">Mua Ngay</button>
                            <a href="addToCart.jsp?id=<%= product.getProductID()%>" class="btn btn-outline-primary w-100 mt-2">
                                <i class="bi bi-cart"></i> Thêm vào Giỏ
                            </a>
                        </div>
                    </div>
                    <% }
                    } else { %>
                    <p class="text-center">Không có sản phẩm nào.</p>
                    <% }%>
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
