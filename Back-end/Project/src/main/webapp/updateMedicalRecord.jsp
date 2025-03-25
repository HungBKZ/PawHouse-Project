<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hồ sơ bệnh án</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Chỉnh sửa hồ sơ bệnh án</h5>
        </div>
        <div class="card-body">
            <!-- 🐶 Thông tin Pet -->
            <div class="mb-4 border-bottom pb-3">
                <h6>🐾 Thú cưng: <strong>${record.pet.petName}</strong></h6>
                <p>Giống: ${record.pet.breed} | Loài: ${record.pet.species}</p>
                <img src="${record.pet.petImage}" alt="${record.pet.petName}" width="120" class="img-thumbnail">
            </div>

            <!-- Form cập nhật -->
            <form action="${pageContext.request.contextPath}/medical-record" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="recordId" value="${record.recordID}">

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Cân nặng (kg)</label>
                        <input type="number" step="0.1" name="weight" class="form-control" value="${record.weight}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Nhiệt độ (°C)</label>
                        <input type="number" step="0.1" name="temperature" class="form-control" value="${record.temperature}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Chẩn đoán</label>
                    <textarea name="diagnosis" class="form-control" rows="3" required>${record.diagnosis}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Điều trị</label>
                    <textarea name="treatment" class="form-control" rows="3" required>${record.treatment}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Đơn thuốc</label>
                    <textarea name="prescription" class="form-control" rows="3">${record.prescription}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Ghi chú</label>
                    <textarea name="notes" class="form-control" rows="2">${record.notes}</textarea>
                </div>

                <div class="text-end">
                    <a href="medical-record" class="btn btn-secondary">Hủy</a>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS (nếu cần) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
