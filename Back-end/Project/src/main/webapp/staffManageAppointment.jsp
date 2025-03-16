<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản Lý Lịch Hẹn - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> <!-- Bộ lịch -->
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> <!-- JavaScript của Flatpickr -->

        <style>
            body {
                background-color: #f8f9fa;
                padding-bottom: 70px;
            }
            .navbar {
                background-color: #0056b3;
            }
            .navbar-brand, .nav-link {
                color: white !important;
                font-weight: bold;
            }
            footer {
                text-align: center;
                padding: 20px;
                background-color: #0056b3;
                color: white;
                position: fixed;
                width: 100%;
                bottom: 0;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/staffDashboard"><i class="fas fa-paw"></i> PawHouse Staff</a>

            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="text-center">Quản Lý Lịch Hẹn</h2>

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
                        <option value="1">Đang sử dụng dịch vụ</option>
                        <option value="0">Đã sử dụng dịch vụ</option>
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
                                <select class="form-select appointment-status">
                                    <option value="1" ${appointment.appointmentStatus == '1' ? 'selected' : ''}>Đang sử dụng dịch vụ</option>
                                    <option value="0" ${appointment.appointmentStatus == '0' ? 'selected' : ''}>Đã sử dụng dịch vụ</option>
                                </select>
                            </td>
                            <td>${appointment.price} VND</td>
                            <td>
                                <form action="StaffAppointmentServlet" method="post">
                                    <input type="hidden" name="appointmentID" value="${appointment.appointmentID}">
                                    <input type="hidden" name="appointmentStatus" class="status-input" value="${appointment.appointmentStatus}">
                                    <button type="submit" class="btn btn-primary mt-2">Lưu</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <footer>
            <p>&copy; 2025 PawHouse. All rights reserved.</p>
        </footer>

        <script>
            // 🌟 Bắt sự kiện thay đổi trạng thái để cập nhật giá trị vào input ẩn
            document.querySelectorAll(".appointment-status").forEach(select => {
                select.addEventListener("change", function () {
                    let hiddenInput = this.closest("tr").querySelector(".status-input");
                    hiddenInput.value = this.value;
                });
            });

            // 📅 Kích hoạt Date Picker với format giống Google Form
            flatpickr("#searchDate", {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "d/m/Y",
                allowInput: false
            });

            // 🔎 Hàm lọc dữ liệu theo bộ lọc nhập liệu
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
                    let status = row.cells[5].querySelector(".appointment-status").value;

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

            // 🌟 Gắn sự kiện lọc dữ liệu ngay khi nhập vào input hoặc thay đổi select
            document.querySelectorAll("input, select").forEach(input => {
                input.addEventListener("input", filterAppointments);
            });
        </script>
    </body>
</html>
