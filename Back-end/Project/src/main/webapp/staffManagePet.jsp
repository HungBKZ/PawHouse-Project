<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Pets - PawHouse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-bottom: 70px;
        }
        .navbar {
            background-color: #0056b3;
            padding: 15px 0;
        }
        .navbar-brand, .nav-link {
            color: white !important;
            font-weight: 600;
        }
        .nav-link:hover {
            color: #e9ecef !important;
        }
        .nav-link.active {
            border-bottom: 2px solid white;
        }
        .container {
            margin-top: 30px;
        }
        .table {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .table thead {
            background-color: #0056b3;
            color: white;
        }
        .btn-action {
            transition: all 0.3s;
        }
        .btn-action:hover {
            transform: scale(1.05);
        }
        .pet-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .pet-card:hover {
            transform: translateY(-5px);
        }
        .pet-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
        }
        .search-filters {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .status-available {
            background-color: #28a745;
        }
        .status-pending {
            background-color: #ffc107;
        }
        .status-adopted {
            background-color: #dc3545;
        }
        footer {
            background-color: #0056b3;
            color: white;
            text-align: center;
            padding: 20px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/staffIndex.jsp"><i class="fas fa-paw"></i> PawHouse Staff</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staffIndex.jsp"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/staff/pets"><i class="fas fa-paw"></i> Pets</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/adoptions"><i class="fas fa-heart"></i> Adoptions</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/products"><i class="fas fa-box"></i> Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/doctors"><i class="fas fa-user-md"></i> Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/appointments"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <div class="dropdown">
                        <button class="btn btn-light dropdown-toggle" type="button" id="profileDropdown" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> ${sessionScope.user.fullName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/staff/profile"><i class="fas fa-user-edit"></i> Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
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

        <!-- Search and Filters -->
        <div class="search-filters">
            <form action="${pageContext.request.contextPath}/staff/pets" method="get" class="row g-3">
                <div class="col-md-3">
                    <input type="text" class="form-control" name="search" placeholder="Search pets..." value="${param.search}">
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="category">
                        <option value="">All Categories</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.categoryID}" ${param.category == category.categoryID ? 'selected' : ''}>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="status">
                        <option value="">All Status</option>
                        <option value="Available" ${param.status == 'Available' ? 'selected' : ''}>Available</option>
                        <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending Adoption</option>
                        <option value="Adopted" ${param.status == 'Adopted' ? 'selected' : ''}>Adopted</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
                <div class="col-md-3 text-end">
                    <a href="${pageContext.request.contextPath}/staff/pets/add" class="btn btn-success w-100">
                        <i class="fas fa-plus"></i> Add New Pet
                    </a>
                </div>
            </form>
        </div>

        <!-- Pets Table -->
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Species</th>
                                <th>Breed</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pets}" var="pet">
                                <tr class="align-middle">
                                    <td>${pet.petID}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/uploads/pets/${pet.petImage}" 
                                             alt="${pet.petName}" 
                                             class="pet-image" 
                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-pet.jpg'">
                                    </td>
                                    <td>${pet.petName}</td>
                                    <td><span class="badge bg-info">${pet.category.categoryName}</span></td>
                                    <td>${pet.species}</td>
                                    <td>${pet.breed}</td>
                                    <td>${pet.age} years</td>
                                    <td>${pet.gender}</td>
                                    <td>
                                        <span class="badge status-${pet.adoptionStatus.toLowerCase()}">${pet.adoptionStatus}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/staff/pets/edit/${pet.petID}" 
                                               class="btn btn-warning btn-sm me-1" 
                                               title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" 
                                                    class="btn btn-danger btn-sm" 
                                                    onclick="confirmDelete(${pet.petID})" 
                                                    title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty pets}">
                                <tr>
                                    <td colspan="10" class="text-center">No pets found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p class="m-0">&copy; 2025 PawHouse. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(petId) {
            if (confirm('Are you sure you want to delete this pet? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/staff/pets/delete/' + petId;
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        });
    </script>
</body>
</html>
