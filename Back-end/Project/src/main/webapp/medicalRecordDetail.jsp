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
        --primary-color: #1e3a8a;    /* Xanh đậm quý phái */
        --secondary-color: #60a5fa;   /* Xanh sáng rực rỡ */
        --accent-color: #dbeafe;     /* Xanh nhạt thanh lịch */
        --background-color: #eff6ff; /* Nền pastel nhẹ */
        --text-color: #111827;       /* Chữ đen đậm tinh tế */
        --success-color: #10b981;    /* Xanh lá thành công */
        --warning-color: #f59e0b;    /* Vàng cảnh báo */
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
        max-width: 1200px;
        animation: fadeIn 0.8s ease-in;
    }

    .card {
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
        background: var(--glass-bg);
        backdrop-filter: blur(8px);
        transition: all 0.4s ease;
        overflow: hidden;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
    }

    .pet-header {
        text-align: center;
        padding: 3rem 1.5rem;
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        border-radius: 20px 20px 0 0;
        color: white;
        position: relative;
        overflow: hidden;
    }

    .pet-header::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.2), transparent);
        opacity: 0.3;
        animation: rotate 20s linear infinite;
    }

    .pet-header-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        border: 6px solid white;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        margin: 0 auto 1.5rem;
        object-fit: cover;
        transition: all 0.4s ease;
        position: relative;
        z-index: 1;
    }

    .pet-header-image:hover {
        transform: scale(1.1) rotate(5deg);
        border-color: var(--accent-color);
    }

    .pet-header-name {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 0.75rem;
        text-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        letter-spacing: 1px;
        position: relative;
        z-index: 1;
    }

    .pet-header-breed {
        font-size: 1.25rem;
        opacity: 0.9;
        font-style: italic;
        letter-spacing: 0.5px;
        z-index: 1;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 2rem;
        padding: 2rem;
    }

    .info-item {
        background: linear-gradient(145deg, #ffffff, var(--accent-color));
        padding: 1.5rem;
        border-radius: 15px;
        text-align: center;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }

    .info-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .info-label {
        color: #6b7280;
        font-size: 0.95rem;
        font-weight: 600;
        margin-bottom: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .info-value {
        color: var(--primary-color);
        font-size: 1.2rem;
        font-weight: 700;
        background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .owner-section {
        padding: 2rem;
        border-top: 2px solid var(--accent-color);
    }

    .owner-card {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        padding: 1.5rem;
        background: var(--glass-bg);
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }

    .owner-card:hover {
        transform: scale(1.02);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .owner-icon {
        width: 60px;
        height: 60px;
        background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        box-shadow: 0 4px 15px rgba(30, 58, 138, 0.3);
    }

    .owner-info h3 {
        margin: 0;
        font-size: 1.4rem;
        font-weight: 700;
        color: var(--primary-color);
    }

    .owner-contact {
        color: #6b7280;
        font-size: 1rem;
        margin-top: 0.5rem;
        line-height: 1.5;
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        border-radius: 20px 20px 0 0;
        padding: 1.5rem 2rem;
        display: flex;
        align-items: center;
        gap: 1rem;
        position: relative;
        overflow: hidden;
    }

    .card-header::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.15), transparent);
        opacity: 0.4;
        animation: rotate 15s linear infinite;
    }

    .card-header h5 {
        margin: 0;
        font-size: 1.5rem;
        font-weight: 700;
        letter-spacing: 0.5px;
        position: relative;
        z-index: 1;
    }

    .card-body {
        padding: 2rem;
    }

    .detail-section {
        margin-bottom: 1.5rem;
    }

    .detail-label {
        font-size: 1.1rem;
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .detail-value {
        font-size: 1.15rem;
        color: var(--text-color);
        background: var(--accent-color);
        padding: 1rem;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .vital-sign {
        text-align: center;
        padding: 1.5rem;
        background: linear-gradient(145deg, #ffffff, var(--accent-color));
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }

    .vital-sign:hover {
        transform: scale(1.05);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .vital-sign .value {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
    }

    .vital-sign .label {
        font-size: 1rem;
        color: #6b7280;
        margin-top: 0.5rem;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.95rem;
    }

    .status-badge.success {
        background: var(--success-color);
        color: white;
    }

    .status-badge.warning {
        background: var(--warning-color);
        color: white;
    }

    .status-badge.danger {
        background: var(--danger-color);
        color: white;
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

    .alert {
        border-radius: 15px;
        padding: 1.5rem;
        font-size: 1.2rem;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    /* Animations */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes rotate {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
</style>
</head>
<body>
    <div class="container py-5">
        <c:if test="${record != null}">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card mb-4">
                        <!-- Pet Header with Image -->
                        <div class="pet-header">
                           
                            <h1 class="pet-header-name">${record.pet.petName}</h1>
                            <div class="pet-header-breed">${record.pet.species} - ${record.pet.breed}</div>
                        </div>

                        <!-- Pet Information Grid -->
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">Tuổi</div>
                                <div class="info-value">${record.pet.age} tuổi</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Loài</div>
                                <div class="info-value">${record.pet.species}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Giống</div>
                                <div class="info-value">${record.pet.breed}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Giới tính</div>
                                <div class="info-value">${record.pet.gender}</div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Danh mục</div>
                                <div class="info-value">${record.pet.category.categoryName}</div>
                            </div>
                        </div>

                        <!-- Owner Information -->
                        <div class="owner-section">
                            <h3 class="mb-3">Thông tin chủ sở hữu</h3>
                            <div class="owner-card">
                                <div class="owner-icon">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="owner-info">
                                    <h3>${record.pet.owner.fullName}</h3>
                                    <div class="owner-contact">
                                        <div><i class="fas fa-envelope me-2"></i>${record.pet.owner.email}</div>
                                        <div><i class="fas fa-phone me-2"></i>${record.pet.owner.phone}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Medical Information -->
                    <div class="card mb-4">
                        <div class="card-header d-flex align-items-center">
                            <div class="info-icon">
                                <i class="fas fa-stethoscope"></i>
                            </div>
                            <h5 class="mb-0">Thông tin khám bệnh</h5>
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

                    <!-- Appointment Information if available -->
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
                </div>
            </div>
        </c:if>
        
        <c:if test="${record == null}">
            <div class="alert alert-danger text-center">
                <i class="fas fa-exclamation-circle me-2"></i>
                Không tìm thấy hồ sơ bệnh án
            </div>
        </c:if>
        
        <div class="text-center mt-4">
            <a href="../medical-record" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Quay lại danh sách
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
