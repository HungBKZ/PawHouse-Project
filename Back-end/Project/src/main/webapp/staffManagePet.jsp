<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Pets - PawHouse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #007bff;
        }
        .navbar-brand, .nav-link {
            color: white !important;
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
            background-color: #007bff;
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
                    <li class="nav-item"><a class="nav-link" href="staffManageProduct.jsp">Manage Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffReports.jsp">Reports</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffUpdateProfile.jsp">Update Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h1 class="mt-5">Manage Pets</h1>
        <a href="staffAddPet.jsp" class="btn btn-success mb-3">Add New Pet</a>
        <table class="table table-bordered table-hover">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Age</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Bella</td>
                    <td>Dog</td>
                    <td>2 years</td>
                    <td>
                        <a href="staffEditPet.jsp?id=1" class="btn btn-warning btn-sm">Edit</a>
                        <a href="staffDeletePet.jsp?id=1" class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Whiskers</td>
                    <td>Cat</td>
                    <td>1 year</td>
                    <td>
                        <a href="staffEditPet.jsp?id=2" class="btn btn-warning btn-sm">Edit</a>
                        <a href="staffDeletePet.jsp?id=2" class="btn btn-danger btn-sm">Delete</a>
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
