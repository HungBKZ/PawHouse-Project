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
    :root {
        --primary-color: #1e3a8a;    /* Xanh đậm quý phái */
        --secondary-color: #60a5fa;   /* Xanh sáng rực rỡ */
        --accent-color: #dbeafe;     /* Xanh nhạt thanh lịch */
        --background-color: #eff6ff; /* Nền pastel nhẹ */
        --text-color: #111827;       /* Chữ đen đậm tinh tế */
        --success-color: #10b981;    /* Xanh lá thành công */
        --danger-color: #ef4444;     /* Đỏ nguy hiểm */
        --glass-bg: rgba(255, 255, 255, 0.9); /* Hiệu ứng kính mờ */
    }

    body {
        background: linear-gradient(135deg, var(--background-color) 0%, #dbeafe 50%, #ffffff 100%);
        color: var(--text-color);
        font-family: 'Inter', sans-serif;
        min-height: 100vh;
        margin: 0;
        padding: 3rem 0;
        overflow-x: hidden;
    }

    .container {
        background: var(--glass-bg);
        border-radius: 25px;
        padding: 3rem;
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        max-width: 1400px;
        animation: fadeIn 0.8s ease-in;
    }

    h2, h3 {
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        position: relative;
        margin-bottom: 2rem;
    }

    h2::after, h3::after {
        content: '';
        position: absolute;
        bottom: -8px;
        left: 0;
        width: 60px;
        height: 4px;
        background: linear-gradient(90deg, var(--secondary-color), var(--primary-color));
        border-radius: 2px;
    }

    .table {
        background: transparent;
        border-collapse: separate;
        border-spacing: 0 20px;
        border-radius: 20px;
        box-shadow: none;
    }

    .table thead {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        text-transform: uppercase;
        letter-spacing: 1px;
        box-shadow: 0 6px 20px rgba(30, 58, 138, 0.2);
    }

    .table th {
        padding: 1.5rem;
        font-weight: 700;
        border: none;
        position: relative;
    }

    .table th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 50%;
        height: 2px;
        background: rgba(255, 255, 255, 0.3);
    }

    .table tbody tr {
        background: var(--glass-bg);
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
        backdrop-filter: blur(8px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.4s ease;
    }

    .table tbody tr:hover {
        transform: translateY(-5px) scale(1.01);
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        background: rgba(255, 255, 255, 0.95);
    }

    .table td {
        padding: 1.5rem;
        vertical-align: middle;
        color: var(--text-color);
        font-weight: 500;
    }
.btn-back {
        background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
        color: white;
        border: none;
        border-radius: 50px;
        padding: 0.8rem 2rem;
        font-size: 1.1rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(30, 58, 138, 0.3);
    }

    .btn-back:hover {
        transform: scale(1.08);
        box-shadow: 0 10px 25px rgba(96, 165, 250, 0.4);
        color: white;
    }
    .badge {
        padding: 0.6rem 1.2rem;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }

    .badge.bg-primary {
        background: var(--primary-color);
    }

    .badge.bg-success {
        background: var(--success-color);
    }

    .badge:hover {
        transform: scale(1.05);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .btn-action {
        padding: 0.6rem 1.2rem;
        margin: 0.3rem;
        border-radius: 10px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border: none;
        position: relative;
        overflow: hidden;
    }

    .btn-action::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: all 0.5s ease;
        z-index: 0;
    }

    .btn-action:hover::before {
        left: 100%;
    }

    .btn-success {
        background: var(--success-color);
    }

    .btn-success:hover {
        background: #059669;
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
    }

    .btn-primary {
        background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
    }

    .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(96, 165, 250, 0.3);
    }

    .btn-action i {
        margin-right: 0.5rem;
    }

    .appointment-form {
        background: var(--glass-bg);
        padding: 2.5rem;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        margin-top: 3rem;
        animation: slideUp 0.8s ease-in;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-group label {
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 0.5rem;
        display: block;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .form-control {
        border-radius: 10px;
        border: 2px solid var(--accent-color);
        padding: 0.75rem;
        transition: all 0.3s ease;
        background: rgba(255, 255, 255, 0.9);
        font-size: 1rem;
    }

    .form-control:focus {
        border-color: var(--secondary-color);
        box-shadow: 0 0 15px rgba(96, 165, 250, 0.3);
        background: white;
    }

    .alert {
        border-radius: 15px;
        padding: 1.5rem;
        font-size: 1.1rem;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
        animation: fadeIn 0.5s ease-in;
    }

    .alert-danger {
        background: linear-gradient(145deg, #fee2e2, #fecaca);
        color: var(--danger-color);
    }

    .alert-success {
        background: linear-gradient(145deg, #d1fae5, #a7f3d0);
        color: var(--success-color);
    }

    /* Animations */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes slideUp {
        from { opacity: 0; transform: translateY(50px); }
        to { opacity: 1; transform: translateY(0); }
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
            <div class="text-center mt-4">
            <a href="doctorIndex.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Quay lại danh sách
            </a>
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
