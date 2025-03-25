    <%@page import="Model.ProductComment"%>
    <%@page import="java.util.List"%>
    <%@page import="DAO.ProductCommentDAO"%>
    <%@page import="Model.User"%>
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
                /* Enhanced Star Rating Styles */
                .star-rating {
                    margin-bottom: 1rem;
                }
                .rating-group {
                    display: inline-flex;
                    flex-direction: row-reverse;
                    justify-content: flex-end;
                    gap: 0.25rem;
                }
                .star-input {
                    display: none;
                }
                .star-input + label {
                    font-size: 1.5rem;
                    cursor: pointer;
                    color: #ddd;
                    transition: all 0.2s ease;
                }
                .star-input:checked ~ label {
                    color: #ffc107;
                }
                .star-input + label:hover,
                .star-input + label:hover ~ label {
                    color: #ffdb70;
                }

                /* Review Stars Styling */
                .review-stars {
                    color: #ddd;
                    font-size: 1rem;
                }
                .review-stars i {
                    margin-right: 2px;
                }
                .review-stars i.fas {
                    color: #ffc107;
                }
                .review {
                    background-color: #f8f9fa;
                    border-radius: 8px;
                    transition: all 0.3s ease;
                    margin-bottom: 1rem;
                    border: 1px solid #e9ecef;
                }
                .review:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                }
                .review-header {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    margin-bottom: 0.5rem;
                }
                .review-username {
                    font-weight: 600;
                    color: #2c3e50;
                }
                .review-date {
                    color: #6c757d;
                    font-size: 0.875rem;
                }
                .review-content {
                    color: #4a5568;
                    line-height: 1.5;
                }

                /* Star Rating Input Styles */
                .rating-group {
                    display: flex;
                    flex-direction: row-reverse;
                    justify-content: flex-start;
                    gap: 0.5rem;
                    padding: 1rem 0;
                }

                .star-input {
                    display: none;
                }

                .star-label {
                    cursor: pointer;
                    font-size: 2rem;
                    color: #ddd;
                    transition: all 0.2s ease;
                }

                .star-input:checked ~ .star-label {
                    color: #ffc107;
                }

                .star-label:hover,
                .star-label:hover ~ .star-label {
                    color: #ffdb70;
                }

                /* Fix for the hover effect direction */
                .rating-group:hover .star-label {
                    color: #ddd;
                }

                .rating-group:hover .star-label:hover,
                .rating-group:hover .star-label:hover ~ .star-label {
                    color: #ffdb70;
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

                <!-- Display error message if any -->
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("error"); %>
                </c:if>

                <!-- Display success message if any -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <% session.removeAttribute("message"); %>
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
                                           <form id="addToCartForm" action="your-cart-servlet" method="POST">
    <!-- Your existing form inputs -->
    <input type="hidden" name="productId" value="${product.id}">
    <button type="submit" id="addToCartButton" class="btn btn-primary">
        Thêm vào giỏ hàng
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
                                <c:when test="${not empty sessionScope.user || not empty sessionScope.loggedInUser}">
                                    <form action="AddProductComment" method="post" class="mb-4" enctype="multipart/form-data">
                                        <input type="hidden" name="productId" value="${product.productID}">
                                        <div class="mb-3">
                                            <label class="form-label">Đánh giá của bạn:</label>
                                            <div class="star-rating">
                                                <input type="radio" name="star" value="1" class="star-input" id="star1">
                                                <label for="star1" class="star-label"><i class="far fa-star"></i></label>

                                                <input type="radio" name="star" value="2" class="star-input" id="star2">
                                                <label for="star2" class="star-label"><i class="far fa-star"></i></label>

                                                <input type="radio" name="star" value="3" class="star-input" id="star3">
                                                <label for="star3" class="star-label"><i class="far fa-star"></i></label>

                                                <input type="radio" name="star" value="4" class="star-input" id="star4">
                                                <label for="star4" class="star-label"><i class="far fa-star"></i></label>

                                                <input type="radio" name="star" value="5" class="star-input" id="star5">
                                                <label for="star5" class="star-label"><i class="far fa-star"></i></label>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="content" class="form-label">Nội dung:</label>
                                            <textarea class="form-control" id="content" name="content" rows="3" required></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="image" class="form-label">Hình ảnh (không bắt buộc):</label>
                                            <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                            <div id="imagePreview" class="mt-2" style="display: none;">
                                                <img src="" alt="Preview" class="img-fluid" style="max-width: 200px;">
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
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
                                <div class="review p-3" id="review-${review.commentID}">
                                    <div class="review-header d-flex align-items-center justify-content-between">
                                        <div class="d-flex align-items-center gap-2">
                                            <strong class="review-username">${review.user.username}</strong>
                                            <div class="review-stars">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="${i <= review.star ? 'fas' : 'far'} fa-star"></i>
                                                </c:forEach>
                                            </div>
                                            <span class="review-date">${review.dateComment}</span>
                                        </div>

                                        <%-- Debug information --%>
                                        <%
                                            User currentUser = (User) session.getAttribute("user");
                                            if (currentUser == null) {
                                                currentUser = (User) session.getAttribute("loggedInUser");
                                            }
                                            if (currentUser != null) {
                                                pageContext.setAttribute("currentUserId", currentUser.getUserID());
                                            }
                                        %>

                                        <c:if test="${not empty currentUserId && currentUserId == review.user.userID}">
                                            <div class="d-flex gap-2">
                                                <button type="button" class="btn btn-sm btn-outline-primary edit-comment" 
                                                        data-comment-id="${review.commentID}" 
                                                        data-content="${review.content}"
                                                        data-star="${review.star}"
                                                        title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <form action="DeleteComment" method="POST" class="d-inline delete-form">
                                                    <input type="hidden" name="commentId" value="${review.commentID}">
                                                    <button type="button" class="btn btn-sm btn-outline-danger delete-comment" 
                                                            title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="review-content mt-2">
                                        <p>${review.content}</p>
                                        <c:if test="${not empty review.image}">
                                            <img src="${review.image}" alt="Review image" class="img-fluid mt-2" style="max-width: 200px;">
                                        </c:if>
                                    </div>
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

            <!-- Edit Comment Modal -->
            <div class="modal fade" id="editCommentModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa đánh giá</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editCommentForm" enctype="multipart/form-data">
                                <input type="hidden" id="editCommentId" name="commentId">
                                <div class="rating-group mb-3">
                                    <input type="radio" class="star-input" id="editStar5" name="star" value="5">
                                    <label class="star-label" for="editStar5"><i class="fas fa-star"></i></label>
                                    <input type="radio" class="star-input" id="editStar4" name="star" value="4">
                                    <label class="star-label" for="editStar4"><i class="fas fa-star"></i></label>
                                    <input type="radio" class="star-input" id="editStar3" name="star" value="3">
                                    <label class="star-label" for="editStar3"><i class="fas fa-star"></i></label>
                                    <input type="radio" class="star-input" id="editStar2" name="star" value="2">
                                    <label class="star-label" for="editStar2"><i class="fas fa-star"></i></label>
                                    <input type="radio" class="star-input" id="editStar1" name="star" value="1">
                                    <label class="star-label" for="editStar1"><i class="fas fa-star"></i></label>
                                </div>
                                <div class="mb-3">
                                    <label for="editContent" class="form-label">Nội dung đánh giá</label>
                                    <textarea class="form-control" id="editContent" name="content" rows="3" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="editImage" class="form-label">Thay đổi hình ảnh (không bắt buộc)</label>
                                    <input type="file" class="form-control" id="editImage" name="image" accept="image/*">
                                    <div id="editImagePreview" class="mt-2"></div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" form="editCommentForm" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Include Footer -->
            <%@ include file="includes/footer.jsp" %>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

                // Initialize star rating functionality
                function initializeStarRating(container) {
                    const stars = container.querySelectorAll('.star-label');
                    stars.forEach(star => {
                        star.addEventListener('click', function () {
                            const input = this.previousElementSibling;
                            input.checked = true;
                            updateStars(container, input.value);
                        });

                        star.addEventListener('mouseover', function () {
                            const value = this.previousElementSibling.value;
                            updateStars(container, value);
                        });

                        star.addEventListener('mouseout', function () {
                            const checkedInput = container.querySelector('.star-input:checked');
                            updateStars(container, checkedInput ? checkedInput.value : 0);
                        });
                    });
                }

                function updateStars(container, value) {
                    const stars = container.querySelectorAll('.star-label i');
                    stars.forEach((star, index) => {
                        if (index < value) {
                            star.classList.remove('far');
                            star.classList.add('fas');
                        } else {
                            star.classList.remove('fas');
                            star.classList.add('far');
                        }
                    });
                }

                // Initialize star rating for new comment form
                initializeStarRating(document.querySelector('form.mb-4'));

                // Initialize star rating for edit modal
                initializeStarRating(document.querySelector('#editCommentForm'));

                // Handle edit button click
                $('.edit-comment').click(function () {
                    const commentId = $(this).data('comment-id');
                    const content = $(this).data('content');
                    const star = $(this).data('star');

                    $('#editCommentId').val(commentId);
                    $('#editContent').val(content);

                    // Set star rating
                    const editForm = document.querySelector('#editCommentForm');
                    const starInput = editForm.querySelector(`input[value="${star}"]`);
                    if (starInput) {
                        starInput.checked = true;
                        updateStars(editForm, star);
                    }

                    $('#editCommentModal').modal('show');
                });

                // Handle edit form submission
                $('#editCommentForm').on('submit', function (e) {
                    e.preventDefault();
                    const formData = new FormData(this);
                    const commentId = $('#editCommentId').val();

                    $.ajax({
                        url: 'EditComment',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            if (response.success) {
                                const reviewDiv = $(`#review-${commentId}`);
                                const stars = formData.get('star');
                                const content = formData.get('content');

                                // Update stars
                                let starsHtml = '';
                                for (let i = 1; i <= 5; i++) {
                                    starsHtml += `<i class="${i <= stars ? 'fas' : 'far'} fa-star"></i>`;
                                }
                                reviewDiv.find('.review-stars').html(starsHtml);

                                // Update content
                                reviewDiv.find('.review-content p').text(content);

                                // Update image if a new one was uploaded
                                const imageFile = formData.get('image');
                                if (imageFile && imageFile.size > 0) {
                                    // The actual image URL will be set after page reload
                                    location.reload();
                                }

                                // Close modal and show success message
                                $('#editCommentModal').modal('hide');
                                const alertDiv = $(`
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${response.message}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                `);
                                reviewDiv.after(alertDiv);
                                setTimeout(() => alertDiv.alert('close'), 3000);
                            } else {
                                alert(response.message);
                            }
                        },
                        error: function () {
                            alert('Có lỗi xảy ra khi cập nhật đánh giá');
                        }
                    });
                });

                // Image preview for new comment
                document.getElementById('image').addEventListener('change', function(e) {
                    const preview = document.getElementById('imagePreview');
                    preview.innerHTML = '';

                    if (this.files && this.files[0]) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.style.maxWidth = '200px';
                            img.classList.add('img-fluid');
                            preview.appendChild(img);
                        }
                        reader.readAsDataURL(this.files[0]);
                    }
                });

                // Image preview for edit comment
                document.getElementById('editImage').addEventListener('change', function(e) {
                    const preview = document.getElementById('editImagePreview');
                    preview.innerHTML = '';

                    if (this.files && this.files[0]) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.style.maxWidth = '200px';
                            img.classList.add('img-fluid');
                            preview.appendChild(img);
                        }
                        reader.readAsDataURL(this.files[0]);
                    }
                });

                // Delete Comment
                $('.delete-comment').click(function (e) {
                    e.preventDefault();
                    const form = $(this).closest('form');
                    const commentId = form.find('[name="commentId"]').val();
                    const reviewDiv = $(`#review-${commentId}`);

                    const confirmModal = $(`
                        <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Xác nhận xóa</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Bạn có chắc chắn muốn xóa đánh giá này?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="button" class="btn btn-danger" id="confirmDelete">Xóa</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `).appendTo('body');

                    const modal = new bootstrap.Modal(confirmModal);
                    modal.show();

                    $('#confirmDelete').click(function () {
                        $.ajax({
                            url: form.attr('action'),
                            type: 'POST',
                            data: form.serialize(),
                            dataType: 'json',
                            success: function (response) {
                                if (response && response.success) {
                                    modal.hide();
                                    confirmModal.remove();
                                    // Load lại trang sau khi xóa thành công
                                    location.reload();
                                } else {
                                    alert(response ? response.message : 'Có lỗi xảy ra khi xóa đánh giá');
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error('Error:', error);
                                alert('Có lỗi xảy ra khi xóa đánh giá. Vui lòng thử lại sau.');
                            }
                        });
                    });

                    confirmModal.on('hidden.bs.modal', function () {
                        confirmModal.remove();
                    });
                });


            </script>
             <script>
                $(document).ready(function () {
                    // Star rating functionality
                    function initializeStarRating(container) {
                        const stars = container.querySelectorAll('.star-label');
                        stars.forEach(star => {
                            star.addEventListener('click', function () {
                                const input = this.previousElementSibling;
                                input.checked = true;
                                updateStars(container, input.value);
                            });

                            star.addEventListener('mouseover', function () {
                                const value = this.previousElementSibling.value;
                                updateStars(container, value);
                            });

                            star.addEventListener('mouseout', function () {
                                const checkedInput = container.querySelector('.star-input:checked');
                                updateStars(container, checkedInput ? checkedInput.value : 0);
                            });
                        });
                    }

                    function updateStars(container, value) {
                        const stars = container.querySelectorAll('.star-label i');
                        stars.forEach((star, index) => {
                            if (index < value) {
                                star.classList.remove('far');
                                star.classList.add('fas');
                            } else {
                                star.classList.remove('fas');
                                star.classList.add('far');
                            }
                        });
                    }

                    // Initialize star rating for both forms
                    initializeStarRating(document.querySelector('form.mb-4'));
                    initializeStarRating(document.querySelector('#editCommentForm'));

                    // Xử lý form đánh giá sản phẩm
                    $('form[action="AddProductComment"]').on('submit', function (e) {
                        e.preventDefault();

                        var star = $('input[name="star"]:checked').val();
                        if (!star) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'Thông báo',
                                text: 'Vui lòng chọn số sao đánh giá!'
                            });
                            return false;
                        }

                        // Nếu đã chọn sao thì submit form
                        this.submit();
                    });

                    // Xử lý form chỉnh sửa đánh giá
                    $('#editCommentForm').on('submit', function (e) {
                        e.preventDefault();

                        var star = $('#editStar input[name="star"]:checked').val();
                        if (!star) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'Thông báo',
                                text: 'Vui lòng chọn số sao đánh giá!'
                            });
                            return false;
                        }

                        var formData = new FormData(this);
                        $.ajax({
                            url: 'EditComment',
                            type: 'POST',
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function (response) {
                                if (response.success) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Thành công',
                                        text: response.message
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            location.reload();
                                        }
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Lỗi',
                                        text: response.message
                                    });
                                }
                            },
                            error: function () {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Lỗi',
                                    text: 'Có lỗi xảy ra khi cập nhật đánh giá'
                                });
                            }
                        });
                    });

                    // Preview ảnh trước khi upload
                    function readURL(input, previewId) {
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                $(previewId).attr('src', e.target.result);
                                $(previewId).show();
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    $("#image").change(function () {
                        readURL(this, "#imagePreview");
                    });

                    $("#editImage").change(function () {
                        readURL(this, "#editImagePreview");
                    });

                    // Auto-hide alerts after 3 seconds
                    setTimeout(function() {
                        $('.alert').fadeOut('slow');
                    }, 3000);
                });
            </script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // Xử lý sự kiện submit form đánh giá mới
                    document.querySelector("form.mb-4").addEventListener("submit", function (event) {
                        const starChecked = document.querySelector('input[name="star"]:checked');
                        if (!starChecked) {
                            alert("Vui lòng chọn số sao trước khi gửi đánh giá!");
                            event.preventDefault();
                        }
                    });
                });
                // Load lại trang sau khi thêm đánh giá thành công
                document.querySelector("form.mb-4").addEventListener("submit", function (event) {
                    setTimeout(function () {
                        location.reload();
                    }, 500);
                });

                // Load lại trang sau khi chỉnh sửa đánh giá
                document.getElementById("editCommentForm").addEventListener("submit", function (event) {
                    setTimeout(function () {
                        location.reload();
                    }, 500);
                });

                // Load lại trang sau khi xóa đánh giá

            </script>

        </body>
    </html>
