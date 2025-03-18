<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Appointment" %>
<%@ page import="Model.Pet" %>
<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Doctor Appointments</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                background-color: #f4f8fb;
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            .table {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .table th {
                background-color: #2f80ed;
                color: white;
                font-weight: 500;
            }
            .btn-action {
                padding: 5px 10px;
                margin: 2px;
                border-radius: 5px;
            }
            .appointment-form {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-top: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="mb-4">Danh sách lịch hẹn</h2>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Thú cưng</th>
                            <th>Khách hàng</th>
                            <th>Dịch vụ</th>
                            <th>Ngày hẹn</th>
                            <th>Trạng thái</th>
                            <th>Giá</th>
                            <th>Ghi chú</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="appointment" items="${appointments}">
                            <tr>
                                <td>${appointment.appointmentID}</td>
                                <td>${appointment.pet.petName}</td>
                                <td>${appointment.customer.fullName}</td>
                                <td>${appointment.service.serviceName}</td>
                                <td>${appointment.appointmentDate}</td>
                                <td>
                                    <span class="badge bg-${appointment.appointmentStatus == 'Đang sử dụng' ? 'primary' : 'success'}">
                                        ${appointment.appointmentStatus}
                                    </span>
                                </td>
                                <td>${appointment.price}</td>
                                <td>${appointment.notes}</td>
                                <td>
                                    <form action="AppointmentServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="appointmentID" value="${appointment.appointmentID}">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <c:if test="${appointment.appointmentStatus != 'Đã sử dụng'}">
                                            <button type="submit" class="btn btn-success btn-action" name="newStatus" value="Đã sử dụng">
                                                <i class="bi bi-check-circle"></i> Hoàn thành
                                            </button>
                                        </c:if>
                                    </form>
                                    <button type="button" class="btn btn-primary btn-action" onclick="viewDetails(${appointment.appointmentID})">
                                        <i class="bi bi-eye"></i> Chi tiết
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="appointment-form">
                <h3>Tạo lịch hẹn mới</h3>
                <form action="AppointmentServlet" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="petId">ID Thú cưng:</label>
                                <input type="number" class="form-control" name="petId" required>
                            </div>
                            <div class="form-group">
                                <label for="appointmentDate">Ngày hẹn:</label>
                                <input type="datetime-local" class="form-control" name="appointmentDate" required>
                            </div>
                            <div class="form-group">
                                <label for="serviceId">ID Dịch vụ:</label>
                                <input type="number" class="form-control" name="serviceId" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="customerId">ID Khách hàng:</label>
                                <input type="number" class="form-control" name="customerId" required>
                            </div>
                            <div class="form-group">
                                <label for="doctorId">ID Bác sĩ:</label>
                                <input type="number" class="form-control" name="doctorId" required>
                            </div>
                            <div class="form-group">
                                <label for="price">Giá:</label>
                                <input type="number" step="0.01" class="form-control" name="price" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-group">
                                <label for="notes">Ghi chú:</label>
                                <textarea class="form-control" name="notes" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Tạo lịch hẹn</button>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function viewDetails(appointmentId) {
                // Implement view details functionality
                alert('Xem chi tiết lịch hẹn ID: ' + appointmentId);
            }
        </script>
    </body>
</html>
