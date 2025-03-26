<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Báo Cáo Doanh Thu - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
                font-family: 'Poppins', sans-serif;
                min-height: 100vh;
                padding-bottom: 70px;
                overflow-x: hidden;
            }
            /* Style lại navbar */
            .navbar {
                background: #17a2b8; /* Nền trắng */
                padding: 0.8rem 1.5rem; /* Giảm padding để nhỏ gọn */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Shadow nhẹ */
                border-bottom: 1px solid #dee2e6; /* Đường viền dưới */
            }
            .navbar-brand, .nav-link {
                color: #000 !important; /* Chữ màu đen */
                font-weight: 600;
                font-size: 1rem;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                padding: 0.5rem 1rem;
            }
            .navbar-brand i, .nav-link i {
                color: #000; /* Icon màu đen */
                margin-right: 5px;
            }
            .navbar-brand:hover, .nav-link:hover {
                color: #007bff !important; /* Hover đổi màu xanh */
            }
            .navbar-brand:hover i, .nav-link:hover i {
                color: #007bff; /* Icon cũng đổi màu xanh khi hover */
            }
            .navbar-toggler {
                padding: 0.25rem 0.5rem;
                border: none;
            }
            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(0, 0, 0, 0.75)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            }
            .report-card {
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
            }
            .report-card:hover {
                transform: translateY(-5px);
            }
            .chart-container {
                position: relative;
                height: 300px;
                margin: 20px 0;
            }
            .container-fluid {
                padding: 40px 20px;
            }
            h1 {
                color: #0056b3;
                font-weight: 700;
                margin-bottom: 40px;
                letter-spacing: 1px;
            }
            .form-select, .form-control {
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
            }
            .btn-primary {
                background: #007bff;
                border: none;
                border-radius: 25px;
                padding: 10px 20px;
            }
            .bg-primary {
                background: linear-gradient(90deg, #007bff, #0056b3) !important;
            }
            .bg-success {
                background: linear-gradient(90deg, #28a745, #218838) !important;
            }
            .bg-info {
                background: linear-gradient(90deg, #17a2b8, #138496) !important;
            }
            .bg-warning {
                background: linear-gradient(90deg, #ffc107, #e0a800) !important;
            }
            .text-white h5 {
                font-weight: 600;
                color: #fff;
            }
            .text-white h3 {
                font-weight: 700;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <span class="navbar-brand"><i class="fas fa-paw"></i> PawHouse</span>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <c:choose>
                                <c:when test="${sessionScope.user.role.roleID == 1}">
                                    <a class="nav-link" href="/adminDashboard.jsp"><i class="fas fa-home"></i> Trang chủ Admin</a>
                                </c:when>
                                <c:when test="${sessionScope.user.role.roleID == 3}">
                                    <a class="nav-link" href="/staffDashboard"><i class="fas fa-home"></i> Trang chủ Staff</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="nav-link" href="/"><i class="fas fa-home"></i> Trang chủ</a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid py-4">
            <h1 class="mb-4"><i class="fas fa-chart-line"></i> Báo Cáo Doanh Thu</h1>

            <!-- Bộ lọc thời gian -->
            <div class="card report-card mb-4">
                <div class="card-body">
                    <form action="/staff/report" method="GET" class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-filter"></i> Loại báo cáo</label>
                            <select name="type" class="form-select">
                                <option value="daily" ${param.type == 'daily' ? 'selected' : ''}>Theo ngày</option>
                                <option value="monthly" ${param.type == 'monthly' ? 'selected' : ''}>Theo tháng</option>
                                <option value="yearly" ${param.type == 'yearly' ? 'selected' : ''}>Theo năm</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-calendar"></i> Từ ngày</label>
                            <input type="date" name="startDate" class="form-control" value="${param.startDate}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label"><i class="fas fa-calendar"></i> Đến ngày</label>
                            <input type="date" name="endDate" class="form-control" value="${param.endDate}" required>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search"></i> Xem báo cáo
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Tổng quan -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card report-card bg-primary text-white">
                        <div class="card-body">
                            <h5><i class="fas fa-coins"></i> Tổng doanh thu</h5>
                            <h3 class="mb-0">
                                <fmt:formatNumber value="${report.totalRevenue}" type="currency" currencySymbol="₫"/>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card report-card bg-success text-white">
                        <div class="card-body">
                            <h5><i class="fas fa-shopping-cart"></i> Doanh thu sản phẩm</h5>
                            <h3 class="mb-0">
                                <fmt:formatNumber value="${report.productRevenue}" type="currency" currencySymbol="₫"/>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card report-card bg-info text-white">
                        <div class="card-body">
                            <h5><i class="fas fa-handshake"></i> Doanh thu dịch vụ</h5>
                            <h3 class="mb-0">
                                <fmt:formatNumber value="${report.serviceRevenue}" type="currency" currencySymbol="₫"/>
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card report-card bg-warning text-white">
                        <div class="card-body">
                            <h5><i class="fas fa-users"></i> Tổng khách hàng</h5>
                            <h3 class="mb-0">${report.totalCustomers}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Biểu đồ -->
            <div class="row mb-4">
                <div class="col-md-8">
                    <div class="card report-card">
                        <div class="card-body">
                            <h5 class="card-title">Biểu đồ doanh thu theo thời gian</h5>
                            <div class="chart-container">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card report-card">
                        <div class="card-body">
                            <h5 class="card-title">Tỷ lệ doanh thu</h5>
                            <div class="chart-container">
                                <canvas id="pieChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Chi tiết báo cáo -->
            <div class="card report-card">
                <div class="card-body">
                    <h5 class="card-title mb-4">Chi tiết báo cáo</h5>

                    <!-- Tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="#orders">
                                <i class="fas fa-shopping-bag"></i> Đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#services">
                                <i class="fas fa-clipboard-list"></i> Dịch vụ
                            </a>
                        </li>
                    </ul>

                    <!-- Tab content -->
                    <div class="tab-content mt-3">
                        <!-- Đơn hàng -->
                        <div id="orders" class="tab-pane active">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Ngày</th>
                                            <th>Khách hàng</th>
                                            <th>Sản phẩm</th>
                                            <th>Số lượng</th>
                                            <th>Đơn giá</th>
                                            <th>Thành tiền</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${report.orderDetails}" var="order">
                                            <tr>
                                                <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                                                <td>${order.customerName}</td>
                                                <td>${order.productName}</td>
                                                <td>${order.quantity}</td>
                                                <td><fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫"/></td>
                                                <td><fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫"/></td>
                                                <td>
                                                    <span class="badge ${order.status == 'Hoàn thành' ? 'bg-success' : 'bg-warning'}">
                                                        ${order.status}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Dịch vụ -->
                        <div id="services" class="tab-pane fade">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Ngày</th>
                                            <th>Khách hàng</th>
                                            <th>Thú cưng</th>
                                            <th>Dịch vụ</th>
                                            <th>Giá</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${report.serviceDetails}" var="service">
                                            <tr>
                                                <td><fmt:formatDate value="${service.appointmentDate}" pattern="dd/MM/yyyy"/></td>
                                                <td>${service.customerName}</td>
                                                <td>${service.petName}</td>
                                                <td>${service.serviceName}</td>
                                                <td><fmt:formatNumber value="${service.price}" type="currency" currencySymbol="₫"/></td>
                                                <td>
                                                    <span class="badge ${service.status == 'Hoàn thành' ? 'bg-success' : 'bg-warning'}">
                                                        ${service.status}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
        const dates = <c:out value="${report.reportDatesJson}" escapeXml="false"/>;
        const productRevs = <c:out value="${report.productRevenuesJson}" escapeXml="false"/>;
        const serviceRevs = <c:out value="${report.serviceRevenuesJson}" escapeXml="false"/>;
        const prodRev = <c:out value="${report.productRevenue}"/>;
        const servRev = <c:out value="${report.serviceRevenue}"/>;

        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [
                    {label: 'Doanh thu sản phẩm', data: productRevs, borderColor: 'rgb(40, 167, 69)', tension: 0.1},
                    {label: 'Doanh thu dịch vụ', data: serviceRevs, borderColor: 'rgb(23, 162, 184)', tension: 0.1}
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function (value) {
                                return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(value);
                            }
                        }
                    }
                }
            }
        });

        const pieCtx = document.getElementById('pieChart').getContext('2d');
        new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: ['Sản phẩm', 'Dịch vụ'],
                datasets: [{data: [prodRev, servRev], backgroundColor: ['rgb(40, 167, 69)', 'rgb(23, 162, 184)']}]
            },
            options: {responsive: true, maintainAspectRatio: false}
        });
        </script>
    </body>
</html>