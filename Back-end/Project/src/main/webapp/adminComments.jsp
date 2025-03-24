<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Bình luận - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastr@2.1.4/build/toastr.min.css">
        <style>
            .star-rating {
                color: #ffc107;
            }
            .comment-image {
                max-width: 100px;
                max-height: 100px;
                object-fit: cover;
                cursor: pointer;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: transform 0.2s;
            }
            .comment-image:hover {
                transform: scale(1.05);
            }
            .status-active {
                color: #198754;
                font-weight: 500;
            }
            .status-inactive {
                color: #dc3545;
                font-weight: 500;
            }
            .modal-image {
                max-width: 100%;
                height: auto;
                border-radius: 12px;
            }
            .btn-group .btn {
                margin: 0 2px;
                transition: all 0.2s;
            }
            .btn-group .btn:hover {
                transform: translateY(-1px);
            }
            .table th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
            }
            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: #6c757d;
            }
            .empty-state i {
                font-size: 48px;
                margin-bottom: 20px;
            }
            .alert {
                border-radius: 8px;
                margin-bottom: 20px;
            }
            .filter-section {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }
            .filter-section .form-control {
                border-radius: 6px;
            }
            .filter-section .btn {
                border-radius: 6px;
            }
            .star-filter {
                display: inline-block;
                cursor: pointer;
                color: #dee2e6;
                font-size: 1.2rem;
            }
            .star-filter.active {
                color: #ffc107;
            }
            .hidden {
                display: none !important;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 mt-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h3 class="card-title mb-0">Quản lý Bình luận Sản phẩm</h3>
                        </div>
                        <div class="card-body">
                            <!-- Filter Section -->
                            <div class="filter-section">
                                <div class="row g-3">
                                    <div class="col-md-2">
                                        <label class="form-label">Tên sản phẩm</label>
                                        <input type="text" class="form-control" id="productFilter" placeholder="Lọc theo tên sản phẩm">
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label">Nội dung bình luận</label>
                                        <input type="text" class="form-control" id="contentFilter" placeholder="Lọc theo nội dung">
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Đánh giá sao</label>
                                        <div class="star-rating-filter">
                                            <span class="star-filter" data-rating="1"><i class="fas fa-star"></i></span>
                                            <span class="star-filter" data-rating="2"><i class="fas fa-star"></i></span>
                                            <span class="star-filter" data-rating="3"><i class="fas fa-star"></i></span>
                                            <span class="star-filter" data-rating="4"><i class="fas fa-star"></i></span>
                                            <span class="star-filter" data-rating="5"><i class="fas fa-star"></i></span>
                                            <button class="btn btn-sm btn-outline-secondary ms-2" id="clearStarFilter">
                                                <i class="fas fa-times"></i> Xóa
                                            </button>
                                        </div>
                                       
                                    </div>
                                     <div class="col-md-3">
                                        <label class="form-label">Lọc theo ngày</label>
                                        <input type="date" class="form-control" id="dateFilter">
                                    </div>
                                    
                                    <div class="col-md-2 d-flex align-items-end">
                                        <button class="btn btn-primary w-100" id="resetFilters">
                                            <i class="fas fa-sync-alt"></i> Đặt lại bộ lọc
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not empty message}">
                                <div class="empty-state">
                                    <i class="fas fa-comments"></i>
                                    <p class="h5">${message}</p>
                                </div>
                            </c:if>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    ${error}
                                </div>
                            </c:if>

                            <c:if test="${not empty comments}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Người dùng</th>
                                                <th>Sản phẩm</th>
                                                <th>Đánh giá</th>
                                                <th>Nội dung</th>
                                                <th>Hình ảnh</th>
                                                <th>Ngày bình luận</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${comments}" var="comment">
                                                <tr class="comment-row" data-comment-date="${comment.dateComment}">
                                                    <td>${comment.commentID}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${comment.user.avatar}" alt="Avatar" class="rounded-circle me-2" style="width: 30px; height: 30px;">
                                                            ${comment.user.username}
                                                        </div>
                                                    </td>
                                                    <td class="product-name">${comment.product.productName}</td>
                                                    <td>
                                                        <div class="star-rating" data-stars="${comment.star}">
                                                            <c:forEach begin="1" end="${comment.star}">
                                                                <i class="fas fa-star"></i>
                                                            </c:forEach>
                                                        </div>
                                                    </td>
                                                    <td class="comment-content">${comment.content}</td>
                                                    <td>
                                                        <c:if test="${not empty comment.image}">
                                                            <img src="${comment.image}" alt="Comment Image" class="comment-image" onclick="showImageModal(this.src)">
                                                        </c:if>
                                                    </td>
                                                    <td>${comment.dateComment}</td>
                                                    <td>
                                                        <span class="${comment.productCommentStatus ? 'status-active' : 'status-inactive'}">
                                                            <i class="fas fa-circle me-1"></i>
                                                            ${comment.productCommentStatus ? 'Hiện' : 'Ẩn'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group">
                                                            <button type="button" class="btn btn-sm btn-outline-primary toggle-status" 
                                                                    data-id="${comment.commentID}" 
                                                                    title="${comment.productCommentStatus ? 'Ẩn bình luận' : 'Hiện bình luận'}">
                                                                <i class="fas fa-toggle-${comment.productCommentStatus ? 'on' : 'off'}"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-sm btn-outline-danger delete-comment" 
                                                                    data-id="${comment.commentID}" 
                                                                    title="Xóa bình luận">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for displaying full-size images -->
        <div class="modal fade" id="imageModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Hình ảnh đầy đủ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body text-center p-3">
                        <img src="" class="modal-image" alt="Full size image">
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/toastr@2.1.4/build/toastr.min.js"></script>
        <script>
            $(document).ready(function () {
                // Cấu hình toastr
                toastr.options = {
                    "closeButton": true,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "timeOut": "3000"
                };

                // Xử lý lọc theo sao
                let selectedStars = 0;
                $('.star-filter').click(function () {
                    const rating = $(this).data('rating');
                    if (selectedStars === rating) {
                        // Bỏ chọn tất cả sao nếu click lại cùng số sao
                        $('.star-filter').removeClass('active');
                        selectedStars = 0;
                    } else {
                        // Chọn số sao mới
                        $('.star-filter').removeClass('active');
                        $('.star-filter').each(function () {
                            if ($(this).data('rating') <= rating) {
                                $(this).addClass('active');
                            }
                        });
                        selectedStars = rating;
                    }
                    filterComments();
                });

                // Xóa bộ lọc sao
                $('#clearStarFilter').click(function () {
                    $('.star-filter').removeClass('active');
                    selectedStars = 0;
                    filterComments();
                });

                // Lọc theo tên sản phẩm và nội dung (realtime)
                $('#productFilter, #contentFilter').on('input', function () {
                    filterComments();
                });

                // Lọc theo ngày
                $('#dateFilter').on('change', function () {
                    filterComments();
                });

                // Đặt lại tất cả bộ lọc
                $('#resetFilters').click(function () {
                    $('#productFilter').val('');
                    $('#contentFilter').val('');
                    $('#dateFilter').val('');
                    $('.star-filter').removeClass('active');
                    selectedStars = 0;
                    filterComments();
                });

                // Hàm lọc comments
                function filterComments() {
                    const productFilter = $('#productFilter').val().toLowerCase();
                    const contentFilter = $('#contentFilter').val().toLowerCase();
                    const dateFilter = $('#dateFilter').val();

                    $('.comment-row').each(function () {
                        const row = $(this);
                        const productName = row.find('.product-name').text().toLowerCase();
                        const content = row.find('.comment-content').text().toLowerCase();
                        const stars = parseInt(row.find('.star-rating').data('stars'));
                        const commentDate = row.data('comment-date').split(' ')[0]; // Get only the date part

                        const matchesProduct = productName.includes(productFilter);
                        const matchesContent = content.includes(contentFilter);
                        const matchesStars = selectedStars === 0 || stars === selectedStars;
                        const matchesDate = !dateFilter || commentDate === dateFilter;

                        if (matchesProduct && matchesContent && matchesStars && matchesDate) {
                            row.show();
                        } else {
                            row.hide();
                        }
                    });
                }

                // Xử lý toggle trạng thái
                $('.toggle-status').click(function (e) {
                    e.preventDefault();
                    const button = $(this);
                    const commentId = button.data('id');
                    const row = button.closest('tr');

                    $.ajax({
                        url: 'ToggleCommentStatus',
                        type: 'POST',
                        data: {commentId: commentId},
                        success: function (response) {
                            if (response.success) {
                                // Cập nhật trạng thái hiển thị
                                const statusSpan = row.find('.status-active, .status-inactive');
                                const isCurrentlyActive = statusSpan.hasClass('status-active');

                                if (isCurrentlyActive) {
                                    statusSpan.removeClass('status-active').addClass('status-inactive')
                                            .html('<i class="fas fa-circle me-1"></i>Ẩn');
                                    button.find('i').removeClass('fa-toggle-on').addClass('fa-toggle-off');
                                    button.attr('title', 'Hiện bình luận');
                                } else {
                                    statusSpan.removeClass('status-inactive').addClass('status-active')
                                            .html('<i class="fas fa-circle me-1"></i>Hiện');
                                    button.find('i').removeClass('fa-toggle-off').addClass('fa-toggle-on');
                                    button.attr('title', 'Ẩn bình luận');
                                }

                                toastr.success(response.message);
                            } else {
                                toastr.error(response.message);
                            }
                        },
                        error: function () {
                            toastr.error('Có lỗi xảy ra khi thực hiện thao tác');
                        }
                    });
                });

                // Xử lý xóa comment
                $('.delete-comment').click(function () {
                    const commentId = $(this).data('id');
                    const row = $(this).closest('tr');

                    if (confirm('Bạn có chắc muốn xóa bình luận này?')) {
                        $.ajax({
                            url: 'DeleteComment',
                            type: 'POST',
                            data: {commentId: commentId},
                            success: function (response) {
                                try {
                                    // Parse response if it's a string
                                    if (typeof response === 'string') {
                                        response = JSON.parse(response);
                                    }

                                    if (response.success) {
                                        row.fadeOut(400, function () {
                                            $(this).remove();
                                            if ($('.comment-row:visible').length === 0) {
                                                location.reload();
                                            }
                                        });
                                        toastr.success('Đã xóa bình luận thành công!');
                                    } else {
                                        toastr.error(response.message || 'Có lỗi xảy ra khi xóa bình luận!');
                                    }
                                } catch (e) {
                                    console.error('Error parsing response:', e);
                                    toastr.error('Có lỗi xảy ra khi xử lý phản hồi từ server!');
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error('AJAX Error:', status, error);
                                toastr.error('Có lỗi xảy ra khi gửi yêu cầu đến server!');
                            }
                        });
                    }
                });
            });

            // Hiển thị modal hình ảnh
            function showImageModal(src) {
                const modal = new bootstrap.Modal(document.getElementById('imageModal'));
                document.querySelector('.modal-image').src = src;
                modal.show();
            }
        </script>
        
    </body>
</html>
