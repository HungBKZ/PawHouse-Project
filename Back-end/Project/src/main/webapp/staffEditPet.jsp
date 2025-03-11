<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Pet - PawHouse</title>
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
        .card {
            border-radius: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #0056b3;
            color: white;
            border-radius: 15px 15px 0 0 !important;
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
        .current-image {
            max-width: 200px;
            max-height: 200px;
            margin-bottom: 10px;
        }
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            display: none;
            margin-top: 10px;
        }
        .status-badge {
            font-size: 0.9em;
            padding: 5px 10px;
            border-radius: 15px;
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
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/staff/dashboard">
                <i class="fas fa-paw"></i> PawHouse Staff
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/staff/dashboard">
                            <i class="fas fa-chart-line"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/staff/pets">
                            <i class="fas fa-paw"></i> Pets
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/staff/adoptions">
                            <i class="fas fa-heart"></i> Adoptions
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/staff/products">
                            <i class="fas fa-box"></i> Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/staff/appointments">
                            <i class="fas fa-calendar-check"></i> Appointments
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <div class="dropdown">
                        <button class="btn btn-light dropdown-toggle" type="button" id="profileDropdown" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> ${sessionScope.user.fullName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/staff/profile">
                                    <i class="fas fa-user-edit"></i> Profile
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0"><i class="fas fa-edit"></i> Edit Pet</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/staff/pets/edit/${pet.petID}" method="post" enctype="multipart/form-data">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Pet Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="petName" value="${pet.petName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                    <select class="form-select" name="categoryId" required>
                                        <option value="">Select Category</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.categoryID}" ${pet.category.categoryID == category.categoryID ? 'selected' : ''}>
                                                ${category.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Species <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="species" value="${pet.species}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Breed <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="breed" value="${pet.breed}" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label class="form-label">Age <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="age" value="${pet.age}" min="0" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Gender <span class="text-danger">*</span></label>
                                    <select class="form-select" name="gender" required>
                                        <option value="">Select Gender</option>
                                        <option value="Male" ${pet.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${pet.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Status <span class="text-danger">*</span></label>
                                    <select class="form-select" name="adoptionStatus" required>
                                        <option value="Available" ${pet.adoptionStatus == 'Available' ? 'selected' : ''}>Available</option>
                                        <option value="Pending" ${pet.adoptionStatus == 'Pending' ? 'selected' : ''}>Pending Adoption</option>
                                        <option value="Adopted" ${pet.adoptionStatus == 'Adopted' ? 'selected' : ''}>Adopted</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Current Image</label>
                                <div>
                                    <img src="${pageContext.request.contextPath}/uploads/pets/${pet.petImage}" 
                                         alt="${pet.petName}" 
                                         class="current-image">
                                </div>
                                <label class="form-label">New Image (Leave empty to keep current image)</label>
                                <input type="file" class="form-control" name="petImage" accept="image/*" onchange="previewImage(this)">
                                <img id="imagePreview" class="preview-image" alt="Preview">
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/staff/pets" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p class="m-0">&copy; 2025 PawHouse. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
            }
        }
    </script>
</body>
</html>
