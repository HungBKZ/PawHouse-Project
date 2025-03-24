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
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background: linear-gradient(135deg, #f1f4f8, #a0b8c7);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                transition: background 0.3s ease;
            }

            .wrapper {
                display: flex;
                flex: 1;
                transition: all 0.3s ease;
            }

            #sidebar {
                width: 300px;
                background: #343a40;
                color: white;
                min-height: 100vh;
                padding-top: 20px;
                box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
                position: fixed;
                transition: all 0.5s ease;
            }

            #sidebar .sidebar-header {
                padding: 20px;
                text-align: center;
                background: #333;
                font-size: 24px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            #sidebar .sidebar-header h3 {
                color: white;
                text-transform: uppercase;
            }

            #sidebar ul.components {
                padding: 20px 0;
                list-style-type: none;
            }

            #sidebar ul li a {
                padding: 15px;
                font-size: 1.1em;
                display: block;
                color: #fff;
                text-decoration: none;
                border-bottom: 1px solid #495057;
                transition: 0.3s;
                position: relative;
            }

            #sidebar ul li a:before {
                content: '';
                position: absolute;
                left: -3px;
                top: 0;
                height: 100%;
                width: 3px;
                background: #ffbb33;
                opacity: 0;
                transition: opacity 0.3s;
            }

            #sidebar ul li a:hover:before,
            #sidebar ul li.active > a:before {
                opacity: 1;
            }

            #sidebar ul li a:hover,
            #sidebar ul li.active > a {
                background: #495057;
            }

            #content {
                margin-left: 300px;
                padding: 40px 30px;
                flex-grow: 1;
                transition: all 0.3s;
                min-height: calc(100vh - 120px); /* Adjust to leave space for the footer */
            }

            .navbar {
                padding: 15px;
                background: #fff;
                box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
            }

            .navbar .btn-dark {
                border: none;
                background: #343a40;
                color: white;
                font-size: 1.2em;
                transition: background-color 0.3s;
            }

            .navbar .btn-dark:hover {
                background-color: #5a6268;
            }

            .content-wrapper {
                display: flex;
                justify-content: center;
                flex-direction: column;
                align-items: center;
                height: 100%;
                margin-top: 50px;
            }

            .content-wrapper h3 {
                font-size: 2.5rem;
                color: #333;
                margin-bottom: 30px;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            }

            .content-wrapper .btn-group {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
                transition: all 0.3s ease;
            }

            .content-wrapper .btn-group a {
                padding: 15px 30px;
                font-size: 1.2em;
                background-color: #007bff;
                color: white;
                border-radius: 10px;
                text-decoration: none;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s, box-shadow 0.3s;
            }

            .content-wrapper .btn-group a:hover {
                background-color: #0056b3;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            }

            footer {
                position: relative;
                bottom: 0;
                width: 100%;
                padding: 20px;
                background: #333;
                color: white;
                text-align: center;
                box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.1);
                margin-top: auto;
            }

            footer .footer-content {
                padding: 10px;
                font-size: 1rem;
                color: #ccc;
            }

            /* Media Query for Mobile Devices */
            @media (max-width: 768px) {
                #sidebar {
                    position: absolute;
                    width: 250px;
                    margin-left: -250px;
                }

                #sidebar.active {
                    margin-left: 0;
                }

                #content {
                    margin-left: 0;
                    padding: 20px;
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
                        <a href="admin/services"><i class="fas fa-cogs"></i> Service Management</a>
                    </li>
                    <li>
                        <a href="/admin/pets"><i class="fas fa-paw"></i> Pet Management</a>
                    </li>
                    <li>
                        <a href="admin/products"><i class="fas fa-box"></i> Product Management</a>
                    </li>
                    <li>
                        <a href="admin-comments"><i class="fas fa-comments"></i> Comment Management</a>
                    </li>
                    <li>
                        <a href="#systemSubmenu" data-bs-toggle="collapse"><i class="fas fa-cogs"></i> System Management</a>
                        <ul class="collapse list-unstyled" id="systemSubmenu">
                            <li><a href="/UpdateProfileServlet">Update Profile</a></li>
                            <li><a href="/logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>

            <!-- Page Content -->
            <div id="content">
                <!-- Top Navigation -->
              <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container-fluid">
        <!-- Large icon on the left -->
        <a class="navbar-brand" href="adminDashboard.jsp">
            <i class="fas fa-paw fa-2x" style="color: #3b6d5c;"></i> <!-- Large Paw Icon -->
        </a>

        <!-- Navbar toggler for small screens -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Admin Dropdown Menu -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle"></i> Admin
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="/UpdateProfileServlet">Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


                <!-- Main Content Area -->
                <div class="container-fluid content-wrapper">
                    <h3>Welcome to the Admin Dashboard</h3>
                    <div class="btn-group">
                        <a href="admin/accounts" class="btn">Account Management</a>
                        <a href="admin/services" class="btn">Service Management</a>
                        <a href="/admin/pets" class="btn">Pet Management</a>
                        <a href="admin/products" class="btn">Product Management</a>
                        <a href="admin-comments" class="btn">Comment Management</a>
                        <a href="${pageContext.request.contextPath}/staff/report" class="btn">Income Statistics</a>
                    </div>
                </div>
            </div>
        </div>

    

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
      
</html>
