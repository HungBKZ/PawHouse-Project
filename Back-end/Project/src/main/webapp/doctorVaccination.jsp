<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %> 
<%@page import="java.util.List"%>
<%@page import="Model.MedicalRecords"%>
<%@page import="Model.Pet"%>
<%@page import="Model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <meta charset="UTF-8">
        <title>Quản Lý Tiêm Ngừa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #1e3a8a;    /* Xanh đậm quý phái */
                --secondary-color: #60a5fa;   /* Xanh sáng rực rỡ */
                --accent-color: #dbeafe;     /* Xanh nhạt thanh lịch */
                --background-color: #eff6ff; /* Nền pastel nhẹ */
                --text-color: #111827;       /* Chữ đen đậm tinh tế */
                --danger-color: #ef4444;     /* Đỏ sang trọng */
                --warning-color: #facc15;    /* Vàng nổi bật */
                --glass-bg: rgba(255, 255, 255, 0.85); /* Hiệu ứng kính mờ */
            }

            body {
                background: linear-gradient(120deg, var(--background-color) 0%, #dbeafe 50%, #ffffff 100%);
                color: var(--text-color);
                font-family: 'Inter', sans-serif;
                min-height: 100vh;
                margin: 0;
                padding: 2rem 0;
                overflow-x: hidden;
            }

            .container {
                background: var(--glass-bg);
                border-radius: 25px;
                padding: 2.5rem;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
                backdrop-filter: blur(12px);
                border: 1px solid rgba(255, 255, 255, 0.3);
                max-width: 1400px;
                margin: 0 auto;
            }

            .page-title {
                font-size: 3rem;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 2px;
                background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                text-align: center;
                margin-bottom: 3rem;
                position: relative;
                animation: fadeIn 1s ease-in;
            }

            .page-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 4px;
                background: linear-gradient(90deg, var(--secondary-color), var(--primary-color));
                border-radius: 2px;
            }

            .table {
                border-collapse: separate;
                border-spacing: 0 20px;
                background: transparent;
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
                border: none;
                font-weight: 700;
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
                transition: all 0.4s ease;
                border-radius: 20px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
                backdrop-filter: blur(8px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .table tbody tr:hover {
                transform: translateY(-8px) scale(1.02);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
                background: rgba(255, 255, 255, 0.95);
            }

            .pet-image-container {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                overflow: hidden;
                border: 4px solid var(--accent-color);
                transition: all 0.4s ease;
                position: relative;
                z-index: 1;
            }

            .pet-image-container::before {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(circle, rgba(96, 165, 250, 0.2), transparent);
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .pet-image-container:hover::before {
                opacity: 1;
            }

            .pet-image-container:hover {
                border-color: var(--secondary-color);
                transform: scale(1.1) rotate(5deg);
            }

            .pet-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.4s ease;
            }

            .pet-name {
                font-size: 1.3rem;
                font-weight: 700;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .pet-breed {
                font-size: 0.95rem;
                color: #6b7280;
                font-style: italic;
                letter-spacing: 0.5px;
            }

            .btn {
                border-radius: 10px;
                padding: 0.7rem 1.5rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                z-index: 1;
            }

            .btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: all 0.5s ease;
                z-index: -1;
            }

            .btn:hover::before {
                left: 100%;
            }

            .btn-primary {
                background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
                border: none;
            }

            .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(96, 165, 250, 0.4);
            }

            .btn-info {
                background: var(--secondary-color);
                border: none;
            }

            .btn-info:hover {
                background: var(--primary-color);
                transform: translateY(-3px);
            }

            .btn-warning {
                background: var(--warning-color);
                border: none;
            }

            .btn-warning:hover {
                background: #ca8a04;
                transform: translateY(-3px);
            }

            .btn-danger {
                background: var(--danger-color);
                border: none;
            }

            .btn-danger:hover {
                background: #b91c1c;
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
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

            .modal-content {
                border-radius: 20px;
                border: none;
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.25);
                background: linear-gradient(145deg, #ffffff, var(--accent-color));
                animation: slideUp 0.5s ease;
            }

            .modal-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                border-radius: 20px 20px 0 0;
                border: none;
                padding: 1.5rem 2rem;
            }

            .form-control, .form-select {
                border-radius: 10px;
                border: 2px solid var(--accent-color);
                padding: 0.75rem;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.9);
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--secondary-color);
                box-shadow: 0 0 15px rgba(96, 165, 250, 0.4);
                background: white;
            }

            .record-date {
                font-weight: 700;
                color: var(--primary-color);
                background: var(--accent-color);
                padding: 0.6rem 1.2rem;
                border-radius: 25px;
                display: inline-block;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            /* Animation keyframes */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(50px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .navbar {
                background: #fff;
                box-shadow: var(--shadow);
                padding: 15px 0;
            }

            .navbar-brand {
                font-size: 28px;
                font-weight: 800;
                color: #0072ff;
                transition: color 0.3s ease;
            }

            .navbar-brand:hover {
                color: #00c6ff;
            }

            .nav-link {
                font-size: 1.1rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                transition: all 0.3s ease;
            }

            .nav-link:hover {
                color: #0072ff;
            }
            
            /* CSS cho popup thông báo */
            .popup {
                display: none;
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 25px;
                border-radius: 8px;
                color: white;
                z-index: 9999;
                animation: slideIn 0.5s ease-out;
            }

            .popup.error {
                background-color: var(--danger-color);
                box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes fadeOut {
                from {
                    opacity: 1;
                }
                to {
                    opacity: 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Popup thông báo -->
        <div id="errorPopup" class="popup error"></div>
        
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top mb-3">
            <div class="container-fluid">
                <a class="navbar-brand" href="doctorIndex.jsp">PawHouse</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="profile.jsp"><i class="bi bi-person-circle"></i> Profile</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        

        <div class="container my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="page-title">Danh sách quản lý tiêm ngừa</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRecordModal">
                    <i class="fas fa-plus"></i> Thêm lịch tiêm
                </button>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Thú cưng</th>
                            <th>Chủ sở hữu</th>
                            <th>Chẩn đoán</th>
                            <th>Loại Vacxin Tiêm</th>
                            <th>Ngày tiêm</th>
                            <th>Ngày tiêm kế</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${records}" var="record">
                            <tr>
                                <td>
                                    <div class="pet-info">
                                        <div class="pet-image-container">
                                            <img src="${record.pet.petImage}" alt="${record.pet.petName}" class="pet-image">
                                        </div>
                                        <div class="pet-details">
                                            <span class="pet-name">${record.pet.petName}</span>
                                            <span class="pet-breed">${record.pet.breed}</span>
                                        </div>
                                    </div>
                                </td>
                                <td>${record.pet.owner.fullName}</td>
                                <td>${record.diagnosis}</td>
                                <td>${record.vaccinationDetails}</td>
                                <td>
                                    <fmt:formatDate value="${record.recordDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <fmt:formatDate value="${record.nextVaccinationDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info me-2" onclick="viewRecord(${record.recordID})">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-warning me-2"
                                            onclick="window.location.href = '${pageContext.request.contextPath}/UpdateDoctorVacxin?action=update&recordId=${record.recordID}'">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteRecord(${record.recordID})">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Record Modal -->
        <div class="modal fade" id="addRecordModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm hồ sơ bệnh án mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addRecordForm" action="${pageContext.request.contextPath}/DoctorVacxinServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Thú cưng</label>
                                    <select name="petId" class="form-select" required>
                                        <c:forEach items="${pet}" var="pet">
                                            <option value="${pet.petID}">${pet.petName} - ${pet.species} - ${pet.breed}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Bác sĩ</label>
                                    <select name="doctorId" class="form-select" required>
                                        <c:forEach items="${doctors}" var="doctor">
                                            <option value="${doctor.userID}">${doctor.fullName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label class="form-label">Cân nặng (kg)</label>
                                    <input type="number" step="0.1" name="weight" class="form-control" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Nhiệt độ (°C)</label>
                                    <input type="number" step="0.1" name="temperature" class="form-control" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Mã khám bệnh - Dịch vụ</label>
                                    <select name="appointmentId" class="form-control" required>
                                        <c:forEach items="${AppointmentsDoctor}" var="AppointmentsDoctor">
                                            <option value="${AppointmentsDoctor.appointmentID}">${AppointmentsDoctor.appointmentID} - ${AppointmentsDoctor.service.serviceName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Chẩn đoán</label>
                                <textarea name="diagnosis" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Loại vacxin tiêm</label>
                                <textarea name="vaccinationDetails" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ngày tiêm kế</label>
                                <input type="datetime-local" name="nextVaccinationDate" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea name="notes" class="form-control" rows="2"></textarea>
                            </div>
                            <div class="text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Record Modal -->
        <div class="modal fade" id="editRecordModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chỉnh sửa hồ sơ bệnh án</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editRecordForm" action="${pageContext.request.contextPath}/medical-record" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="recordId" id="editRecordId">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Cân nặng (kg)</label>
                                    <input type="number" step="0.1" name="weight" id="editWeight" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Nhiệt độ (°C)</label>
                                    <input type="number" step="0.1" name="temperature" id="editTemperature" class="form-control" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Chẩn đoán</label>
                                <textarea name="diagnosis" id="editDiagnosis" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Điều trị</label>
                                <textarea name="treatment" id="editTreatment" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Đơn thuốc</label>
                                <textarea name="prescription" id="editPrescription" class="form-control" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea name="notes" id="editNotes" class="form-control" rows="2"></textarea>
                            </div>
                            <div class="text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function viewRecord(recordId) {
                window.location.href = '${pageContext.request.contextPath}/DoctorVacxinServlet/' + recordId;
            }

            function editRecord(recordId) {
                fetch('${pageContext.request.contextPath}/DoctorVacxinServlet/' + recordId)
                    .then((response) => response.json())
                    .then((record) => {
                        document.getElementById('editRecordId').value = record.recordID;
                        document.getElementById('editWeight').value = record.weight;
                        document.getElementById('editTemperature').value = record.temperature;
                        document.getElementById('editDiagnosis').value = record.diagnosis;
                        document.getElementById('editTreatment').value = record.treatment;
                        document.getElementById('editPrescription').value = record.prescription;
                        document.getElementById('editNotes').value = record.notes;

                        new bootstrap.Modal(document.getElementById('editRecordModal')).show();
                    });
            }

            function deleteRecord(recordId) {
                if (confirm('Bạn có chắc chắn muốn xóa hồ sơ bệnh án này không?')) {
                    fetch('${pageContext.request.contextPath}/DoctorVacxinServlet/' + recordId, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                    })
                    .then(response => {
                        if (response.ok) {
                            location.reload();
                        } else {
                            showErrorPopup('Không thể xóa hồ sơ tiêm chủng');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showErrorPopup('Đã xảy ra lỗi khi xóa hồ sơ tiêm chủng');
                    });
                }
            }

            // Hàm hiển thị popup
            function showErrorPopup(message) {
                const popup = document.getElementById('errorPopup');
                popup.textContent = message;
                popup.style.display = 'block';
                
                // Tự động đóng sau 2 giây
                setTimeout(() => {
                    popup.style.animation = 'fadeOut 0.5s ease-out';
                    setTimeout(() => {
                        popup.style.display = 'none';
                        popup.style.animation = '';
                    }, 500);
                }, 2000);
            }
            
            // Kiểm tra và hiển thị thông báo lỗi nếu có
            <c:if test="${not empty errorMessage}">
                showErrorPopup("${errorMessage}");
            </c:if>
        </script>
        <div class="text-center mt-4">
            <a href="doctorIndex.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Quay lại danh sách
            </a>
        </div>

    </body>
</html>
