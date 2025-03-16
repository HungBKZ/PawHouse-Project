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
        </style>
    </head>
    <body>
   
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 mt-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h3 class="card-title mb-0">Quản lý Bình luận Sản phẩm</h3>
                        </div>
                        <div class="card-body">
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
                                                <tr>
                                                    <td>${comment.commentID}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <img src="${comment.user.avatar}" alt="Avatar" class="rounded-circle me-2" style="width: 30px; height: 30px;">
                                                            ${comment.user.username}
                                                        </div>
                                                    </td>
                                                    <td>${comment.product.productName}</td>
                                                    <td>
                                                        <div class="star-rating">
                                                            <c:forEach begin="1" end="${comment.star}">
                                                                <i class="fas fa-star"></i>
                                                            </c:forEach>
                                                        </div>
                                                    </td>
                                                    <td>${comment.content}</td>
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
                                                            <button class="btn btn-sm btn-outline-primary toggle-status" 
                                                                    data-id="${comment.commentID}"
                                                                    title="${comment.productCommentStatus ? 'Ẩn bình luận' : 'Hiện bình luận'}">
                                                                <i class="fas fa-toggle-on"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger delete-comment" 
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
            $(document).ready(function() {
                // Cấu hình toastr
                toastr.options = {
                    "closeButton": true,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "timeOut": "3000",
                    "extendedTimeOut": "1000",
                    "preventDuplicates": true,
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };

                // Xóa bình luận
                $('.delete-comment').click(function() {
                    const button = $(this);
                    const commentId = button.data('id');
                    const row = button.closest('tr');
                    
                    if (confirm('Bạn có chắc chắn muốn xóa bình luận này không?')) {
                        button.prop('disabled', true);
                        $.ajax({
                            url: 'admin-comments',
                            type: 'POST',
                            data: {
                                action: 'delete',
                                commentId: commentId
                            },
                            success: function(response) {
                                if (response.success) {
                                    toastr.success(response.message);
                                    row.fadeOut(300, function() { $(this).remove(); });
                                    if ($('tbody tr').length === 1) {
                                        location.reload();
                                    }
                                } else {
                                    toastr.error(response.message);
                                    button.prop('disabled', false);
                                }
                            },
                            error: function() {
                                toastr.error('Đã xảy ra lỗi khi xử lý yêu cầu');
                                button.prop('disabled', false);
                            }
                        });
                    }
                });

                // Chuyển đổi trạng thái bình luận
                $('.toggle-status').click(function() {
                    const button = $(this);
                    const commentId = button.data('id');
                    const row = button.closest('tr');
                    const statusSpan = row.find('td:nth-last-child(2) span');
                    
                    if (confirm('Bạn có muốn thay đổi trạng thái của bình luận này không?')) {
                        button.prop('disabled', true);
                        $.ajax({
                            url: 'admin-comments',
                            type: 'POST',
                            data: {
                                action: 'toggle',
                                commentId: commentId
                            },
                            success: function(response) {
                                if (response.success) {
                                    toastr.success(response.message);
                                    const isCurrentlyActive = statusSpan.hasClass('status-active');
                                    statusSpan.removeClass(isCurrentlyActive ? 'status-active' : 'status-inactive')
                                            .addClass(isCurrentlyActive ? 'status-inactive' : 'status-active')
                                            .html(`<i class="fas fa-circle me-1"></i> \${isCurrentlyActive ? 'Ẩn' : 'Hiện'}`);
                                    button.attr('title', isCurrentlyActive ? 'Hiện bình luận' : 'Ẩn bình luận');
                                } else {
                                    toastr.error(response.message);
                                }
                                button.prop('disabled', false);
                            },
                            error: function() {
                                toastr.error('Đã xảy ra lỗi khi xử lý yêu cầu');
                                button.prop('disabled', false);
                            }
                        });
                    }
                });
            });

            // Hiển thị modal hình ảnh
            function showImageModal(src) {
                const modal = new bootstrap.Modal(document.getElementById('imageModal'));
                document.querySelector('#imageModal .modal-image').src = src;
                modal.show();
            }
        </script>
    </body>
</html>
