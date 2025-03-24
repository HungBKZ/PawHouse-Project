<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bảng Điều Khiển Nhân Viên - PawHouse</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
                font-family: 'Poppins', sans-serif;
                min-height: 100vh;
                margin: 0;
                padding-bottom: 80px;
                overflow-x: hidden;
            }
            .navbar {
                background: linear-gradient(90deg, #007bff, #0056b3);
                padding: 1rem 2rem;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }
            .navbar-brand, .nav-link {
                color: #fff !important;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
            }
            .nav-link:hover {
                color: #ffd700 !important;
                transform: scale(1.05);
            }
            .nav-link.active {
                border-bottom: 3px solid #ffd700;
            }
            .dashboard-container {
                margin: 40px auto;
                padding: 30px;
                max-width: 1300px;
                animation: fadeIn 0.8s ease-in-out;
            }
            .stats-card {
                background: #fff;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 25px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border-left: 5px solid #0056b3;
            }
            .stats-card:hover {
                transform: translateY(-10px) scale(1.02);
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            }
            .stats-icon {
                font-size: 3rem;
                color: #007bff;
                margin-bottom: 15px;
                transition: transform 0.3s ease;
            }
            .stats-card:hover .stats-icon {
                transform: rotate(10deg);
            }
            .chart-container {
                background: #fff;
                border-radius: 15px;
                padding: 30px;
                margin-top: 40px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                animation: slideUp 1s ease-out;
            }
            footer {
                background: linear-gradient(90deg, #0056b3, #003d80);
                color: #fff;
                text-align: center;
                padding: 20px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
                box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.2);
            }
            .profile-dropdown {
                position: relative;
            }
            .profile-content {
                display: none;
                position: absolute;
                right: 0;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                padding: 20px;
                min-width: 280px;
                z-index: 1000;
                animation: dropdown 0.3s ease;
            }
            .profile-dropdown:hover .profile-content {
                display: block;
            }
            .btn-profile {
                background: #fff;
                color: #0056b3;
                border: 2px solid #0056b3;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: 700;
                transition: all 0.3s ease;
            }
            .btn-profile:hover {
                background: #0056b3;
                color: #fff;
                transform: scale(1.05);
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            @keyframes slideUp {
                from {
                    transform: translateY(50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            @keyframes dropdown {
                from {
                    transform: translateY(-10px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            h3 {
                font-weight: 600;
                color: #333;
            }
            h2 {
                font-weight: 700;
                color: #0056b3;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-chart-line"></i> Bảng Điều Khiển</a></li>
                        <li class="nav-item"><a class="nav-link" href="StaffPetServlet"><i class="fas fa-paw"></i> Thú Cưng</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staffManageAdoption"><i class="fas fa-heart"></i> Nhận Nuôi</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/StaffAppointmentServlet?action=list"><i class="fas fa-calendar-check"></i> Lịch Hẹn</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staffManageOrder"><i class="fas fa-shopping-cart"></i> Đơn Hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/staff/report"><i class="fas fa-chart-bar"></i> Báo Cáo</a></li>
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
                            <a href="profile.jsp" class="btn btn-outline-primary w-100 mb-2">
                                <i class="fas fa-user-edit"></i> Cập Nhật Hồ Sơ
                            </a>
                            <a href="logout" class="btn btn-outline-danger w-100">
                                <i class="fas fa-sign-out-alt"></i> Đăng Xuất
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
                        <h3>Tổng Số Thú Cưng</h3>
                        <h2>${totalPets}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <i class="fas fa-heart stats-icon"></i>
                        <h3>Nhận Nuôi Đang Chờ</h3>
                        <h2>${pendingAdoptions != null ? pendingAdoptions : 0}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <i class="fas fa-calendar-check stats-icon"></i>
                        <h3>Lịch Hẹn Hôm Nay</h3>
                        <h2>${todayAppointments}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card text-center">
                        <i class="fas fa-box stats-icon"></i>
                        <h3>Sản Phẩm Của Shop</h3>
                        <h2>${totalProducts}</h2>
                    </div>
                </div>
            </div>

            <div class="chart-container">
                <canvas id="incomeChart"></canvas>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var ctx = document.getElementById("incomeChart").getContext("2d");
                var revenueData = ${revenueData};

                var incomeChart = new Chart(ctx, {
                    type: "bar",
                    data: {
                        labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
                        datasets: [{
                                label: "Doanh Thu Hàng Tháng",
                                data: revenueData,
                                backgroundColor: "rgba(0, 123, 255, 0.6)",
                                borderColor: "#007bff",
                                borderWidth: 2,
                                borderRadius: 10,
                                hoverBackgroundColor: "rgba(0, 123, 255, 0.9)"
                            }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: "top",
                                labels: {font: {size: 14, family: 'Poppins', weight: '600'}}
                            },
                            title: {
                                display: true,
                                text: 'Tổng Quan Doanh Thu Hàng Tháng',
                                font: {size: 20, family: 'Poppins', weight: '700'},
                                color: '#0056b3'
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function (value) {
                                        return value.toLocaleString('vi-VN') + ' VNĐ';
                                    },
                                    font: {family: 'Poppins'}
                                }
                            },
                            x: {
                                ticks: {font: {family: 'Poppins'}}
                            }
                        },
                        animation: {
                            duration: 1500,
                            easing: 'easeOutBounce'
                        }
                    }
                });
            });
        </script>
        <footer>
            <p class="m-0"> 2025 PawHouse. Mọi quyền được bảo lưu.</p>
        </footer>
    </body>
</html>