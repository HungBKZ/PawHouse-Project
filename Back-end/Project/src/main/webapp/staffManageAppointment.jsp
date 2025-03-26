<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Lịch Hẹn - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <style>
            body {
                background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
                font-family: 'Poppins', sans-serif;
                min-height: 100vh;
                padding-bottom: 100px;
                overflow-x: hidden;
            }
            .navbar {
                background: linear-gradient(90deg, #007bff, #004085);
                padding: 1.2rem 2rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            .navbar-brand {
                color: #fff !important;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                transition: all 0.3s ease;
            }
            .navbar-brand:hover {
                color: #ffd700 !important;
                transform: scale(1.05);
            }
            .container {
                margin-top: 50px;
                max-width: 1400px;
                animation: fadeIn 0.8s ease-in-out;
            }
            h2 {
                color: #0056b3;
                font-weight: 700;
                text-align: center;
                margin-bottom: 40px;
                letter-spacing: 1px;
            }
            .row.g-2 {
                background: #fff;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }
            .form-control, .form-select {
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: #007bff;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
            }
            .table {
                background: #fff;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                animation: slideUp 1s ease-out;
            }
            .table thead {
                background: linear-gradient(90deg, #007bff, #0056b3);
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .table th, .table td {
                vertical-align: middle;
                padding: 15px;
            }
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f8f9fa;
            }
            .table-hover tbody tr:hover {
                background-color: #e9ecef;
                transition: background-color 0.3s ease;
            }
            .form-select.appointment-status {
                max-width: 200px;
                border-radius: 10px;
                padding: 8px;
                font-weight: 500;
            }
            .btn-primary {
                background: #007bff;
                border: none;
                border-radius: 25px;
                padding: 8px 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-primary:hover {
                background: #0056b3;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
            }
            footer {
                background: linear-gradient(90deg, #0056b3, #003d80);
                color: #fff;
                text-align: center;
                padding: 20px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
                box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.2);
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
            .flatpickr-calendar {
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }
            .flatpickr-day.selected {
                background: #007bff !important;
                border-color: #007bff !important;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse</a>
            </div>
        </nav>

        <div class="container mt-5">
            <h2><i class="fas fa-calendar-check"></i> Quản Lý Lịch Hẹn</h2>

            <!-- 🔎 Bộ lọc tìm kiếm -->
            <div class="row g-2 mb-3">
                <div class="col-md-3">
                    <input type="text" id="searchCustomer" class="form-control" placeholder="Tìm theo khách hàng...">
                </div>
                <div class="col-md-3">
                    <input type="text" id="searchPet" class="form-control" placeholder="Tìm theo thú cưng...">
                </div>
                <div class="col-md-3">
                    <input type="text" id="searchService" class="form-control" placeholder="Tìm theo dịch vụ...">
                </div>
                <div class="col-md-3">
                    <input type="text" id="searchDate" class="form-control" placeholder="Chọn ngày hẹn..." autocomplete="off">
                </div>
                <div class="col-md-3">
                    <select id="searchStatus" class="form-select">
                        <option value="">Tất cả trạng thái</option>
                        <option value="0">Đang xử lý</option>
                        <option value="1">Đã duyệt</option>
                        <option value="null">Đã từ chối</option>   
                    </select>
                </div>
            </div>

            <!-- 🐾 Bảng danh sách lịch hẹn -->
            <table class="table table-striped mt-3">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Khách Hàng</th>
                        <th>Thú Cưng</th>
                        <th>Dịch Vụ</th>
                        <th>Ngày Hẹn</th>
                        <th>Trạng Thái</th>
                        <th>Nhân Viên</th>
                        <th>Giá</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody id="appointmentTable">
                    <c:forEach var="appointment" items="${appointments}">
                        <tr>
                            <td>${appointment.appointmentID}</td>
                            <td>${appointment.customer.fullName} (${appointment.customer.username})</td>
                            <td>${appointment.pet.petName}</td>
                            <td>${appointment.service.serviceName}</td>
                            <td>${appointment.appointmentDate}</td>
                            <td data-status="${appointment.appointmentStatus}">
                                <select class="form-select status-select">
                                    <option value="0" ${appointment.appointmentStatus == '0' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="1" ${appointment.appointmentStatus == '1' ? 'selected' : ''}>Duyệt</option>
                                    <option value="null" ${appointment.appointmentStatus == null ? 'selected' : ''}>Từ chối</option>
                                </select>
                            </td>
                            <td>
                                <select class="form-select staff-select">
                                    <option value="0">Không có</option>
                                    <c:forEach var="staff" items="${staff}">
                                        <option value="${staff.userID}" ${staff.userID == appointment.staff.userID ? 'selected' : ''}>${staff.username}</option>
                                    </c:forEach>
                                </select>
                            </td>

                            <td>${appointment.price} VND</td>
                            <td>
                                <form action="StaffAppointmentServlet" method="post">
                                    <input type="hidden" name="appointmentID" value="${appointment.appointmentID}">
                                    <input type="hidden" name="appointmentStatus" class="status-input" value="${appointment.appointmentStatus}">
                                    <input type="hidden" name="userID" class="staff-input" value="${appointment.staff != null ? appointment.staff.userID : '0'}">
                                    <button type="submit" class="btn btn-primary mt-2">Lưu</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <footer>
            <p> 2025 PawHouse. Mọi quyền được bảo lưu.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Update both status and staff inputs when their respective selects change
            document.querySelectorAll(".status-select").forEach(select => {
                select.addEventListener("change", function () {
                    let hiddenInput = this.closest("tr").querySelector(".status-input");
                    hiddenInput.value = this.value;
                });
            });

            document.querySelectorAll(".staff-select").forEach(select => {
                select.addEventListener("change", function () {
                    let hiddenInput = this.closest("tr").querySelector(".staff-input");
                    hiddenInput.value = this.value;
                });
            });

            // Kích hoạt Date Picker với style đẹp hơn
            flatpickr("#searchDate", {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "d/m/Y",
                allowInput: false,
                disableMobile: true
            });

            // Hàm lọc dữ liệu theo bộ lọc nhập liệu
            function filterAppointments() {
                let searchCustomer = document.getElementById("searchCustomer").value.toLowerCase();
                let searchPet = document.getElementById("searchPet").value.toLowerCase();
                let searchService = document.getElementById("searchService").value.toLowerCase();
                let searchDate = document.getElementById("searchDate").value;
                let searchStatus = document.getElementById("searchStatus").value;

                let rows = document.querySelectorAll("#appointmentTable tr");

                rows.forEach(row => {
                    let customer = row.cells[1].textContent.toLowerCase();
                    let pet = row.cells[2].textContent.toLowerCase();
                    let service = row.cells[3].textContent.toLowerCase();
                    let date = row.cells[4].textContent.trim();
                    let status = row.cells[5].querySelector(".status-select").value;

                    if (
                            customer.includes(searchCustomer) &&
                            pet.includes(searchPet) &&
                            service.includes(searchService) &&
                            (searchDate === "" || date === searchDate) &&
                            (searchStatus === "" || status === searchStatus)
                            ) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }

            // Gắn sự kiện lọc dữ liệu ngay khi nhập vào input hoặc thay đổi select
            document.querySelectorAll("input, select").forEach(input => {
                input.addEventListener("input", filterAppointments);
            });
        </script>
    </body>
</html>