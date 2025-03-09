<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Staff Dashboard - PawHouse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #eef2f7;
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .navbar, footer {
            background-color: #00a991;
        }
        .navbar-brand, .nav-link, footer p {
            color: white !important;
            font-weight: bold;
        }
        .sidebar {
            width: 250px;
            background: #ff6f61;
            position: fixed;
            height: 100vh;
            padding-top: 20px;
        }
        .sidebar a {
            color: white;
            padding: 10px;
            display: block;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #0056b3;
        }
        .dashboard-container {
            margin-left: 260px;
            padding: 20px;
        }
        .profile-dropdown {
            position: relative;
        }
        .profile-content {
            display: none;
            position: absolute;
            right: 0;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 10px;
            width: 230px;
            z-index: 1000;
        }
        .profile-dropdown:hover .profile-content {
            display: block;
        }
        .chart-container {
            max-width: 800px;
            margin: auto;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">PawHouse Staff</a>
            <div class="profile-dropdown ms-auto">
                <button class="btn btn-light">Profile</button>
                <div class="profile-content">
                    <p><strong>Staff Name</strong></p>
                    <p>Email: staff@pawhouse.com</p>
                    <hr>
                    <a href="staffUpdateProfile.jsp" class="btn btn-sm btn-outline-primary w-100">Update Profile</a>
                    <a href="logout.jsp" class="btn btn-sm btn-outline-danger w-100 mt-2">Logout</a>
                </div>
            </div>
        </div>
    </nav>
    
    <div class="sidebar">
        <a href="#">Dashboard</a>
        <a href="staffManagePet.jsp">Manage Pets</a>
        <a href="staffManageProduct.jsp">Manage Products</a>
        <a href="staffManageDoctor.jsp">Manage Doctors</a>
        <a href="staffManageAppointments.jsp">Manage Appointments</a>
        <a href="staffViewFeedback.jsp">View Feedback</a>
        <a href="staffReports.jsp">Reports</a>
    </div>
    
    <div class="dashboard-container">
        <h2 class="text-center">Staff Dashboard</h2>
        <div class="chart-container">
            <canvas id="incomeChart"></canvas>
        </div>
    </div>
    
    <%@ include file="includes/footer.jsp" %>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById("incomeChart").getContext("2d");
            var incomeChart = new Chart(ctx, {
                type: "bar",
                data: {
                    labels: ["January", "February", "March", "April", "May", "June"],
                    datasets: [{
                        label: "Monthly Revenue",
                        data: [40000, 50000, 60000, 70000, 80000, 90000],
                        backgroundColor: "rgba(0, 123, 255, 0.5)",
                        borderColor: "#007bff",
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: "top",
                        },
                    },
                },
            });
        });
    </script>
</body>
</html>