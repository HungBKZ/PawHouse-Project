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
        <!-- jsPDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
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
                background: #17a2b8;
                padding: 0.8rem 1.5rem;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-bottom: 1px solid #dee2e6;
            }
            .navbar-brand, .nav-link {
                color: #000 !important;
                font-weight: 600;
                font-size: 1rem;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                padding: 0.5rem 1rem;
            }
            .navbar-brand i, .nav-link i {
                color: #000;
                margin-right: 5px;
            }
            .navbar-brand:hover, .nav-link:hover {
                color: #007bff !important;
            }
            .navbar-brand:hover i, .nav-link:hover i {
                color: #007bff;
            }
            .navbar-toggler {
                padding: 0.25rem 0.5rem;
                border: none;
            }
            .btn-export {
                background: linear-gradient(90deg, #e74c3c, #c0392b);
                border: none;
                color: white;
                padding: 10px 25px;
                border-radius: 50px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                margin-right: 15px;
            }
            .btn-export:hover {
                transform: translateY(-2px);
                box-shadow: 0 7px 20px rgba(0, 0, 0, 0.3);
                background: linear-gradient(90deg, #c0392b, #e74c3c);
                color: white;
            }
            .btn-print {
                background: linear-gradient(90deg, #9b59b6, #8e44ad);
                border: none;
                color: white;
                padding: 10px 25px;
                border-radius: 50px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
            }
            .btn-print:hover {
                transform: translateY(-2px);
                box-shadow: 0 7px 20px rgba(0, 0, 0, 0.3);
                background: linear-gradient(90deg, #8e44ad, #9b59b6);
                color: white;
            }
            @media print {
                body {
                    background: white;
                }
                .navbar, .btn-export, .btn-print {
                    display: none;
                }
                .container-fluid {
                    width: 100%;
                    margin: 0;
                    padding: 15px;
                }
                .card {
                    border: none;
                    box-shadow: none;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <span class="navbar-brand"><i class="fas fa-paw"></i> PawHouse</span>
                <div class="navbar-nav me-auto">
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
                </div>
                <div class="d-flex">
                    <button class="btn-export me-2" onclick="generatePDF()">
                        <i class="fas fa-file-pdf me-2"></i>Xuất PDF
                    </button>
                    <button class="btn-print" onclick="window.print()">
                        <i class="fas fa-print me-2"></i>In báo cáo
                    </button>
                </div>
            </div>
        </nav>

        <div class="container-fluid py-4" id="report-content">
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

                        async function generatePDF() {
                            const {jsPDF} = window.jspdf;
                            const doc = new jsPDF();

                            // Lấy nội dung cần chuyển thành PDF
                            const content = document.getElementById('report-content');

                            try {
                                // Chuyển HTML thành canvas
                                const canvas = await html2canvas(content, {
                                    scale: 2,
                                    useCORS: true,
                                    logging: false
                                });

                                // Chuyển canvas thành ảnh
                                const imgData = canvas.toDataURL('image/png');

                                // Tính toán kích thước để fit vào trang PDF
                                const imgWidth = 210; // A4 width in mm
                                const pageHeight = 295; // A4 height in mm
                                const imgHeight = canvas.height * imgWidth / canvas.width;

                                // Thêm ảnh vào PDF
                                doc.addImage(imgData, 'PNG', 0, 0, imgWidth, imgHeight);

                                // Thêm footer
                                doc.setFontSize(10);
                                doc.setTextColor(150);
                                const today = new Date().toLocaleDateString('vi-VN');
                                doc.text('Báo cáo được tạo ngày: ' + today, 10, pageHeight - 10);

                                // Tải PDF
                                doc.save('bao_cao_doanh_thu_' + today.replace(/\//g, '_') + '.pdf');

                            } catch (error) {
                                console.error('Lỗi khi tạo PDF:', error);
                                alert('Có lỗi xảy ra khi tạo PDF. Vui lòng thử lại.');
                            }
                        }
        </script>
    </body>
</html>