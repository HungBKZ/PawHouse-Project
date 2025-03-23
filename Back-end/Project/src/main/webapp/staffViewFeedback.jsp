<%-- 
    Document   : staffViewFeedback
    Created on : Mar 5, 2025, 12:26:45 AM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Customer Feedback - PawHouse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
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
            margin-bottom: 20px;
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
                    <li class="nav-item"><a class="nav-link" href="staffManageAppointments.jsp">Manage Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffViewFeedback.jsp">View Feedback</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffReports.jsp">Reports</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffUpdateProfile.jsp">Update Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mt-5">Customer Feedback</h1>
        <p class="lead">View customer feedback and reviews about PawHouse services.</p>

        <div class="card shadow">
            <div class="card-body">
                <h5 class="card-title">Alice Johnson</h5>
                <h6 class="card-subtitle mb-2 text-muted">2025-03-10</h6>
                <p class="card-text">Great service! My dog received the best care, and the staff was super friendly.</p>
                <span class="badge bg-success">★★★★★</span>
            </div>
        </div>

        <div class="card shadow">
            <div class="card-body">
                <h5 class="card-title">John Doe</h5>
                <h6 class="card-subtitle mb-2 text-muted">2025-03-12</h6>
                <p class="card-text">The appointment booking was smooth, and the doctor was very professional.</p>
                <span class="badge bg-success">★★★★☆</span>
            </div>
        </div>

    </div>

    <footer>
        <p>&copy; 2025 PawHouse. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

