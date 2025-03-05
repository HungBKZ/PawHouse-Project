<%-- 
    Document   : staffReportYear
    Created on : Mar 5, 2025, 12:19:25 AM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yearly Reports - PawHouse</title>
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
                    <li class="nav-item"><a class="nav-link" href="staffReports.jsp">Reports</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffUpdateProfile.jsp">Update Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mt-5">Yearly Reports</h1>
        <p class="lead">View the yearly statistics of pet adoptions and sales.</p>
        <form action="staffReportYearServlet" method="GET" class="mb-4">
            <label for="reportYear" class="form-label">Select Year:</label>
            <input type="number" class="form-control" id="reportYear" name="reportYear" min="2000" max="2100" required>
            <button type="submit" class="btn btn-primary mt-3">Generate Report</button>
        </form>
        <table class="table table-bordered table-hover">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Category</th>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Revenue</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Pet Adoption</td>
                    <td>Max (Dog)</td>
                    <td>10</td>
                    <td>$1,500</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Product Sale</td>
                    <td>Cat Litter</td>
                    <td>100</td>
                    <td>$2,000</td>
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
