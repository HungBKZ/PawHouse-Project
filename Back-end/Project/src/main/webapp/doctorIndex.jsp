<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
        .btn-primary {
            background-color: #2f80ed;
            border: none;
        }
    </style>
</head>
<body>
    <!-- Hero Section -->
    <div class="hero">
        <h1>Chào mừng đến với Dashboard Bác Sĩ</h1>
        <p>Quản lý lịch hẹn, theo dõi sức khỏe, quản lý tiêm ngừa dễ dàng</p>
    </div>

    <div class="container my-5">
        <div class="row text-center">
            <div class="col-md-4">
                <div class="card p-4">
                    <h4><i class="bi bi-calendar-check"></i> Lịch Hẹn</h4>
                    <%
                        String url = "jdbc:sqlserver://localhost:1433;databaseName=PawHouseProject;encrypt=false";
                        String user = "sa";
                        String password = "your_password"; // Thay bằng mật khẩu thực tế
                        int appointmentCount = 0;
                        
                        try {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            try (Connection conn = DriverManager.getConnection(url, user, password);
                                 Statement stmt = conn.createStatement();
                                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM Appointments WHERE AppointmentDate = CAST(GETDATE() AS DATE)")) {
                                if (rs.next()) {
                                    appointmentCount = rs.getInt("total");
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    <p><%= appointmentCount %> cuộc hẹn hôm nay</p>
                    <a href="doctorAppointments.jsp" class="btn btn-primary">Xem chi tiết</a>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card p-4">
                    <h4><i class="bi bi-heart-pulse"></i> Theo Dõi Sức Khỏe</h4>
                    <p>Kiểm tra hồ sơ sức khỏe của thú cưng</p>
                    <a href="doctorHealth_tracking.jsp" class="btn btn-primary">Xem chi tiết</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-4">
                    <h4><i class="bi bi-syringe"></i> Quản Lý Tiêm Ngừa</h4>
                    <p>Thông tin về lịch tiêm phòng</p>
                    <a href="doctorVaccination.jsp" class="btn btn-primary">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <div class="row text-center mt-4">
            <div class="col-md-6">
                <div class="card p-4">
                    <h4><i class="bi bi-file-medical"></i> Hồ Sơ Bệnh Án</h4>
                    <%
                        int medicalRecordsCount = 0;
                        try {
                            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                            try (Connection conn = DriverManager.getConnection(url, user, password);
                                 Statement stmt = conn.createStatement();
                                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM MedicalRecords WHERE LastUpdated >= DATEADD(DAY, -7, GETDATE())")) {
                                if (rs.next()) {
                                    medicalRecordsCount = rs.getInt("total");
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    <p><%= medicalRecordsCount %> hồ sơ mới cập nhật</p>
                    <a href="doctorMedical_records.jsp" class="btn btn-primary">Xem chi tiết</a>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card p-4">
                    <h4><i class="bi bi-person-circle"></i> Hồ Sơ Cá Nhân</h4>
                    <p>Cập nhật thông tin bác sĩ</p>
                    <a href="profile.jsp" class="btn btn-primary">Xem chi tiết</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
