<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

                        <!-- Category Filter -->
                        <div class="mb-3">
                            <label for="categoryFilter" class="form-label">Danh mục sản phẩm</label>
                            <select class="form-select mb-3" id="categoryFilter" onchange="window.location.href = 'Product?category=' + this.value">
                                <option value="">Tất cả danh mục</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryID}" ${cat.categoryID == param.category ? 'selected' : ''}>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="sortOptions" class="form-label">Sắp xếp theo</label>
                            <select class="form-select" id="sortOptions">
                                <option value="">Mặc định</option>
                                <option value="name_asc">Tên (A-Z)</option>
                                <option value="name_desc">Tên (Z-A)</option>
                                <option value="price_low">Giá - Thấp đến Cao</option>
                                <option value="price_high">Giá - Cao đến Thấp</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <h2 class="section-title text-center mb-4">Danh Mục Sản Phẩm</h2>
                    <div class="row g-4" id="productGrid">
                        <c:choose>
                            <c:when test="${empty listP}">
                                <div class="col-12">
                                    <div class="no-products-found text-center">
                                        <i class="bi bi-exclamation-circle"></i>
                                        <h4>Không tìm thấy sản phẩm</h4>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${listP}">

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
                                                    <a href="addToCart.jsp?id=${p.productID}" class="btn btn-outline-primary w-100 mt-2">
                                                        <i class="bi bi-cart"> Thêm vào Giỏ</i>
                                                    </a>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div id="pagination" class="d-flex justify-content-center mt-4"></div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <script>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
