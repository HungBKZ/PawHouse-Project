<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Thú Cưng - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background: linear-gradient(135deg, #eef2f7, #d4e1f1);
                font-family: 'Poppins', sans-serif;
                min-height: 100vh;
                padding-bottom: 100px;
                overflow-x: hidden;
            }
            .navbar {
                background: linear-gradient(90deg, #007bff, #004085);
                padding: 1.2rem 2rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            .navbar-brand {
                color: #fff !important;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                transition: all 0.3s ease;
            }
            .navbar-brand:hover {
                color: #ffd700 !important;
                transform: scale(1.05);
            }
            .container {
                margin-top: 40px;
                max-width: 1400px;
                animation: fadeIn 0.8s ease-in-out;
            }
            .search-filters {
                background: #fff;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }
            .form-control, .form-select {
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: #007bff;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
            }
            .btn-primary {
                background: #007bff;
                border: none;
                border-radius: 25px;
                padding: 10px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-primary:hover {
                background: #0056b3;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
            }
            .btn-success {
                background: #28a745;
                border: none;
                border-radius: 25px;
                padding: 10px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-success:hover {
                background: #218838;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
            }
            .card {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                animation: slideUp 1s ease-out;
            }
            .table {
                margin-bottom: 0;
                border-radius: 15px;
                overflow: hidden;
            }
            .table thead {
                background: linear-gradient(90deg, #007bff, #0056b3);
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .table th, .table td {
                vertical-align: middle;
                padding: 15px;
            }
            .table-hover tbody tr:hover {
                background-color: #f1f5f9;
                transition: background-color 0.3s ease;
            }
            .status-available {
                background: #28a745;
                color: #fff;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
            }
            .status-pending {
                background: #ffc107;
                color: #000;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
            }
            .status-adopted {
                background: #17a2b8;
                color: #fff;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
            }
            .status-not-adopted {
                background: #6c757d;
                color: #fff;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
            }
            .pet-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 50%;
                border: 3px solid #007bff;
                transition: transform 0.3s ease;
            }
            .pet-image:hover {
                transform: scale(1.1);
            }
            .btn-warning, .btn-danger {
                border-radius: 50%;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }
            .btn-warning:hover {
                background: #e0a800;
                transform: scale(1.1);
            }
            .btn-danger:hover {
                background: #c82333;
                transform: scale(1.1);
            }
            footer {
                background: linear-gradient(90deg, #0056b3, #003d80);
                color: #fff;
                text-align: center;
                padding: 20px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
                box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.2);
            }
            .alert {
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                animation: slideIn 0.5s ease-in-out;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            @keyframes slideUp {
                from {
                    transform: translateY(50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            @keyframes slideIn {
                from {
                    transform: translateX(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse</a>
            </div>
        </nav>

        <div class="container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Bộ lọc tìm kiếm -->
            <div class="search-filters">
                <form id="searchForm" class="row g-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="searchInput" name="search" 
                               placeholder="Tìm theo tên, loài, giống..." autocomplete="off">
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="categoryFilter">
                            <option value="">Tất cả danh mục</option>
                            <option value="Chó">Chó</option>
                            <option value="Mèo">Mèo</option>
                            <option value="Bò sát">Bò sát</option>
                            <option value="Gặm nhấm">Gặm nhấm</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Chưa nhận nuôi">Chưa nhận nuôi</option>
                            <option value="Đang chờ duyệt">Đang chờ duyệt</option>
                            <option value="Đã nhận nuôi">Đã nhận nuôi</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm Kiếm
                        </button>
                    </div>
                </form>
            </div>

            <!-- Nút Thêm Thú Cưng -->
            <div class="text-end mb-4">
                <a href="${pageContext.request.contextPath}/addStaffPet.jsp" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm Thú Cưng
                </a>
            </div>

            <!-- Bảng danh sách Pet -->
            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Ảnh</th>
                                    <th>Tên</th>
                                    <th>Danh Mục</th>
                                    <th>Loài</th>
                                    <th>Giống</th>
                                    <th>Tuổi</th>
                                    <th>Giới Tính</th>
                                    <th>Trạng Thái</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody id="petTableBody">
                                <c:forEach items="${petList}" var="pet">
                                    <tr class="align-middle">
                                        <td>${pet.petID}</td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/${pet.petImage}" 
                                                 alt="${pet.petName}" class="pet-image" 
                                                 onerror="this.src='${pageContext.request.contextPath}/imgs/avatar/default-pet.jpg'">
                                        </td>
                                        <td>${pet.petName}</td>
                                        <td>${pet.category.categoryName}</td>
                                        <td>${pet.species}</td>
                                        <td>${pet.breed}</td>
                                        <td>${pet.age} tuổi</td>
                                        <td>${pet.gender}</td>
                                        <td>
                                            <span class="badge 
                                                  <c:choose>
                                                      <c:when test="${pet.adoptionStatus eq 'Chưa nhận nuôi'}">status-not-adopted</c:when>
                                                      <c:when test="${pet.adoptionStatus eq 'Đang chờ duyệt'}">status-pending</c:when>
                                                      <c:when test="${pet.adoptionStatus eq 'Đã nhận nuôi'}">status-adopted</c:when>
                                                      <c:otherwise>status-available</c:otherwise>
                                                  </c:choose>">
                                                ${pet.adoptionStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="${pageContext.request.contextPath}/StaffPetServlet?action=edit&petID=${pet.petID}" 
                                                   class="btn btn-warning btn-sm me-1">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-danger btn-sm" 
                                                        onclick="confirmDelete(${pet.petID})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <footer>
            <p class="m-0">© 2025 PawHouse. Mọi quyền được bảo lưu.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                            function confirmDelete(petId) {
                                                                if (confirm('Bạn có chắc chắn muốn xóa thú cưng này không?')) {
                                                                    window.location.href = '${pageContext.request.contextPath}/StaffPetServlet?action=delete&petID=' + petId;
                                                                }
                                                            }

                                                            // Auto-hide alerts after 5 seconds
                                                            document.addEventListener('DOMContentLoaded', function () {
                                                                setTimeout(function () {
                                                                    const alerts = document.querySelectorAll('.alert');
                                                                    alerts.forEach(function (alert) {
                                                                        const bsAlert = new bootstrap.Alert(alert);
                                                                        bsAlert.close();
                                                                    });
                                                                }, 5000);
                                                            });

                                                            // Filter function
                                                            document.getElementById("categoryFilter").addEventListener("change", filterPets);
                                                            document.getElementById("statusFilter").addEventListener("change", filterPets);
                                                            document.getElementById("searchInput").addEventListener("keyup", filterPets);

                                                            function filterPets() {
                                                                let selectedCategory = document.getElementById("categoryFilter").value.toLowerCase();
                                                                let selectedStatus = document.getElementById("statusFilter").value.toLowerCase();
                                                                let searchQuery = document.getElementById("searchInput").value.toLowerCase();

                                                                let rows = document.querySelectorAll("#petTableBody tr");

                                                                rows.forEach(row => {
                                                                    let category = row.cells[3].textContent.toLowerCase();
                                                                    let status = row.cells[8].textContent.toLowerCase();
                                                                    let petName = row.cells[2].textContent.toLowerCase();

                                                                    let categoryMatch = selectedCategory === "" || category.includes(selectedCategory);
                                                                    let statusMatch = selectedStatus === "" || status.includes(selectedStatus);
                                                                    let searchMatch = searchQuery === "" || petName.includes(searchQuery);

                                                                    if (categoryMatch && statusMatch && searchMatch) {
                                                                        row.style.display = "";
                                                                    } else {
                                                                        row.style.display = "none";
                                                                    }
                                                                });
                                                            }
        </script>
    </body>
</html>