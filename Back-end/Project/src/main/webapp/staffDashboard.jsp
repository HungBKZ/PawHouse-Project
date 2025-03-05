<%-- 
    Document   : staffDashboard
    Created on : Mar 5, 2025, 12:22:37 AM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard - PawHouse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #eef5f9;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #0056b3;
        }
        .navbar-brand, .nav-link {
            color: white !important;
            font-weight: bold;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.2);
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
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="staffIndex.jsp">PawHouse Staff</a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="staffManagePet.jsp">Manage Pets</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManageProduct.jsp">Manage Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManageDoctor.jsp">Manage Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffReports.jsp">Reports</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffUpdateProfile.jsp">Update Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container text-center">
        <h1 class="mt-5">Staff Dashboard</h1>
        <p class="lead">Overview of current statistics and activities.</p>
        <div class="row mt-4">
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Total Pets</h5>
                    <p class="display-6">150</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Total Products</h5>
                    <p class="display-6">85</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Appointments Today</h5>
                    <p class="display-6">12</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Revenue This Month</h5>
                    <p class="display-6">$5,200</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 PawHouse. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

