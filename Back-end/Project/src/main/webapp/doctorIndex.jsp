<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Doctor Dashboard - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                background-color: #f4f8fb;
                font-family: Arial, sans-serif;
            }
            .hero {
                background: linear-gradient(to right, #56ccf2, #2f80ed);
                color: white;
                padding: 50px 0;
                text-align: center;
            }
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: 0.3s;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .card-body {
                padding: 2rem;
            }
            .btn-primary {
                background-color: #2f80ed;
                border: none;
            }
            .btn-primary:hover {
                background-color: #1a6dbd;
            }
            .card-title i {
                font-size: 2rem;
            }
        </style>
    </head>
    <body>
        <!-- Hero Section -->
        <div class="hero">
            <h1>Chào mừng đến với Dashboard Bác Sĩ</h1>
            <p>Quản lý lịch hẹn, theo dõi sức khỏe và tiêm ngừa dễ dàng</p>
        </div>

        <div class="container my-5">
            <div class="row">
                <!-- Card 1: Lịch Hẹn -->
                <div class="col-md-3 mb-4">
                    <div class="card p-4">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-calendar-check"></i> Lịch Hẹn</h5>
                            <p>Xem và quản lý lịch hẹn</p>
                            <a href="AppointmentServlet" class="btn btn-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Theo Dõi Sức Khỏe -->
                <div class="col-md-3 mb-4">
                    <div class="card p-4">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-heart-pulse"></i> Theo Dõi Sức Khỏe</h5>
                            <p>Kiểm tra hồ sơ sức khỏe của thú cưng</p>
                            <a href="doctorHealth_tracking.jsp" class="btn btn-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Quản Lý Tiêm Ngừa -->
                <div class="col-md-3 mb-4">
                    <div class="card p-4">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-syringe"></i> Quản Lý Tiêm Ngừa</h5>
                            <p>Thông tin về lịch tiêm phòng</p>
                            <a href="doctorVaccination.jsp" class="btn btn-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Hồ Sơ Bệnh Án -->
                <div class="col-md-3 mb-4">
                    <div class="card p-4">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-file-medical"></i> Hồ Sơ Bệnh Án</h5>
                            <p>Quản lý hồ sơ bệnh án</p>
                            <a href="doctorMedical_records.jsp" class="btn btn-primary">Xem chi tiết</a>
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
