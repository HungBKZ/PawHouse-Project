<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #00c6ff, #0072ff);
            --hover-gradient: linear-gradient(135deg, #0072ff, #00c6ff);
            --shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            --card-transition: all 0.4s ease-in-out;
        }

        body {
            background: #eef2f7;
            font-family: 'Poppins', sans-serif;
            padding-top: 70px;
            overflow-x: hidden;
        }

        .navbar {
            background: #fff;
            box-shadow: var(--shadow);
            padding: 15px 0;
        }

        .navbar-brand {
            font-size: 28px;
            font-weight: 800;
            color: #0072ff;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover {
            color: #00c6ff;
        }

        .nav-link {
            font-weight: 600;
            color: #333;
            padding: 10px 20px;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #0072ff;
        }

        .hero {
            background: var(--primary-gradient);
            color: #fff;
            padding: 80px 0;
            text-align: center;
            border-radius: 20px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            animation: fadeIn 1s ease-in-out;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255, 255, 255, 0.1);
            transform: rotate(30deg);
            animation: shine 5s infinite;
        }

        .hero h1 {
            font-size: 42px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .hero p {
            font-size: 20px;
            font-weight: 400;
            opacity: 0.9;
        }

        .card {
            border: none;
            border-radius: 15px;
            background: #fff;
            box-shadow: var(--shadow);
            transition: var(--card-transition);
            overflow: hidden;
            position: relative;
        }

        .card:hover {
            transform: scale(1.05) rotate(1deg);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
        }

        .card-body {
            padding: 2.5rem;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .card-body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .card:hover .card-body::before {
            opacity: 0.1;
        }

        .card-title {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }

        .card-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: var(--hover-gradient);
            box-shadow: var(--shadow);
            transform: translateY(-3px);
        }

        .container {
            margin-top: 60px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        

        @media (max-width: 768px) {
            .hero h1 { font-size: 32px; }
            .hero p { font-size: 16px; }
            .card-title { font-size: 20px; }
            .card-text { font-size: 14px; }
            .btn-primary { font-size: 14px; padding: 10px 20px; }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">PawHouse</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp"><i class="bi bi-person-circle"></i> Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero">
        <h1>Doctor Dashboard</h1>
        <p>Quản lý thông minh - Tối ưu hóa mọi quy trình</p>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <!-- Card 1: Lịch Hẹn -->
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="bi bi-calendar-check"></i> Lịch Hẹn</h5>
                        <p class="card-text">Xem và quản lý lịch hẹn</p>
                        <a href="AppointmentServlet" class="btn btn-primary">Quản lý</a>
                    </div>
                </div>
            </div>

         <!-- Card 2: Theo Dõi Sức Khỏe -->
<div class="col-md-3 mb-4">
    <div class="card">
        <div class="card-body">
            <h5 class="card-title"><i class="bi bi-heart-pulse"></i> Sức Khỏe</h5>
            <p class="card-text">Theo dõi sức khỏe thú cưng</p>
            <a href="predictHealth" class="btn btn-primary">Theo dõi</a>
        </div>
    </div>
</div>
            <!-- Card 3: Quản Lý Tiêm Ngừa -->
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="bi bi-syringe"></i> Tiêm Ngừa</h5>
                        <p class="card-text">Quản lý lịch tiêm ngừa</p>
                        <a href="doctorVaccination.jsp" class="btn btn-primary">Xem lịch</a>
                    </div>
                </div>
            </div>

            <!-- Card 4: Hồ Sơ Bệnh Án -->
            <div class="col-md-3 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="bi bi-file-medical"></i> Bệnh Án</h5>
                        <p class="card-text">Quản lý hồ sơ bệnh án</p>
                        <a href="medical-record" class="btn btn-primary">Quản lý</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>