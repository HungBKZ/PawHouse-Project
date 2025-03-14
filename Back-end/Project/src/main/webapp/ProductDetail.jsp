<%@page import="Model.ProductComment"%>
<%@page import="java.util.List"%>
<%@page import="DAO.ProductCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${product.productName} - Chi tiết sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .product-image {
                max-width: 100%;
                height: auto;
            }
            .related-product-card {
                transition: transform 0.3s;
            }
            .related-product-card:hover {
                transform: translateY(-5px);
            }
            .product-price {
                color: #e44d26;
                font-size: 24px;
                font-weight: bold;
            }
            .stock-status {
                font-size: 14px;
                padding: 5px 10px;
                border-radius: 4px;
            }
            .in-stock {
                background-color: #d4edda;
                color: #155724;
            }
            .out-of-stock {
                background-color: #f8d7da;
                color: #721c24;
            }
            .alert {
                margin-top: 1rem;
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <%@ include file="includes/navbar.jsp" %>

        <div class="container my-5">
            <!-- Display cart message if exists -->
            <c:if test="${not empty sessionScope.cartMessage}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${sessionScope.cartMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("cartMessage");%>
            </c:if>

            <div class="row">
                <!-- Product Details -->
                <div class="col-lg-8">
                    <div class="card">
                        <div class="row g-0">
                            <div class="col-md-6">
                                <img src="${product.productImage}" class="product-image" alt="${product.productName}">
                            </div>
                            <div class="col-md-6">
                                <div class="card-body">
                                    <h2 class="card-title">${product.productName}</h2>
                                    <p class="product-price">₫${product.price}</p>
                                    <span class="stock-status ${product.stock > 0 ? 'in-stock' : 'out-of-stock'}">
                                        ${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}
                                        ${product.stock > 0 ? '(' : ''}${product.stock > 0 ? product.stock : ''}${product.stock > 0 ? ' sản phẩm)' : ''}
                                    </span>

                                    <hr>
                                    <h5>Mô tả sản phẩm:</h5>
                                    <p class="card-text">${product.description}</p>

                                    <c:if test="${product.stock > 0}">
                                        <form action="AddToCart" method="POST" class="d-flex align-items-center">
                                            <input type="hidden" name="productId" value="${product.productID}">
                                            <div class="input-group me-3" style="width: 130px;">
                                                <button class="btn btn-outline-secondary" type="button" onclick="decrementQuantity()">-</button>
                                                <input type="number" class="form-control text-center" id="quantity" name="quantity" value="1" min="1" max="${product.stock}">
                                                <button class="btn btn-outline-secondary" type="button" onclick="incrementQuantity()">+</button>
                                            </div>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ hàng
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card p-3">
                        <h3>Đánh giá sản phẩm</h3>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <form action="AddProductComment" method="post">
                                    <input type="hidden" name="productId" value="${product.productID}">
                                    <label for="star">Số sao:</label>
                                    <select name="star" id="star">
                                        <option value="1">1 sao</option>
                                        <option value="2">2 sao</option>
                                        <option value="3">3 sao</option>
                                        <option value="4">4 sao</option>
                                        <option value="5">5 sao</option>
                                    </select>
                                    <br>
                                    <label for="content">Nội dung:</label>
                                    <textarea name="content" id="content" rows="4"></textarea>
                                    <br>
                                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info">
                                    Vui lòng <a href="login.jsp">đăng nhập</a> để đánh giá sản phẩm.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <h4>Các đánh giá (${reviewCount})</h4>
                        <c:forEach var="review" items="${comments}">
                            <div class="review border p-2 mb-2">
                                <strong>${review.user.username}</strong> - ${review.dateComment}
                                <p>${review.content}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Related Products -->
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Sản phẩm tương tự</h5>
                        </div>
                        <div class="card-body">
                            <c:forEach items="${relatedProducts}" var="relatedProduct">
                                <c:if test="${relatedProduct.productID != product.productID}">
                                    <div class="card mb-3 related-product-card">
                                        <div class="row g-0">
                                            <div class="col-4">
                                                <img src="${relatedProduct.productImage}" class="img-fluid rounded-start" alt="${relatedProduct.productName}">
                                            </div>
                                            <div class="col-8">
                                                <div class="card-body">
                                                    <h6 class="card-title">
                                                        <a href="ProductDetail?id=${relatedProduct.productID}" class="text-decoration-none text-dark">
                                                            ${relatedProduct.productName}
                                                        </a>
                                                    </h6>
                                                    <p class="card-text text-danger fw-bold mb-0">₫${relatedProduct.price}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                    function incrementQuantity() {
                                                        const input = document.getElementById('quantity');
                                                        const max = parseInt(input.getAttribute('max'));
                                                        const currentValue = parseInt(input.value);
                                                        if (currentValue < max) {
                                                            input.value = currentValue + 1;
                                                        }
                                                    }

                                                    function decrementQuantity() {
                                                        const input = document.getElementById('quantity');
                                                        const currentValue = parseInt(input.value);
                                                        if (currentValue > 1) {
                                                            input.value = currentValue - 1;
                                                        }
                                                    }
                                                    // Comment form submission
                                                    $(document).ready(function () {
                                                        $('#commentForm').on('submit', function (e) {
                                                            e.preventDefault();

                                                            $.ajax({
                                                                url: 'comment',
                                                                type: 'POST',
                                                                data: $(this).serialize(),
                                                                dataType: 'json',
                                                                success: function (response) {
                                                                    if (response.success) {
                                                                        // Reload the page to show the new comment
                                                                        location.reload();
                                                                    } else {
                                                                        alert(response.message);
                                                                    }
                                                                },
                                                                error: function () {
                                                                    alert('Có lỗi xảy ra khi gửi đánh giá');
                                                                }
                                                            });
                                                        });
                                                    }};
        </script>
    </body>
</html>
