<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Yêu Cầu Nhận Nuôi - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
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
            h2 {
                color: #0056b3;
                font-weight: 700;
                letter-spacing: 1px;
            }
            .btn-group .btn {
                border-radius: 25px;
                padding: 8px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-outline-primary {
                border-color: #007bff;
                color: #007bff;
            }
            .btn-outline-primary:hover, .btn-outline-primary.active {
                background: #007bff;
                color: #fff;
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
            }
            .btn-outline-warning {
                border-color: #ffc107;
                color: #ffc107;
            }
            .btn-outline-warning:hover, .btn-outline-warning.active {
                background: #ffc107;
                color: #000;
                box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
            }
            .btn-outline-success {
                border-color: #28a745;
                color: #28a745;
            }
            .btn-outline-success:hover, .btn-outline-success.active {
                background: #28a745;
                color: #fff;
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
            }
            .btn-outline-danger {
                border-color: #dc3545;
                color: #dc3545;
            }
            .btn-outline-danger:hover, .btn-outline-danger.active {
                background: #dc3545;
                color: #fff;
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
            }
            .adoption-card {
                background: #fff;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border-left: 5px solid #007bff;
                animation: slideUp 0.8s ease-out;
            }
            .adoption-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            }
            .pet-image {
                max-height: 200px;
                width: 100%;
                object-fit: cover;
                border-radius: 10px;
                border: 3px solid #007bff;
                transition: transform 0.3s ease;
            }
            .pet-image:hover {
                transform: scale(1.05);
            }
            .pet-info, .customer-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            }
            .customer-info {
                background: #e9ecef;
            }
            .pet-info h4, .customer-info h5 {
                color: #0056b3;
                font-weight: 600;
            }
            .badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.9em;
            }
            .bg-warning {
                background: #ffc107 !important;
                color: #000 !important;
            }
            .bg-success {
                background: #28a745 !important;
                color: #fff !important;
            }
            .bg-danger {
                background: #dc3545 !important;
                color: #fff !important;
            }
            .form-control {
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }
            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
            }
            .btn-success, .btn-danger {
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
            .btn-danger:hover {
                background: #c82333;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-heart"></i> Quản Lý Yêu Cầu Nhận Nuôi Thú Cưng</h2>
                <div class="btn-group">
                    <button class="btn btn-outline-primary" onclick="filterAdoptions('all')">Tất Cả</button>
                    <button class="btn btn-outline-warning" onclick="filterAdoptions('pending')">Đang Chờ</button>
                    <button class="btn btn-outline-success" onclick="filterAdoptions('approved')">Hoàn Thành</button>
                    <button class="btn btn-outline-danger" onclick="filterAdoptions('rejected')">Từ Chối</button>
                </div>
            </div>

            <!-- Success Message -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${empty adoptions}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> Không có yêu cầu nhận nuôi nào.
                </div>
            </c:if>

            <c:forEach items="${adoptions}" var="adoption">
                <div class="adoption-card" data-status="${adoption.adoptionStatus.toLowerCase()}">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="${pageContext.request.contextPath}/${adoption.pet.petImage}" 
                                 alt="${adoption.pet.petName}" 
                                 class="pet-image">
                        </div>
                        <div class="col-md-6">
                            <div class="pet-info">
                                <h4><i class="fas fa-paw"></i> ${adoption.pet.petName}</h4>
                                <p><i class="fas fa-info-circle"></i> <strong>Loài:</strong> ${adoption.pet.species}</p>
                                <p><i class="fas fa-dog"></i> <strong>Giống:</strong> ${adoption.pet.breed}</p>
                                <p><i class="fas fa-birthday-cake"></i> <strong>Tuổi:</strong> ${adoption.pet.age} tuổi</p>
                                <p><i class="fas fa-venus-mars"></i> <strong>Giới tính:</strong> ${adoption.pet.gender}</p>
                            </div>
                            <div class="customer-info">
                                <h5><i class="fas fa-user"></i> Thông Tin Người Yêu Cầu</h5>
                                <p><i class="fas fa-user-tag"></i> <strong>Họ tên:</strong> ${adoption.pet.owner.fullName}</p>
                                <p><i class="fas fa-envelope"></i> <strong>Email:</strong> ${adoption.pet.owner.email}</p>
                                <p><i class="fas fa-calendar-alt"></i> <strong>Ngày yêu cầu:</strong> ${adoption.adoptionDate}</p>
                                <p>
                                    <i class="fas fa-info-circle"></i> <strong>Trạng thái:</strong>
                                    <span class="badge ${adoption.adoptionStatus == 'Đang chờ' ? 'bg-warning' : 
                                                         adoption.adoptionStatus == 'Hoàn thành' ? 'bg-success' : 
                                                         'bg-danger'}">
                                              ${adoption.adoptionStatus}
                                          </span>
                                    </p>
                                    <c:if test="${not empty adoption.notes}">
                                        <p><i class="fas fa-comment"></i> <strong>Ghi chú:</strong> ${adoption.notes}</p>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <c:if test="${adoption.adoptionStatus == 'Đang chờ'}">
                                    <form action="${pageContext.request.contextPath}/staffManageAdoption" method="POST" class="adoption-form">
                                        <input type="hidden" name="adoptionId" value="${adoption.adoptionID}">
                                        <div class="mb-3">
                                            <label for="notes" class="form-label"><i class="fas fa-comment"></i> Ghi chú:</label>
                                            <textarea class="form-control" name="notes" rows="3" required 
                                                      placeholder="Nhập ghi chú về quyết định của bạn..."></textarea>
                                        </div>
                                        <div class="d-grid gap-2">
                                            <button type="submit" name="action" value="approve" class="btn btn-success mb-2">
                                                <i class="fas fa-check"></i> Chấp Nhận
                                            </button>
                                            <button type="submit" name="action" value="reject" class="btn btn-danger">
                                                <i class="fas fa-times"></i> Từ Chối
                                            </button>
                                        </div>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <footer>
                <p>© 2025 PawHouse. Mọi quyền được bảo lưu.</p>
            </footer>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                            function filterAdoptions(status) {
                                let url = '${pageContext.request.contextPath}/staffManageAdoption';
                                if (status === 'pending') {
                                    url += '?status=Pending';
                                } else if (status === 'approved') {
                                    url += '?status=Approved';
                                } else if (status === 'rejected') {
                                    url += '?status=Rejected';
                                }
                                window.location.href = url;
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                // Auto-hide alerts after 5 seconds
                                setTimeout(function () {
                                    const alerts = document.querySelectorAll('.alert');
                                    alerts.forEach(function (alert) {
                                        const bsAlert = new bootstrap.Alert(alert);
                                        bsAlert.close();
                                    });
                                }, 5000);

                                // Update button states based on current filter
                                const urlParams = new URLSearchParams(window.location.search);
                                const currentStatus = urlParams.get('status');
                                if (currentStatus) {
                                    document.querySelectorAll('.btn-group .btn').forEach(btn => {
                                        btn.classList.remove('active');
                                        if (btn.textContent.toLowerCase().includes(currentStatus.toLowerCase())) {
                                            btn.classList.add('active');
                                        }
                                    });
                                } else {
                                    document.querySelector('.btn-group .btn-outline-primary').classList.add('active');
                                }
                            });
            </script>
        </body>
    </html>