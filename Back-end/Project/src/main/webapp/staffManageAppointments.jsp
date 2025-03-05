<%-- 
    Document   : staffManageAppointments
    Created on : Mar 5, 2025, 12:24:45 AM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Appointments - PawHouse</title>
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
        .table {
            background-color: white;
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
                    <li class="nav-item"><a class="nav-link" href="staffReports.jsp">Reports</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffUpdateProfile.jsp">Update Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mt-5">Manage Appointments</h1>
        <a href="staffAddAppointment.jsp" class="btn btn-success mb-3">Add New Appointment</a>
        <table class="table table-bordered table-hover">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Pet Owner</th>
                    <th>Pet Name</th>
                    <th>Doctor</th>
                    <th>Date & Time</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Alice Johnson</td>
                    <td>Bella (Dog)</td>
                    <td>Dr. Emily Smith</td>
                    <td>2025-03-10 14:00</td>
                    <td><span class="badge bg-warning">Pending</span></td>
                    <td>
                        <a href="staffEditAppointment.jsp?id=1" class="btn btn-warning btn-sm">Edit</a>
                        <a href="staffDeleteAppointment.jsp?id=1" class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>John Doe</td>
                    <td>Whiskers (Cat)</td>
                    <td>Dr. John Doe</td>
                    <td>2025-03-12 10:30</td>
                    <td><span class="badge bg-success">Confirmed</span></td>
                    <td>
                        <a href="staffEditAppointment.jsp?id=2" class="btn btn-warning btn-sm">Edit</a>
                        <a href="staffDeleteAppointment.jsp?id=2" class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <footer>
        <p>&copy; 2025 PawHouse. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

