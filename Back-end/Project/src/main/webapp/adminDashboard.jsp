<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <style>
            /* CSS từ file admin-style.css */
            body {
                background: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .wrapper {
                display: flex;
                width: 100%;
                align-items: stretch;
            }
            #sidebar {
                min-width: 250px;
                max-width: 250px;
                min-height: 100vh;
                transition: all 0.3s;
                background: #343a40;
                color: white;
            }

            #sidebar .sidebar-header {
                padding: 20px;
                background: #343a40;
            }

            #sidebar ul.components {
                padding: 20px 0;
            }

            #sidebar ul li a {
                padding: 10px 20px;
                font-size: 1.1em;
                display: block;
                color: #fff;
                text-decoration: none;
            }

            #sidebar ul li a:hover, #sidebar ul li.active > a {
                background: #495057;
            }

            #content {
                width: 100%;
                min-height: 100vh;
                transition: all 0.3s;
            }

            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }

            .navbar {
                padding: 15px 10px;
                background: #fff;
                box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            }



            @media (max-width: 768px) {
                #sidebar {
                    margin-left: -250px;
                }
                #sidebar.active {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <!-- Sidebar -->
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>PawHouse Admin</h3>
                </div>
                <ul class="list-unstyled components">
                    <li class="active">
                        <a href="adminDashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="admin/accounts"><i class="fas fa-users"></i> Account Management</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/report"><i class="fas fa-bars"></i> Income Statistics</a>
                    </li>
                    <li>
                        <a href="admin/services"><i class="fas fa-user-circle"></i> Service Management</a>
                    </li>
                    <li>
                        <a href="adminPet-list.jsp"><i class="fas fa-paw"></i> Pet Management</a>
                    </li>
                    <li>
                        <a href="admin/products" class="list-group-item list-group-item-action">Product Manage</a>

                    </li>
                    <li>
                        <a href="admin-comments" class="list-group-item list-group-item-action">Comment Manage</a>

                    </li>
                    <li>
                        <a href="#systemSubmenu" data-bs-toggle="collapse"><i class="fas fa-cogs"></i> System Management</a>
                        <ul class="collapse list-unstyled" id="systemSubmenu">
                            <li><a href="admin-profile.jsp">Update Profile</a></li>
                            <li><a href="login.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>

            <!-- Page Content -->
            <div id="content">
                <!-- Top Navigation -->
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container-fluid">
                        <button type="button" id="sidebarCollapse" class="btn btn-dark">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div class="ms-auto">
                            <div class="dropdown">
                                <button class="btn btn-link dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle"></i> Admin
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="admin-profile.jsp">Profile</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="login.jsp">Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Main Content Area -->
                <div class="container-fluid p-4">
                    <div class="row">
                        <div class="col-md-3 mb-4">
                            <div class="card bg-primary text-white">
                                <div class="card-body">
                                    <h5 class="card-title">Total Users</h5>
                                    <h2 class="card-text">0</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card bg-success text-white">
                                <div class="card-body">
                                    <h5 class="card-title">Total Pets</h5>
                                    <h2 class="card-text">0</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card bg-info text-white">
                                <div class="card-body">
                                    <h5 class="card-title">Total Doctors</h5>
                                    <h2 class="card-text">0</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-4">
                            <div class="card bg-warning text-white">
                                <div class="card-body">
                                    <h5 class="card-title">Total Comments</h5>
                                    <h2 class="card-text">0</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
