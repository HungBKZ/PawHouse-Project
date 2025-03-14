<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

            /* No Products Found Styling */
            .no-products-found {
                padding: 50px 20px;
                background: #f8f9fa;
                border-radius: 8px;
                margin: 30px auto;
                max-width: 500px;
            }

            .no-products-found i {
                font-size: 48px;
                color: #6c757d;
                margin-bottom: 20px;
            }

            .no-products-found h4 {
                color: #343a40;
                font-size: 24px;
                margin-bottom: 10px;
            }

            .no-products-found p {
                color: #6c757d;
                font-size: 16px;
                margin-bottom: 0;
            }

            /* Pagination styling */
            #pagination {
                margin-top: 2rem;
                margin-bottom: 2rem;
            }

            #pagination button {
                margin: 0 5px;
                padding: 8px 15px;
                border-radius: 5px;
                min-width: 45px;
            }

            #pagination button:hover:not(:disabled) {
                transform: translateY(-2px);
                transition: transform 0.2s;
            }

            #pagination button:disabled {
                cursor: not-allowed;
                opacity: 0.5;
            }

            a {
                text-decoration: none;
                color: inherit;
            }
            .custom-alert {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #4CAF50;
                color: white;
                padding: 15px 20px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                z-index: 1000;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                transition: opacity 0.5s ease;
            }

            .custom-alert.error {
                background-color: #f44336;
            }

            .custom-alert.fade-out {
                opacity: 0;
            }

        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <!-- Banner Thức Ăn Thú Cưng -->
        <section class="pet-food-banner">
            <div class="container text-center position-relative">
                <img src="imgs/dog.jpg" alt="Pet Food" class="banner-image">
                <div class="section-title"></div>
                <a href="products.jsp" class="btn order-btn">ORDER NOW</a>
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
                            <li><a href="FoodProducts?category=">Tất cả danh mục</a></li>
                            <c:forEach var="category" items="${categoryList}">
                                
                                <li> <a href="FoodProducts?category=${category.categoryID}" 
                                        class="${category.categoryID == param.category ? 'active' : ''}">${category.categoryName}</a></li>
                                </c:forEach>
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
                        </select>
                    </div>

                    <!-- Product List -->
                    <div class="row" id="productGrid">
                        <c:choose>
                            <c:when test="${not empty foodList}">
                                <c:forEach var="p" items="${foodList}">

                                    <div class="col-md-4 mb-4 product-item" data-name="${p.productName}" data-price="${p.price}">
                                        <div class="product-card shadow">
                                            <a href="ProductDetail?id=${p.productID}">
                                                <img src="${p.productImage}" class="card-img-top" alt="${p.productName}">
                                                <div class="card-body text-center">
                                                    <h5 class="card-title">${p.productName}</h5>
                                                    <p class="card-text">${p.description}</p>
                                                    <p class="price">${p.price} VND</p>
                                                    <p class="stock">${p.stock} sản phẩm</p>
                                                    <button class="btn btn-success w-100">Mua Ngay</button>
                                                    <button class="btn btn-outline-primary w-100 mt-2 add-to-cart-btn" data-product-id="${p.productID}">
                                                        🛒 Thêm vào Giỏ
                                                    </button>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">Không có sản phẩm nào.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div id="pagination" class="d-flex justify-content-center mt-4"></div>
            </div>
        </div>
    </div>

    <script>
        
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".add-to-cart-btn").forEach(button => {
                button.addEventListener("click", function (event) {
                    event.preventDefault(); // Ngăn chặn điều hướng trang

                    let productId = this.getAttribute("data-product-id");

                    fetch("AddToCart?productId=" + productId + "&quantity=1", {
                        method: "GET"
                    }).then(response => {
                        if (response.ok) {
                            showCustomAlert("Đã thêm sản phẩm vào giỏ hàng!", "success");
                        } else {
                            showCustomAlert("Lỗi khi thêm vào giỏ hàng.", "error");
                        }
                    }).catch(error => {
                        console.error("Error:", error);
                        showCustomAlert("Đã xảy ra lỗi! Vui lòng thử lại.", "error");
                    });
                });
            });
        });

