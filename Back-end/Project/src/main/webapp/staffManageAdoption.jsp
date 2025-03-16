<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý yêu cầu nhận nuôi - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-bottom: 70px;
        }
        .navbar {
            background-color: #0056b3;
        }
        .navbar-brand, .nav-link {
            color: white !important;
            font-weight: bold;
        }
        .container {
            margin-top: 30px;
        }
        .adoption-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .adoption-card:hover {
            transform: translateY(-5px);
        }
        .pet-image {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
        }
        .status-pending {
            color: #ffc107;
        }
        .status-approved {
            color: #28a745;
        }
        .status-rejected {
            color: #dc3545;
        }
        footer {
            text-align: center;
            padding: 20px;
            background-color: #0056b3;
            color: white;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
        .btn-action {
            transition: all 0.3s;
        }
        .btn-action:hover {
            transform: scale(1.05);
        }
        .pet-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .customer-info {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .pet-status {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: 500;
        }
        .status-available {
            background-color: #28a745;
            color: white;
        }
        .status-pending {
            background-color: #ffc107;
            color: black;
        }
        .status-adopted {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/staffIndex.jsp">
                <i class="fas fa-paw"></i> PawHouse Staff
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>
        
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-heart"></i> Quản lý yêu cầu nhận nuôi thú cưng</h2>
            <div class="btn-group">
                <button class="btn btn-outline-primary" onclick="filterAdoptions('all')">Tất cả</button>
                <button class="btn btn-outline-warning" onclick="filterAdoptions('pending')">Đang chờ</button>
                <button class="btn btn-outline-success" onclick="filterAdoptions('approved')">Hoàn thành</button>
                <button class="btn btn-outline-danger" onclick="filterAdoptions('rejected')">Từ chối</button>
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
            <div class="adoption-card p-4 mb-4 border rounded shadow-sm" data-status="${adoption.adoptionStatus.toLowerCase()}">
                <div class="row">
                    <div class="col-md-3">
                        <img src="${pageContext.request.contextPath}/${adoption.pet.petImage}" 
                             alt="${adoption.pet.petName}" 
                             class="img-fluid rounded mb-3"
                             style="max-height: 200px; width: 100%; object-fit: cover;">
                    </div>
                    <div class="col-md-6">
                        <div class="pet-info">
                            <h4><i class="fas fa-paw"></i> ${adoption.pet.petName}</h4>
                            <p><i class="fas fa-info-circle"></i> <strong>Loài:</strong> ${adoption.pet.species}</p>
                            <p><i class="fas fa-dog"></i> <strong>Giống:</strong> ${adoption.pet.breed}</p>
                            <p><i class="fas fa-birthday-cake"></i> <strong>Tuổi:</strong> ${adoption.pet.age} tuổi</p>
                            <p><i class="fas fa-venus-mars"></i> <strong>Giới tính:</strong> ${adoption.pet.gender}</p>
                        </div>
                        <div class="customer-info mt-3">
                            <h5><i class="fas fa-user"></i> Thông tin người yêu cầu</h5>
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
                                        <i class="fas fa-check"></i> Chấp nhận
                                    </button>
                                    <button type="submit" name="action" value="reject" class="btn btn-danger">
                                        <i class="fas fa-times"></i> Từ chối
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
        <p>&copy; 2025 PawHouse. All rights reserved.</p>
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

        document.addEventListener('DOMContentLoaded', function() {
            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
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
