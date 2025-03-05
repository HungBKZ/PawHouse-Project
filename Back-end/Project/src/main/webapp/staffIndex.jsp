<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Staff Dashboard - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            body {
                background-color: #eef2f7;
                font-family: 'Poppins', sans-serif;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .navbar, footer {
                background-color: #007bff;
            }
            .navbar-brand, .nav-link, footer p {
                color: white !important;
                font-weight: bold;
            }
            .profile-dropdown {
                position: relative;
            }
            .profile-dropdown .btn {
                background: white;
                color: #007bff;
                font-weight: bold;
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
            .hero-section {
                background: url('imgs/bannerDoctor.png') center/cover no-repeat;
                height: 350px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                text-shadow: 3px 3px 10px rgba(0, 0, 0, 0.7);
                font-size: 30px;
                font-weight: bold;
                border-radius: 15px;
                margin: 20px auto;
                width: 90%;
                max-width: 1200px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            }
            .dashboard-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
                padding: 20px;
                flex: 1;
            }
            .dashboard-card {
                background: white;
                padding: 25px;
                text-align: center;
                border-radius: 12px;
                transition: transform 0.3s, box-shadow 0.3s;
                cursor: pointer;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                width: 280px;
            }
            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.2);
            }
            .dashboard-card i {
                font-size: 48px;
                margin-bottom: 10px;
                color: #007bff;
            }
            .view-details {
                margin-top: 12px;
                display: block;
            }
            footer {
                text-align: center;
                padding: 15px;
                color: white;
                margin-top: auto;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">PawHouse Staff</a>
                <div class="profile-dropdown ms-auto">
                    <button class="btn">Profile</button>
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

        <div class="hero-section"></div>
        <div class="container my-4">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search for pets, products, doctors, appointments..." aria-label="Search">
                <button class="btn btn-primary" type="button">🔍</button>
            </div>
        </div>


        <div class="container">
            <div class="dashboard-container">
                <div class="dashboard-card">
                    <i class="fas fa-paw"></i>
                    <h5>Manage Pets</h5>
                    <a href="staffManagePet.jsp" class="btn btn-outline-primary view-details">View Details</a>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-shopping-bag"></i>
                    <h5>Manage Products</h5>
                    <a href="staffManageProduct.jsp" class="btn btn-outline-primary view-details">View Details</a>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-user-md"></i>
                    <h5>Manage Doctors</h5>
                    <a href="staffManageDoctor.jsp" class="btn btn-outline-primary view-details">View Details</a>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-calendar-check"></i>
                    <h5>Manage Appointments</h5>
                    <a href="staffManageAppointments.jsp" class="btn btn-outline-primary view-details">View Details</a>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-comments"></i>
                    <h5>View Feedback</h5>
                    <a href="staffViewFeedback.jsp" class="btn btn-outline-primary view-details">View Details</a>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-chart-line"></i>
                    <h5>Reports</h5>
                    <a href="staffReports.jsp" class="btn btn-outline-primary view-details">View Details</a>
                </div>
            </div>
        </div>
        <div class="container my-4">
            <h5>Recent Activities</h5>
            <ul class="list-group">
                <li class="list-group-item">🔔 New appointment scheduled for <strong>Buddy</strong> with <strong>Dr. Smith</strong></li>
                <li class="list-group-item">🛒 5 new products added to inventory</li>
                <li class="list-group-item">💬 New feedback received from <strong>Jane Doe</strong></li>
            </ul>
        </div>
        <footer class="text-center text-white bg-primary py-3">
            <div class="container">
                <p>&copy; 2025 PawHouse. All rights reserved.</p>
                <p>Email: support@pawhouse.com | Phone: (123) 456-7890</p>
                <p>
                    <a href="#" class="text-white mx-2">Privacy Policy</a> |
                    <a href="#" class="text-white mx-2">Terms of Service</a>
                </p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
