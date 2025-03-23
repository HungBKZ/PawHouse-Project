<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chọn Thú Cưng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #74ebd5 0%, #acb6e5 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }
        .container {
            margin-top: 50px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            color: #2c3e50;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .filter-container {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .filter-container input {
            padding: 10px;
            border-radius: 25px;
            border: 1px solid #ddd;
            width: 200px;
            transition: all 0.3s;
        }
        .filter-container input:focus {
            outline: none;
            border-color: #2ecc71;
            box-shadow: 0 0 10px rgba(46, 204, 113, 0.3);
        }
        .table-container {
            max-height: 500px;
            overflow-y: auto;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background: linear-gradient(90deg, #3498db, #2ecc71);
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .table td {
            vertical-align: middle;
            color: #34495e;
        }
        .table tr {
            transition: all 0.3s ease;
        }
        .table tr:hover {
            background: #f1f8ff;
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-primary {
            background: linear-gradient(90deg, #2ecc71, #27ae60);
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #27ae60, #2ecc71);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
        }
        .btn-info {
            background: linear-gradient(90deg, #3498db, #2980b9);
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-info:hover {
            background: linear-gradient(90deg, #2980b9, #3498db);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        .btn-secondary {
            background: linear-gradient(90deg, #e74c3c, #c0392b);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            transition: all 0.3s;
        }
        .btn-secondary:hover {
            background: linear-gradient(90deg, #c0392b, #e74c3c);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }
        .modal-content {
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        .modal-header {
            background: linear-gradient(90deg, #3498db, #2ecc71);
            color: white;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .modal-body p {
            margin: 10px 0;
            color: #34495e;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chọn Thú Cưng Để Theo Dõi Sức Khỏe</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- Bộ lọc -->
        <div class="filter-container">
            <input type="text" id="filterName" placeholder="Tìm theo tên..." onkeyup="filterPets()">
            <input type="text" id="filterSpecies" placeholder="Tìm theo loài..." onkeyup="filterPets()">
            <input type="text" id="filterBreed" placeholder="Tìm theo giống..." onkeyup="filterPets()">
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty pets}">
                    <p class="text-muted text-center mt-3">Không có thú cưng nào để hiển thị.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered" id="petTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Loài</th>
                                <th>Giống</th>
                                <th>Tuổi</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pet" items="${pets}">
                                <tr>
                                    <td>${pet.petID}</td>
                                    <td>${pet.petName}</td>
                                    <td>${pet.species}</td>
                                    <td>${pet.breed}</td>
                                    <td>${pet.age}</td>
                                    <td>
                                        <a href="predictHealth?petId=${pet.petID}" class="btn btn-primary btn-sm">
                                            <i class="fas fa-heart-pulse"></i> Theo dõi
                                        </a>
                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#petModal${pet.petID}">
                                            <i class="fas fa-info-circle"></i> Chi tiết
                                        </button>
                                    </td>
                                </tr>

                                <!-- Modal chi tiết thú cưng -->
                                <div class="modal fade" id="petModal${pet.petID}" tabindex="-1" aria-labelledby="petModalLabel${pet.petID}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="petModalLabel${pet.petID}">Thông Tin Thú Cưng: ${pet.petName}</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p><strong>ID:</strong> ${pet.petID}</p>
                                                <p><strong>Tên:</strong> ${pet.petName}</p>
                                                <p><strong>Loài:</strong> ${pet.species}</p>
                                                <p><strong>Giống:</strong> ${pet.breed}</p>
                                                <p><strong>Tuổi:</strong> ${pet.age}</p>
                                                <p><strong>Giới tính:</strong> ${pet.gender != null ? pet.gender : "Chưa có thông tin"}</p>
                                                <p><strong>Trạng thái nhận nuôi:</strong> ${pet.adoptionStatus != null ? pet.adoptionStatus : "Chưa có thông tin"}</p>
                                                <p><strong>Chủ sở hữu:</strong> ${pet.owner != null ? pet.owner.fullName : "Chưa có chủ"}</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="text-center mt-4">
            <a href="doctorIndex.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterPets() {
            const nameFilter = document.getElementById("filterName").value.toLowerCase();
            const speciesFilter = document.getElementById("filterSpecies").value.toLowerCase();
            const breedFilter = document.getElementById("filterBreed").value.toLowerCase();
            const rows = document.querySelectorAll("#petTable tbody tr");

            rows.forEach(row => {
                const name = row.cells[1].textContent.toLowerCase();
                const species = row.cells[2].textContent.toLowerCase();
                const breed = row.cells[3].textContent.toLowerCase();

                if (name.includes(nameFilter) && species.includes(speciesFilter) && breed.includes(breedFilter)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</body>
</html>