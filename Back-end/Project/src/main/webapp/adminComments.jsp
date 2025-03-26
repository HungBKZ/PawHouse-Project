<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Bình luận - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastr@2.1.4/build/toastr.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50; /* Xanh đậm trầm */
            --secondary-color: #34495e; /* Xanh xám nhạt */
            --success-color: #27ae60; /* Xanh lá trầm */
            --danger-color: #c0392b; /* Đỏ trầm */
            --light-bg: #ecf0f1; /* Màu nền nhạt */
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --star-color: #e67e22; /* Cam trầm cho sao */
        }

        body {
            background: #dfe4ea;
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: var(--primary-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 500;
            color: #F19530; /* Đổi từ #ffffff thành #F19530 */
        }

        /* Đảm bảo không có hiệu ứng hover */
        .navbar-brand:hover {
            color: #F19530; /* Giữ nguyên màu khi hover */
        }

        .container-fluid {
            max-width: 1300px;
            margin: 2rem auto;
            padding: 0;
        }

        .card {
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        .card-header {
            border-bottom: none;
        }

        .card-title {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1.75rem;
            position: relative;
            text-align: center;
        }

        .card-title::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 2px;
            background: var(--primary-color);
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
        }

        .filter-section {
            background: #ffffff;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #e0e0e0;
            margin-bottom: 1.5rem;
        }

        .filter-section .form-label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .filter-section .form-control {
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            padding: 8px 12px;
            transition: border-color 0.3s ease;
        }

        .filter-section .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }

        .filter-section .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 500;
        }

        .filter-section .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .filter-section .btn-primary:hover {
            background: var(--secondary-color);
        }

        .star-rating-filter {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .star-filter {
            color: #dee2e6;
            font-size: 1.2rem;
            cursor: pointer;
            transition: color 0.2s ease;
        }

        .star-filter.active {
            color: var(--star-color);
        }

        .star-rating {
            color: var(--star-color);
        }

        .comment-image {
            max-width: 80px;
            max-height: 80px;
            object-fit: cover;
            border-radius: 4px;
            cursor: pointer;
            transition: opacity 0.2s ease;
        }

        .comment-image:hover {
            opacity: 0.9;
        }

        .table-container {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
        }

        .table thead th {
            background: var(--primary-color);
            color: #ffffff;
            padding: 12px;
            font-weight: 500;
            text-align: center;
            font-size: 0.95rem;
            border-bottom: none;
        }

        .table td {
            padding: 12px;
            vertical-align: middle;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
            background: #ffffff;
            transition: background 0.3s ease;
        }

        .table tr:hover td {
            background: #f5f6fa;
        }

        .status-active {
            color: var(--success-color);
            font-weight: 500;
        }

        .status-inactive {
            color: var(--danger-color);
            font-weight: 500;
        }

        .btn-group .btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: #ffffff;
        }

        .btn-outline-danger {
            border-color: var(--danger-color);
            color: var(--danger-color);
        }

        .btn-outline-danger:hover {
            background: var(--danger-color);
            color: #ffffff;
        }

        .alert {
            border-radius: 5px;
            margin-bottom: 1.5rem;
        }

        .empty-state {
            text-align: center;
            padding: 2rem;
            color: var(--secondary-color);
        }

        .empty-state i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .modal-content {
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        .modal-header {
            background: var(--primary-color);
            color: #ffffff;
            border-bottom: none;
        }

        .modal-title {
            font-weight: 500;
        }

        .modal-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        @keyframes subtleFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .comment-row {
            animation: subtleFadeIn 0.4s ease-in;
        }

        @media (max-width: 768px) {
            .container-fluid {
                margin: 1rem;
            }
            .filter-section {
                padding: 10px;
            }
            .filter-section .col-md-2, .filter-section .col-md-3 {
                margin-bottom: 1rem;
            }
            .table th, .table td {
                font-size: 0.85rem;
                padding: 8px;
            }
            .comment-image {
                max-width: 60px;
                max-height: 60px;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 mt-4">
                <div class="card">
                    <div class="card-header py-3">
                        <h3 class="card-title">Quản lý Bình luận Sản phẩm</h3>
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
                            <div class="table-container">
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
                                                    <div class="d-flex align-items-center justify-content-center">
                                                        <img src="${comment.user.avatar}" alt="Avatar" class="rounded-circle me-2" style="width: 30px; height: 30px;">
                                                        ${comment.user.fullName} <!-- Thay username bằng fullName -->
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
            toastr.options = {
                "closeButton": true,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "timeOut": "3000"
            };

            let selectedStars = 0;
            $('.star-filter').click(function () {
                const rating = $(this).data('rating');
                if (selectedStars === rating) {
                    $('.star-filter').removeClass('active');
                    selectedStars = 0;
                } else {
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

            $('#clearStarFilter').click(function () {
                $('.star-filter').removeClass('active');
                selectedStars = 0;
                filterComments();
            });

            $('#productFilter, #contentFilter').on('input', function () {
                filterComments();
            });

            $('#dateFilter').on('change', function () {
                filterComments();
            });

            $('#resetFilters').click(function () {
                $('#productFilter').val('');
                $('#contentFilter').val('');
                $('#dateFilter').val('');
                $('.star-filter').removeClass('active');
                selectedStars = 0;
                filterComments();
            });

            function filterComments() {
                const productFilter = $('#productFilter').val().toLowerCase();
                const contentFilter = $('#contentFilter').val().toLowerCase();
                const dateFilter = $('#dateFilter').val();

                $('.comment-row').each(function () {
                    const row = $(this);
                    const productName = row.find('.product-name').text().toLowerCase();
                    const content = row.find('.comment-content').text().toLowerCase();
                    const stars = parseInt(row.find('.star-rating').data('stars'));
                    const commentDate = row.data('comment-date').split(' ')[0];

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
                        error: function () {
                            toastr.error('Có lỗi xảy ra khi gửi yêu cầu đến server!');
                        }
                    });
                }
            });
        });

        function showImageModal(src) {
            const modal = new bootstrap.Modal(document.getElementById('imageModal'));
            document.querySelector('.modal-image').src = src;
            modal.show();
        }
    </script>
</body>
</html>