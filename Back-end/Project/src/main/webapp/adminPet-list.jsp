<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thú Cưng - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50; /* Xanh đậm trầm */
            --secondary-color: #34495e; /* Xanh xám nhạt */
            --success-color: #27ae60; /* Xanh lá trầm */
            --danger-color: #c0392b; /* Đỏ trầm */
            --light-bg: #ecf0f1; /* Màu nền nhạt */
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        body {
            background: #dfe4ea;
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: var(--primary-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 600;
            color: #F19530; /* Đổi từ #ffffff thành #F19530 */
            font-size: 1.5rem;
        }

        /* Đảm bảo không có hiệu ứng hover */
        .navbar-brand:hover {
            color: #F19530; /* Giữ nguyên màu khi hover */
        }

        .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.5);
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 0.8)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
        }

        .nav-link {
            color: #ffffff;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #dfe4ea;
        }

        .nav-item {
            margin-left: 1rem;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #dcdcdc;
        }

        h2 {
            color: var(--primary-color);
            font-weight: 600;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.75rem;
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 2px;
            background: var(--primary-color);
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
        }

        .search-form .form-label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .search-form .form-control, .search-form .form-select {
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            padding: 8px 12px;
            transition: border-color 0.3s ease;
        }

        .search-form .form-control:focus, .search-form .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }

        .search-form .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        .search-form .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .search-form .btn-primary:hover {
            background: var(--secondary-color);
        }

        .search-form .btn-secondary {
            background: #7f8c8d;
            border: none;
        }

        .search-form .btn-secondary:hover {
            background: #95a5a6;
        }

        .table-container {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
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

        .table img {
            max-width: 80px;
            height: auto;
            border-radius: 4px;
        }

        .btn-sm {
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: 500;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
        }

        .btn-success {
            background: var(--success-color);
            border: none;
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
        }

        .btn-sm:hover {
            opacity: 0.9;
        }

        .alert {
            border-radius: 5px;
            margin-bottom: 1.5rem;
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

        .modal-body label {
            font-weight: 500;
            color: var(--primary-color);
        }

        .modal-body .form-control, .modal-body .form-select {
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            padding: 8px 12px;
        }

        .modal-body .form-control:focus, .modal-body .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }

        .modal-footer .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 500;
        }

        @keyframes subtleFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .table tbody tr {
            animation: subtleFadeIn 0.4s ease-in;
        }

        @media (max-width: 991px) {
            .navbar-nav {
                margin-top: 1rem;
            }
            .nav-item {
                margin-left: 0;
                text-align: center;
            }
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1rem;
            }
            .table th, .table td {
                font-size: 0.85rem;
                padding: 8px;
            }
            .search-form .col-md-4, .search-form .col-md-2 {
                margin-bottom: 1rem;
            }
        }
    </style>
    <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/adminDashboard.jsp">PawHouse</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>

    <div class="container">
        <h2>Quản lý Thú Cưng</h2>

        <!-- Thanh tìm kiếm -->
        <form method="get" action="${pageContext.request.contextPath}/admin/pets" class="mb-4 search-form">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label for="petName" class="form-label">Tên thú cưng</label>
                    <input type="text" class="form-control" id="petName" name="petName" value="${param.petName}" placeholder="Nhập tên thú cưng">
                </div>
                <div class="col-md-4">
                    <label for="species" class="form-label">Loài</label>
                    <select class="form-select" id="species" name="species">
                        <option value="">Tất cả</option>
                        <c:forEach var="category" items="${categoryList}">
                            <option value="${category}" ${param.species == category ? 'selected' : ''}>${category}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                </div>
                <div class="col-md-2">
                    <a href="${pageContext.request.contextPath}/admin/pets" class="btn btn-secondary w-100">Xóa bộ lọc</a>
                </div>
            </div>
        </form>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <p class="text-muted mb-0">Tổng số thú cưng: ${fn:length(petList)}</p>
            <button onclick="openModal(null, null, null, null, null, null, null, null, null)" class="btn btn-success">
                <i class="fas fa-plus"></i> Thêm thú cưng
            </button>
        </div>

        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Loài</th>
                        <th>Giống</th>
                        <th>Tuổi</th>
                        <th>Giới tính</th>
                        <th>Ảnh</th>
                        <th>Nhận nuôi</th>
                        <th>UserID</th>
                        <th>Dịch vụ</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pet" items="${petList}">
                        <tr>
                            <td>${pet.petID}</td>
                            <td>${pet.petName}</td>
                            <td>${pet.species}</td>
                            <td>${pet.breed}</td>
                            <td>${pet.age}</td>
                            <td>${pet.gender}</td>
                            <td>
                                <c:if test="${not empty pet.petImage}">
                                    <img src="${pageContext.request.contextPath}/${pet.petImage}" alt="${pet.petName}">
                                </c:if>
                            </td>
                            <td>${pet.adoptionStatus}</td>
                            <td>${pet.userID != null ? pet.userID : 'Không xác định'}</td>
                            <td>${pet.inUseService != null ? pet.inUseService : 'Không xác định'}</td>
                            <td>
                                <button class="btn btn-sm btn-primary mb-1" 
                                        onclick="openModal(
                                            '${pet.petID}',
                                            '${pet.species}',
                                            '${pet.petName}',
                                            '${pet.breed}',
                                            '${pet.age}',
                                            '${pet.gender}',
                                            '${pet.adoptionStatus}',
                                            '${pet.userID}',
                                            '${pet.inUseService}'
                                            )">
                                    <i class="fas fa-edit"></i> Sửa
                                </button>
                                <button onclick="confirmDelete('${pet.petID}', '${pet.petName}')" 
                                        class="btn btn-sm btn-danger mb-1">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="modal fade" id="petModal" tabindex="-1" aria-labelledby="petModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">Thông tin Thú Cưng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="petForm" method="post" action="${pageContext.request.contextPath}/admin/pets" enctype="multipart/form-data">
                        <div class="modal-body">
                            <input type="hidden" id="petID" name="id">
                            <input type="hidden" id="activity" name="action">

                            <div class="mb-3">
                                <label for="name">Tên thú cưng:</label>
                                <input class="form-control" id="name" name="name" required>
                            </div>

                            <div class="mb-3">
                                <label for="species">Loài:</label>
                                <select class="form-select" id="species" name="species" required>
                                    <c:forEach var="category" items="${categoryList}">
                                        <option value="${category}">${category}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="breed">Giống:</label>
                                <input class="form-control" id="breed" name="breed" required>
                            </div>

                            <div class="mb-3">
                                <label for="age">Tuổi:</label>
                                <input type="number" class="form-control" id="age" name="age" min="0" max="20" required>
                            </div>

                            <div class="mb-3">
                                <label for="gender">Giới tính:</label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="Đực">Đực</option>
                                    <option value="Cái">Cái</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="image">Ảnh thú cưng:</label>
                                <input type="file" class="form-control" id="image" name="image">
                            </div>

                            <div class="mb-3">
                                <label for="adoptionStatus">Trạng thái nhận nuôi:</label>
                                <select class="form-select" id="adoptionStatus" name="adoptionStatus" onchange="toggleUserIDField()" required>
                                    <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                                    <option value="Đang chờ duyệt">Đang chờ duyệt</option>
                                    <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                                </select>
                            </div>

                            <div class="mb-3" id="userIDField">
                                <label for="userID">UserID:</label>
                                <select class="form-select" id="userID" name="userID" disabled>
                                    <option value="">Không xác định (NULL)</option>
                                    <c:forEach var="userId" items="${userIds}">
                                        <option value="${userId}">${userId}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="inUseService">Trạng thái dịch vụ:</label>
                                <select class="form-select" id="inUseService" name="inUseService" disabled>
                                    <option value="">Không xác định (NULL)</option>
                                    <option value="Chưa tiến hành">Chưa tiến hành</option>
                                    <option value="Đang tiến hành">Đang tiến hành</option>
                                    <option value="Hoàn thành">Hoàn thành</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-success">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(petId, petName) {
            if (confirm('Bạn chắc chắn muốn xóa thú cưng "' + petName + '"?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/pets?action=delete&id=' + petId;
            }
        }

        function toggleUserIDField() {
            const adoptionStatus = document.getElementById("adoptionStatus").value;
            const userIDSelect = document.getElementById("userID");
            const inUseServiceSelect = document.getElementById("inUseService");

            if (adoptionStatus === "Chưa nhận nuôi" || adoptionStatus === "Đang chờ duyệt") {
                userIDSelect.disabled = true;
                userIDSelect.value = "";
                inUseServiceSelect.disabled = true;
                inUseServiceSelect.value = "";
            } else if (adoptionStatus === "Đã nhận nuôi") {
                userIDSelect.disabled = false;
                inUseServiceSelect.disabled = false;
            }
        }

        function openModal(petID, species, petName, breed, age, gender, adoptionStatus, userID, inUseService) {
            document.getElementById("petForm").reset();
            if (petID) {
                document.getElementById("petID").value = petID;
                document.getElementById("name").value = petName;
                document.getElementById("species").value = species;
                document.getElementById("breed").value = breed;
                document.getElementById("age").value = age;
                document.getElementById("gender").value = gender;
                document.getElementById("adoptionStatus").value = adoptionStatus || "Chưa nhận nuôi";
                document.getElementById("userID").value = userID || "";
                document.getElementById("inUseService").value = inUseService || "";
                document.getElementById("activity").value = "update";
                document.getElementById("modalTitle").textContent = "Cập nhật Thú Cưng";
            } else {
                document.getElementById("petID").value = "";
                document.getElementById("activity").value = "add";
                document.getElementById("modalTitle").textContent = "Thêm Thú Cưng Mới";
                document.getElementById("userID").value = "";
                document.getElementById("inUseService").value = "";
            }
            toggleUserIDField();
            new bootstrap.Modal(document.getElementById('petModal')).show();
        }

        setTimeout(function () {
            document.querySelectorAll('.alert').forEach(function (alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>