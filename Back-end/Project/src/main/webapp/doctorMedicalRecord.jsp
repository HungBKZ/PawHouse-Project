<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ Sơ Y Tế</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .action-buttons .btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Hồ Sơ Y Tế</h2>
            <a href="${pageContext.request.contextPath}/doctor/medical-records?action=create" class="btn btn-success">
                <i class="fas fa-plus"></i> Thêm Hồ Sơ Mới
            </a>
        </div>
        
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Thú Cưng</th>
                        <th>Chủ Sở Hữu</th>
                        <th>Chẩn Đoán</th>
                        <th>Điều Trị</th>
                        <th>Đơn Thuốc</th>
                        <th>Cân Nặng (kg)</th>
                        <th>Nhiệt Độ (°C)</th>
                        <th>Tiêm Chủng</th>
                        <th>Ngày Tiêm Tiếp</th>
                        <th>Ghi Chú</th>
                        <th>Ngày Khám</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="record" items="${records}">
                        <tr data-record-id="${record.recordID}">
                            <td>${record.recordID}</td>
                            <td>${record.pet.petName}</td>
                            <td>${record.pet.owner.fullName}</td>
                            <td>${record.diagnosis}</td>
                            <td>${record.treatment}</td>
                            <td>${record.prescription}</td>
                            <td>${record.weight}</td>
                            <td>${record.temperature}</td>
                            <td>${record.vaccinationDetails}</td>
                            <td>${record.nextVaccinationDate}</td>
                            <td>${record.notes}</td>
                            <td>${record.recordDate}</td>
                            <td class="action-buttons">
                                <div class="btn-group" role="group">
                                    <a class="btn btn-sm btn-primary" 
                                       href="${pageContext.request.contextPath}/doctor/medical-records?action=edit&id=${record.recordID}">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form style="display: inline;" 
                                          method="post" 
                                          action="${pageContext.request.contextPath}/doctor/medical-records">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${record.recordID}">
                                        <button class="btn btn-sm btn-danger" 
                                                type="button" 
                                                onclick="if(confirm('Bạn có chắc chắn muốn xóa hồ sơ y tế này không?')) this.form.submit();">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
