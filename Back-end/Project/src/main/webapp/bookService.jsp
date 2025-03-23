<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lịch hẹn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .booking-container {
                max-width: 650px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .booking-header img {
                max-width: 70px;
            }
            .form-control {
                border-radius: 20px;
                padding: 10px 15px;
                margin-bottom: 15px;
            }
            .btn-booking {
                border-radius: 20px;
                padding: 10px 20px;
                width: 100%;
                background-color: #4CAF50;
                border: none;
                color: white;
                font-weight: bold;
            }
            .btn-booking:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/navbar.jsp" %>

        <div class="container">
            <div class="booking-container">
                <div class="booking-header text-center mb-5">
                    <img src="./imgs/lg.png" alt="PawHouse Logo">
                    <h2>Đặt lịch hẹn với PawHouse</h2>
                    <p class="text-muted">Hãy Đặt Lịch Trước Để Chúng Tôi Có Thể Chuẩn Bị Và Chăm Sóc Thú Cưng Của Bạn Tốt Nhất!</p>
                </div>

                <form action="BookService" method="POST" id="bookingServiceForm" novalidate>
                    <div class="mb-3">
                        <label for="service" class="form-label">Tên Dịch Vụ</label>
                        <input type="text" class="form-control" id="service" disabled="true" value="${service.serviceName}"/>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="price" class="form-label">Giá Tiền</label>
                        <input type="text" class="form-control" id="price" disabled="true" value="${service.price}"/>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="pet" class="form-label">Chọn PET của bạn</label>
                        <select class="form-select" name="pet" required>
                            <c:forEach var="pet" items="${lstPet}">
                                <option value="${pet.petID}">${pet.petName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3 mt-3">
                        <label for="appointmentTime" class="form-label">Chọn thời gian đến PawHouse</label>
                        <input type="datetime-local" class="form-control" id="appointmentTime" name="appointmentTime" required>
                        <div class="invalid-feedback">Vui lòng chọn thời gian hợp lệ (sau ít nhất 2 tiếng từ hiện tại).</div>
                    </div>
                    <div class="mb-3">
                        <label for="note" class="form-label">Nhắn nhủ với shop</label>
                        <textarea class="form-control" id="note" name="note" rows="4" placeholder="Để lại thông tin cần lưu ý cho shop!"></textarea>
                    </div>
                    <input type="hidden" name="serviceID" value="${service.serviceID}"/>
                    <button type="submit" class="btn btn-booking">Xác nhận đặt lịch hẹn</button>
                </form>
            </div>
        </div>

        <%@ include file="includes/footer.jsp" %>

        <script>
            document.getElementById('bookingServiceForm').addEventListener('submit', function (event) {
                const input = document.getElementById('appointmentTime');
                const dateTimeValue = input.value;

                if (!dateTimeValue) {
                    input.classList.add('is-invalid');
                    event.preventDefault();
                    return;
                }

                const selectedDateTime = new Date(dateTimeValue);
                const now = new Date();
                const minDateTime = new Date(now.getTime() + 2 * 60 * 60 * 1000); // +2 tiếng

                if (selectedDateTime < minDateTime) {
                    input.classList.add('is-invalid');
                    event.preventDefault();
                } else {
                    input.classList.remove('is-invalid');
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
