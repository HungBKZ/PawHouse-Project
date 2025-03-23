<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PawHouse Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
            padding-top: 20px;
        }
        .sidebar .nav-link {
            color: #fff;
            padding: 10px 20px;
        }
        .sidebar .nav-link:hover {
            background-color: #495057;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
        }
        .main-content {
            padding: 20px;
        }
        .dashboard-card {
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="text-center mb-4">
                    <img src="assets/images/logo.png" alt="PawHouse Logo" class="img-fluid" style="max-width: 150px;">
                    <h4 class="text-white mt-2">Admin Panel</h4>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a href="dashboard.jsp" class="nav-link active">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="account-list.jsp" class="nav-link">
                            <i class="fas fa-users"></i> Account List
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="manage-comments.jsp" class="nav-link">
                            <i class="fas fa-comments"></i> Manage Comments
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="doctor-list.jsp" class="nav-link">
                            <i class="fas fa-user-md"></i> Doctor List
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="pet-list.jsp" class="nav-link">
                            <i class="fas fa-paw"></i> Pet List
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="staff-logs.jsp" class="nav-link">
                            <i class="fas fa-history"></i> View Log Staff
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Header -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
                    <div class="container-fluid">
                        <h1 class="h3 mb-0">Dashboard</h1>
                        <div class="navbar-nav ms-auto">
                            <div class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle"></i> Admin
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="update-profile.jsp">Update Profile</a></li>
                                    <li><a class="dropdown-item" href="forgot-password.jsp">Change Password</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="login.jsp">Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Dashboard Overview -->
                <div class="row">
                    <!-- Total Users -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card dashboard-card border-left-primary h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Users</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= 250 %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Active Doctors -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card dashboard-card border-left-success h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Active Doctors</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= 15 %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-user-md fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Registered Pets -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card dashboard-card border-left-info h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Registered Pets</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= 180 %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-paw fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Comments (Quản lý bình luận) -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card dashboard-card border-left-warning h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Comments</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= 85 %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- End Dashboard Overview -->

                <!-- Quick Actions Section -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card dashboard-card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <a href="account-list.jsp" class="btn btn-primary w-100 mb-2">
                                            <i class="fas fa-user-plus"></i> Create New Account
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="doctor-list.jsp" class="btn btn-success w-100 mb-2">
                                            <i class="fas fa-user-md"></i> Manage Doctors
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="pet-list.jsp" class="btn btn-info w-100 mb-2">
                                            <i class="fas fa-paw"></i> Manage Pets
                                        </a>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="manage-comments.jsp" class="btn btn-warning w-100 mb-2">
                                            <i class="fas fa-comments"></i> View Comments
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- End Quick Actions -->

            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light text-center text-lg-start mt-4">
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
            © 2025 Copyright:
            <a class="text-dark" href="#">PawHouse Admin Panel</a>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
