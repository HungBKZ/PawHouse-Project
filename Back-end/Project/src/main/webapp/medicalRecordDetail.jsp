<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết hồ sơ bệnh án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2b6cb0;
            --secondary-color: #4299e1;
            --accent-color: #90cdf4;
            --background-color: #f7fafc;
            --text-color: #2d3748;
            --success-color: #48bb78;
            --warning-color: #ecc94b;
            --danger-color: #f56565;
        }
        
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            background: white;
        }
        
        .card-header {
            background-color: var(--primary-color);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 1rem 1.5rem;
        }
        
        .info-icon {
            background-color: var(--accent-color);
            color: var(--primary-color);
            padding: 8px;
            border-radius: 50%;
            margin-right: 10px;
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .status-badge.success {
            background-color: #c6f6d5;
            color: #22543d;
        }
        
        .status-badge.warning {
            background-color: #fefcbf;
            color: #744210;
        }
        
        .status-badge.danger {
            background-color: #fed7d7;
            color: #822727;
        }
        
        .detail-section {
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .detail-section:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: #718096;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .detail-value {
            color: var(--text-color);
            font-size: 1.1rem;
        }
        
        .btn-back {
            background-color: var(--primary-color);
            color: white;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            background-color: var(--secondary-color);
            color: white;
            transform: translateY(-2px);
        }
        
        .pet-image {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        
        .contact-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }
        
        .contact-info i {
            color: var(--primary-color);
        }
        
        .service-box {
            background-color: #ebf8ff;
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .vital-sign {
            text-align: center;
            padding: 1rem;
            background-color: #ebf8ff;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        
        .vital-sign .value {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .vital-sign .label {
            color: #718096;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <c:if test="${record != null}">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <h2 class="text-center mb-4">Chi tiết hồ sơ bệnh án</h2>
                    
                    <!-- Thông tin thú cưng -->
                    <div class="card mb-4">
                        <div class="card-header d-flex align-items-center">
                            <div class="info-icon">
                                <i class="fas fa-paw"></i>
                            </div>
                            <h4 class="mb-0">Thông tin thú cưng</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 text-center">
                                    <c:if test="${not empty record.pet.petImage}">
                                        <img src="${record.pet.petImage}" alt="${record.pet.petName}" class="pet-image">
                                    </c:if>
                                    <c:if test="${empty record.pet.petImage}">
                                        <img src="https://via.placeholder.com/150" alt="No image" class="pet-image">
                                    </c:if>
                                </div>
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="detail-section">
                                                <div class="detail-label">Tên thú cưng</div>
                                                <div class="detail-value">${record.pet.petName}</div>
                                            </div>
                                            <div class="detail-section">
                                                <div class="detail-label">Loài</div>
                                                <div class="detail-value">${record.pet.species}</div>
                                            </div>
                                            <div class="detail-section">
                                                <div class="detail-label">Giống</div>
                                                <div class="detail-value">${record.pet.breed}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="detail-section">
                                                <div class="detail-label">Tuổi</div>
                                                <div class="detail-value">${record.pet.age} tuổi</div>
                                            </div>
                                            <div class="detail-section">
                                                <div class="detail-label">Giới tính</div>
                                                <div class="detail-value">${record.pet.gender}</div>
                                            </div>
                                            <div class="detail-section">
                                                <div class="detail-label">Danh mục</div>
                                                <div class="detail-value">${record.pet.category.categoryName}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Thông tin chủ sở hữu -->
                            <div class="detail-section mt-3">
                                <div class="detail-label">Thông tin chủ sở hữu</div>
                                <div class="detail-value">
                                    <div class="contact-info">
                                        <i class="fas fa-user"></i>
                                        ${record.pet.owner.fullName}
                                    </div>
                                    <div class="contact-info">
                                        <i class="fas fa-envelope"></i>
                                        ${record.pet.owner.email}
                                    </div>
                                    <div class="contact-info">
                                        <i class="fas fa-phone"></i>
                                        ${record.pet.owner.phone}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin cuộc hẹn -->
                    <c:if test="${record.appointment != null}">
                        <div class="card mb-4">
                            <div class="card-header d-flex align-items-center">
                                <div class="info-icon">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <h4 class="mb-0">Thông tin cuộc hẹn</h4>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="detail-section">
                                            <div class="detail-label">Mã cuộc hẹn</div>
                                            <div class="detail-value">#${record.appointment.appointmentID}</div>
                                        </div>
                                        <div class="detail-section">
                                            <div class="detail-label">Ngày hẹn</div>
                                            <div class="detail-value">
                                                <fmt:formatDate value="${record.appointment.appointmentDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="detail-section">
                                            <div class="detail-label">Ngày đặt lịch</div>
                                            <div class="detail-value">
                                                <fmt:formatDate value="${record.appointment.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </div>
                                        <div class="detail-section">
                                            <div class="detail-label">Trạng thái</div>
                                            <div class="detail-value">
                                                <c:choose>
                                                    <c:when test="${record.appointment.appointmentStatus == 'COMPLETED'}">
                                                        <span class="status-badge success">
                                                            <i class="fas fa-check-circle"></i>
                                                            Hoàn thành
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${record.appointment.appointmentStatus == 'PENDING'}">
                                                        <span class="status-badge warning">
                                                            <i class="fas fa-clock"></i>
                                                            Chờ xử lý
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge danger">
                                                            <i class="fas fa-times-circle"></i>
                                                            ${record.appointment.appointmentStatus}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${record.appointment.service != null}">
                                    <div class="service-box">
                                        <div class="detail-label">Dịch vụ</div>
                                        <div class="detail-value">
                                            <strong>${record.appointment.service.serviceName}</strong>
                                        </div>
                                        <div class="mt-2">
                                            ${record.appointment.service.description}
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${not empty record.appointment.notes}">
                                    <div class="detail-section">
                                        <div class="detail-label">Ghi chú cuộc hẹn</div>
                                        <div class="detail-value">${record.appointment.notes}</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <!-- Thông tin khám bệnh -->
                    <div class="card mb-4">
                        <div class="card-header d-flex align-items-center">
                            <div class="info-icon">
                                <i class="fas fa-stethoscope"></i>
                            </div>
                            <h4 class="mb-0">Thông tin khám bệnh</h4>
                        </div>
                        <div class="card-body">
                            <!-- Thông tin bác sĩ -->
                            <div class="detail-section">
                                <div class="detail-label">Bác sĩ phụ trách</div>
                                <div class="detail-value">
                                    <div class="contact-info">
                                        <i class="fas fa-user-md"></i>
                                        ${record.doctor.fullName}
                                    </div>
                                    <div class="contact-info">
                                        <i class="fas fa-envelope"></i>
                                        ${record.doctor.email}
                                    </div>
                                </div>
                            </div>

                            <!-- Dấu hiệu sinh tồn -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="vital-sign">
                                        <div class="value">${record.weight} kg</div>
                                        <div class="label">Cân nặng</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="vital-sign">
                                        <div class="value">${record.temperature}°C</div>
                                        <div class="label">Nhiệt độ</div>
                                    </div>
                                </div>
                            </div>

                            <div class="detail-section">
                                <div class="detail-label">Chẩn đoán</div>
                                <div class="detail-value">${record.diagnosis}</div>
                            </div>

                            <div class="detail-section">
                                <div class="detail-label">Phương pháp điều trị</div>
                                <div class="detail-value">${record.treatment}</div>
                            </div>

                            <div class="detail-section">
                                <div class="detail-label">Đơn thuốc</div>
                                <div class="detail-value">${record.prescription}</div>
                            </div>

                            <c:if test="${not empty record.vaccinationDetails}">
                                <div class="detail-section">
                                    <div class="detail-label">Chi tiết tiêm chủng</div>
                                    <div class="detail-value">${record.vaccinationDetails}</div>
                                    <div class="mt-2">
                                        <span class="status-badge warning">
                                            <i class="fas fa-syringe"></i>
                                            Lịch tiêm chủng tiếp theo: 
                                            <fmt:formatDate value="${record.nextVaccinationDate}" pattern="dd/MM/yyyy"/>
                                        </span>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty record.notes}">
                                <div class="detail-section">
                                    <div class="detail-label">Ghi chú bổ sung</div>
                                    <div class="detail-value">${record.notes}</div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <a href="../medical-record" class="btn btn-back">
                            <i class="fas fa-arrow-left me-2"></i>
                            Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${record == null}">
            <div class="alert alert-danger text-center">
                <i class="fas fa-exclamation-circle me-2"></i>
                Không tìm thấy hồ sơ bệnh án
            </div>
            <div class="text-center mt-3">
                <a href="../medical-record" class="btn btn-back">
                    <i class="fas fa-arrow-left me-2"></i>
                    Quay lại danh sách
                </a>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
