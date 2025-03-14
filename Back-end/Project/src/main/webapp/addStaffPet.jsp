<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Thú Cưng - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                padding: 20px;
            }
            .container {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-top: 20px;
            }
            .form-label {
                font-weight: bold;
            }
            .btn-primary {
                background-color: #0056b3;
                border: none;
            }
            .btn-primary:hover {
                background-color: #004494;
            }
            .alert {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-plus-circle"></i> Thêm Thú Cưng Mới</h2>
                <a href="${pageContext.request.contextPath}/StaffPetServlet?action=list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Form thêm thú cưng -->
            <form action="${pageContext.request.contextPath}/StaffPetServlet?action=add" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tên thú cưng <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="petName" required>
                        <div class="invalid-feedback">Vui lòng nhập tên thú cưng</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Loại <span class="text-danger">*</span></label>
                        <select class="form-select" name="categoryID" required>
                            <option value="">Chọn loại thú cưng</option>
                            <option value="1">Chó</option>
                            <option value="2">Mèo</option>
                            <option value="3">Bò sát</option>
                            <option value="4">Gặm nhấm</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn loại thú cưng</div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Loài <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="species" required>
                        <div class="invalid-feedback">Vui lòng nhập loài</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Giống <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="breed" required>
                        <div class="invalid-feedback">Vui lòng nhập giống</div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tuổi <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="age" required min="0">
                        <div class="invalid-feedback">Vui lòng nhập tuổi hợp lệ</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Giới tính <span class="text-danger">*</span></label>
                        <select class="form-select" name="gender" required>
                            <option value="">Chọn giới tính</option>
                            <option value="Đực">Đực</option>
                            <option value="Cái">Cái</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn giới tính</div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ảnh <span class="text-danger">*</span></label>
                        <input type="file" class="form-control" name="petImage" accept="image/*" required>
                        <div class="invalid-feedback">Vui lòng chọn ảnh</div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Trạng thái nhận nuôi</label>
                        <select class="form-select" name="adoptionStatus">
                            <option value="Available">Chưa nhận nuôi</option>
                            <option value="Pending">Đang chờ duyệt</option>
                            <option value="Adopted">Đã nhận nuôi</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email chủ sở hữu</label>
                        <input type="email" class="form-control" name="ownerEmail" id="ownerEmail">
                        <small class="text-muted">Để trống nếu chưa có chủ sở hữu</small>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Dịch vụ sử dụng</label>
                        <select class="form-select" name="inUseService">
                            <option value="NULL">Chưa dùng dịch vụ</option>
                            <c:forEach var="service" items="${services}">
                                <option value="${service.serviceID}">${service.serviceName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-save"></i> Thêm Thú Cưng
                    </button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Form validation
            (function () {
                'use strict'
                var forms = document.querySelectorAll('.needs-validation')
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }
                            form.classList.add('was-validated')
                        }, false)
                    })
            })()

            // Preview image before upload
            document.querySelector('input[type="file"]').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    if (file.type.startsWith('image/')) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            // You can add image preview here if needed
                        }
                        reader.readAsDataURL(file);
                    } else {
                        alert('Vui lòng chọn file ảnh!');
                        this.value = '';
                    }
                }
            });
        </script>
    </body>
</html>
