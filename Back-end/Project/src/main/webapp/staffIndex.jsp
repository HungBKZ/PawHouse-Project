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
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
        .dashboard-container {
            margin: 30px auto;
            padding: 20px;
            max-width: 1200px;
        }
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #0056b3;
        }
        .chart-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
        .profile-dropdown {
            position: relative;
        }
        .profile-content {
            display: none;
            position: absolute;
            right: 0;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 15px;
            min-width: 250px;
            z-index: 1000;
        }
        .profile-dropdown:hover .profile-content {
            display: block;
        }
        .btn-profile {
            background-color: white;
            color: #0056b3;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            font-weight: 600;
        }
        .btn-profile:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fas fa-paw"></i> PawHouse Staff</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManagePet.jsp"><i class="fas fa-paw"></i> Pets</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/adoptions"><i class="fas fa-heart"></i> Adoptions</a></li>
                    <li class="nav-item"><a class="nav-link" href="staffManageProduct.jsp"><i class="fas fa-box"></i> Products</a></li>
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
    
    <div class="dashboard-container">
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <i class="fas fa-paw stats-icon"></i>
                    <h3>Total Pets</h3>
                    <h2>42</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <i class="fas fa-heart stats-icon"></i>
                    <h3>Pending Adoptions</h3>
                    <h2>15</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <i class="fas fa-calendar-check stats-icon"></i>
                    <h3>Today's Appointments</h3>
                    <h2>8</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <i class="fas fa-box stats-icon"></i>
                    <h3>Products</h3>
                    <h2>156</h2>
                </div>
            </div>
        </div>

        <div class="chart-container">
            <canvas id="incomeChart"></canvas>
        </div>
    </div>
    
    <footer>
        <p class="m-0">&copy; 2025 PawHouse. All rights reserved.</p>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
                        backgroundColor: "rgba(0, 86, 179, 0.5)",
                        borderColor: "#0056b3",
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: "top",
                        },
                        title: {
                            display: true,
                            text: 'Monthly Revenue Overview'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return '$' + value.toLocaleString();
                                }
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>