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
            /* Star Rating Styles */
            .star-rating {
                margin-bottom: 1rem;
            }
            .rating-group {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-end;
            }
            .star-input {
                display: none;
            }
            .star-input + label {
                font-size: 1.5rem;
                padding: 0.1rem;
                cursor: pointer;
                color: #ffc107;
            }
            .star-input:checked ~ label i.far.fa-star:before {
                content: "\f005";
                font-weight: 900;
            }
            .star-input + label:hover i.far.fa-star:before,
            .star-input + label:hover ~ label i.far.fa-star:before {
                content: "\f005";
                font-weight: 900;
            }
            .review {
                background-color: #f8f9fa;
                transition: transform 0.2s;
            }
            .review:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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
                                <form action="AddProductComment" method="post" class="mb-4">
                                    <input type="hidden" name="productId" value="${product.productID}">
                                    <div class="mb-3">
                                        <label for="star" class="form-label">Đánh giá của bạn:</label>
                                        <div class="star-rating">
                                            <div class="rating-group">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <div class="star-input">
                                                        <input type="radio" name="star" value="${i}" id="star${i}" ${i == 5 ? 'checked' : ''}>
                                                        <label for="star${i}"><i class="far fa-star"></i></label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="content" class="form-label">Nội dung đánh giá:</label>
                                        <textarea name="content" id="content" class="form-control" rows="4" placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm..." required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Gửi đánh giá
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle me-2"></i>Vui lòng <a href="login.jsp" class="alert-link">đăng nhập</a> để đánh giá sản phẩm.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <h4>Các đánh giá (${reviewCount})</h4>
                        <c:forEach var="review" items="${comments}">
                            <div class="review border p-3 mb-3 rounded">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div>
                                        <strong class="text-primary">${review.user.username}</strong>
                                        <div class="text-warning">
                                            <c:forEach begin="1" end="${review.star}">
                                                <i class="fas fa-star"></i>
                                            </c:forEach>
                                            <c:forEach begin="${review.star + 1}" end="5">
                                                <i class="far fa-star"></i>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <small class="text-muted">${review.dateComment}</small>
                                </div>
                                <p class="mb-0">${review.content}</p>
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
            });
        </script>
    </body>
</html>