// Hàm hiển thị thông báo đẹp hơn
        function showCustomAlert(message, type) {
            let alertBox = document.createElement("div");
            alertBox.className = `custom-alert ${type}`;
            alertBox.innerText = message;

            document.body.appendChild(alertBox);

            setTimeout(() => {
                alertBox.classList.add("fade-out");
                setTimeout(() => alertBox.remove(), 500);
            }, 2000);
        }
        document.addEventListener("DOMContentLoaded", function () {
            const PRODUCTS_PER_PAGE = 9;
            let currentPage = 1;
            let currentProducts = Array.from(document.querySelectorAll(".product-item"));
            let filteredProducts = [...currentProducts];

            const searchBox = document.getElementById("searchBox");
            const sortOptions = document.getElementById("sortOptions");
            const paginationContainer = document.getElementById("pagination");
            const productGrid = document.getElementById("productGrid");

            searchBox.addEventListener("input", handleSearch);
            sortOptions.addEventListener("change", handleSort);

            function handleSearch() {
                let searchQuery = searchBox.value.toLowerCase().trim();
                filteredProducts = currentProducts.filter(item =>
                    item.getAttribute("data-name").toLowerCase().includes(searchQuery)
                );

                currentPage = 1;
                updateDisplay();
            }

            function handleSort() {
                let sortType = sortOptions.value;

                filteredProducts.sort((a, b) => {
                    let nameA = a.getAttribute("data-name").toLowerCase();
                    let nameB = b.getAttribute("data-name").toLowerCase();
                    let priceA = parseFloat(a.getAttribute("data-price"));
                    let priceB = parseFloat(b.getAttribute("data-price"));

                    switch (sortType) {
                        case "name_asc":
                            return nameA.localeCompare(nameB);
                        case "name_desc":
                            return nameB.localeCompare(nameA);
                        case "price_low":
                            return priceA - priceB;
                        case "price_high":
                            return priceB - priceA;
                        default:
                            return 0;
                    }
                });

                // Reorder elements in the DOM
                filteredProducts.forEach(product => {
                    productGrid.appendChild(product);
                });

                currentPage = 1;
                updateDisplay();
            }

            function updateDisplay() {
                let noProductsMessage = document.getElementById("noProductsMessage");

                // Ẩn tất cả sản phẩm
                currentProducts.forEach(item => item.style.display = "none");

                if (filteredProducts.length === 0) {
                    if (!noProductsMessage) {
                        noProductsMessage = document.createElement("div");
                        noProductsMessage.id = "noProductsMessage";
                        noProductsMessage.className = "col-12 text-center no-products-found";
                        noProductsMessage.innerHTML = `
                        <i class="bi bi-search"></i>
                        <h4>Không tìm thấy sản phẩm</h4>
                        <p>Vui lòng thử tìm kiếm với từ khóa khác</p>
                    `;
                        productGrid.appendChild(noProductsMessage);
                    }
                    noProductsMessage.style.display = "block";
                    paginationContainer.innerHTML = "";
                    paginationContainer.style.display = "none";
                    return;
                } else {
                    if (noProductsMessage)
                        noProductsMessage.style.display = "none";
                }

                showPage(currentPage);
                updatePagination();
            }

            function showPage(page) {
                let start = (page - 1) * PRODUCTS_PER_PAGE;
                let end = start + PRODUCTS_PER_PAGE;

                // Ẩn tất cả sản phẩm trước
                currentProducts.forEach(item => item.style.display = "none");

                // Hiển thị chỉ các sản phẩm trong trang hiện tại
                filteredProducts.slice(start, end).forEach(product => {
                    product.style.display = "";
                });
            }

            function updatePagination() {
                paginationContainer.innerHTML = "";
                let totalPages = Math.ceil(filteredProducts.length / PRODUCTS_PER_PAGE);

                if (totalPages <= 1) {
                    paginationContainer.style.display = "none";
                    return;
                }

                paginationContainer.style.display = "flex";

                addPageButton("&laquo;", () => {
                    if (currentPage > 1) {
                        currentPage--;
                        updateDisplay();
                        scrollToTop();
                    }
                }, currentPage === 1);

                for (let i = 1; i <= totalPages; i++) {
                    addPageButton(i.toString(), () => {
                        currentPage = i;
                        updateDisplay();
                        scrollToTop();
                    }, currentPage === i);
                }

                addPageButton("&raquo;", () => {
                    if (currentPage < totalPages) {
                        currentPage++;
                        updateDisplay();
                        scrollToTop();
                    }
                }, currentPage === totalPages);
            }

            function addPageButton(text, onClick, isActive) {
                let button = document.createElement("button");
                button.className = `btn ${isActive ? "btn-primary" : "btn-outline-primary"} mx-1`;
                button.innerHTML = text;
                button.disabled = isActive;
                button.onclick = onClick;
                paginationContainer.appendChild(button);
            }

            function scrollToTop() {
                document.querySelector('.section-title').scrollIntoView({behavior: 'smooth'});
            }

            // Khởi tạo hiển thị ban đầu
            updateDisplay();
        });

    </script>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>
