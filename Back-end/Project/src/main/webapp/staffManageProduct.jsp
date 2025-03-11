<%-- 
    Document   : staffManageProduct
    Created on : Mar 4, 2025, 11:51:29 PM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Products - PawHouse</title>
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
        .product-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
        .stock-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
        }
        .stock-low {
            background-color: #ffc107;
            color: #000;
        }
        .stock-available {
            background-color: #28a745;
            color: white;
        }
        .stock-out {
            background-color: #dc3545;
            color: white;
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
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="staffIndex.jsp"><i class="fas fa-paw"></i> PawHouse Staff</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="staffIndex.jsp"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManagePet.jsp"><i class="fas fa-paw"></i> Pets</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/adoptions"><i class="fas fa-heart"></i> Adoptions</a></li>
                    <li class="nav-item"><a class="nav-link active" href="staffManageProduct.jsp"><i class="fas fa-box"></i> Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManageDoctor.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManageAppointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffViewFeedback.jsp"><i class="fas fa-comments"></i> Feedback</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffReports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
                </ul>
                <div class="profile-dropdown">
                    <button class="btn-profile">
                        <i class="fas fa-user-circle"></i> ${loggedInUser.fullName}
                    </button>
                    <div class="profile-content">
                        <div class="d-flex align-items-center mb-3">
                            <i class="fas fa-user-circle fa-2x me-2"></i>
                            <div>
                                <strong>${loggedInUser.fullName}</strong>
                                <div class="text-muted small">${loggedInUser.email}</div>
                            </div>
                        </div>
                        <hr>
                        <a href="staffUpdateProfile.jsp" class="btn btn-outline-primary w-100 mb-2">
                            <i class="fas fa-user-edit"></i> Update Profile
                        </a>
                        <a href="logout" class="btn btn-outline-danger w-100">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-box"></i> Manage Products</h2>
            <div>
                <button class="btn btn-primary btn-action me-2" onclick="filterProducts('low-stock')">
                    <i class="fas fa-exclamation-triangle"></i> Low Stock
                </button>
                <a href="staffAddProduct.jsp" class="btn btn-success btn-action">
                    <i class="fas fa-plus"></i> Add New Product
                </a>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
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
                                        <th>Price</th>
                                        <th>Stock</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="align-middle">
                                        <td>1</td>
                                        <td>
                                            <img src="path/to/product1.jpg" alt="Premium Dog Food" class="product-image">
                                        </td>
                                        <td>Premium Dog Food</td>
                                        <td><span class="badge bg-info">Pet Food</span></td>
                                        <td>$29.99</td>
                                        <td>50</td>
                                        <td><span class="stock-badge stock-available">In Stock</span></td>
                                        <td>
                                            <a href="staffEditProduct.jsp?id=1" class="btn btn-warning btn-sm btn-action me-2">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <button class="btn btn-danger btn-sm btn-action" onclick="confirmDelete(1)">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </td>
                                    </tr>
                                    <tr class="align-middle">
                                        <td>2</td>
                                        <td>
                                            <img src="path/to/product2.jpg" alt="Cat Toy Set" class="product-image">
                                        </td>
                                        <td>Cat Toy Set</td>
                                        <td><span class="badge bg-info">Toys</span></td>
                                        <td>$15.99</td>
                                        <td>5</td>
                                        <td><span class="stock-badge stock-low">Low Stock</span></td>
                                        <td>
                                            <a href="staffEditProduct.jsp?id=2" class="btn btn-warning btn-sm btn-action me-2">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <button class="btn btn-danger btn-sm btn-action" onclick="confirmDelete(2)">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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
        function confirmDelete(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                window.location.href = 'staffDeleteProduct.jsp?id=' + productId;
            }
        }

        function filterProducts(filter) {
            // Implementation for filtering products
            console.log('Filtering products by:', filter);
        }
    </script>
</body>
</html>
