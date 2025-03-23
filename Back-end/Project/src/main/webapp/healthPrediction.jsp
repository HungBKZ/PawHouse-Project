<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dự đoán sức khỏe thú cưng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- jsPDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
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
            padding: 40px;
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
        h3 {
            color: #e74c3c;
            font-weight: 600;
            margin-top: 30px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .pet-info {
            background: linear-gradient(90deg, #74ebd5, #acb6e5);
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            color: #2c3e50;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .pet-info p {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 500;
        }
        .table-container {
            margin-top: 20px;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background: linear-gradient(90deg, #e74c3c, #c0392b);
            color: white;
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
        .chart-container {
            margin-top: 40px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            background: #fff;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background: linear-gradient(90deg, #e74c3c, #c0392b);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            color: white;
            transition: all 0.3s;
            margin-right: 10px;
        }
        .btn-custom:hover {
            background: linear-gradient(90deg, #c0392b, #e74c3c);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }
        .btn-share {
            background: linear-gradient(90deg, #3498db, #2980b9);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            color: white;
            transition: all 0.3s;
        }
        .btn-share:hover {
            background: linear-gradient(90deg, #2980b9, #3498db);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        .btn-back {
            background: linear-gradient(90deg, #2ecc71, #27ae60);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 30px;
            transition: all 0.3s;
        }
        .btn-back:hover {
            background: linear-gradient(90deg, #27ae60, #2ecc71);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Dự đoán sức khỏe cho <span style="color: #e74c3c;">${pet.petName}</span></h2>
        <div class="pet-info">
            <p><strong>Loài:</strong> ${pet.species} | <strong>Giống:</strong> ${pet.breed} | <strong>Tuổi:</strong> ${pet.age}</p>
        </div>

        <h3>Nguy cơ sức khỏe tiềm ẩn</h3>
        <c:choose>
            <c:when test="${empty predictions}">
                <p class="text-muted text-center">Không có nguy cơ nào được dự đoán.</p>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Nguy cơ</th>
                                <th>Xác suất</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prediction" items="${predictions}">
                                <tr>
                                    <td>${prediction.risk}</td>
                                    <td>${prediction.probability * 100}%</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Biểu đồ -->
                <div class="chart-container">
                    <canvas id="healthChart"></canvas>
                </div>

                <!-- Nút tải xuống PDF và chia sẻ -->
                <div class="text-center mt-4">
                    <button class="btn-custom" onclick="downloadPDF()">
                        <i class="fas fa-download"></i> Tải xuống báo cáo PDF
                    </button>
                    <button class="btn-share" onclick="shareReport()">
                        <i class="fas fa-share-alt"></i> Chia sẻ
                    </button>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Nút quay lại -->
        <div class="text-center">
            <a href="selectPet" class="btn-back">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách thú cưng
            </a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Dữ liệu cho biểu đồ
        const labels = [
            <c:forEach var="prediction" items="${predictions}" varStatus="loop">
                "${prediction.risk}"${loop.last ? '' : ','}
            </c:forEach>
        ];
        const data = [
            <c:forEach var="prediction" items="${predictions}" varStatus="loop">
                ${prediction.probability * 100}${loop.last ? '' : ','}
            </c:forEach>
        ];
        const colors = [
            'rgba(231, 76, 60, 0.6)',  // Đỏ
            'rgba(52, 152, 219, 0.6)', // Xanh lam
            'rgba(46, 204, 113, 0.6)', // Xanh lá
            'rgba(155, 89, 182, 0.6)', // Tím
        ];

        // Vẽ biểu đồ
        const ctx = document.getElementById('healthChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Xác suất nguy cơ (%)',
                    data: data,
                    backgroundColor: colors.slice(0, data.length),
                    borderColor: colors.slice(0, data.length).map(color => color.replace('0.6', '1')),
                    borderWidth: 1
                }]
            },
            options: {
                animation: {
                    duration: 1500,
                    easing: 'easeInOutQuart'
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        title: {
                            display: true,
                            text: 'Xác suất (%)',
                            font: { size: 14, weight: 'bold' }
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.1)'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Nguy cơ',
                            font: { size: 14, weight: 'bold' }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#2c3e50',
                        titleFont: { size: 14 },
                        bodyFont: { size: 12 },
                        callbacks: {
                            label: function(context) {
                                return `Xác suất: ${context.raw}%`;
                            }
                        }
                    }
                }
            }
        });

        // Tải xuống PDF
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            // Tiêu đề
            doc.setFontSize(20);
            doc.setTextColor(231, 76, 60);
            doc.text('Báo cáo sức khỏe thú cưng', 20, 20);

            // Thông tin thú cưng
            doc.setFontSize(12);
            doc.setTextColor(44, 62, 80);
            doc.text(`Tên: ${"${pet.petName}"}`, 20, 35);
            doc.text(`Loài: ${"${pet.species}"} | Giống: ${"${pet.breed}"} | Tuổi: ${"${pet.age}"}`, 20, 45);

            // Dòng kẻ
            doc.setDrawColor(231, 76, 60);
            doc.setLineWidth(0.5);
            doc.line(20, 50, 190, 50);

            // Nguy cơ sức khỏe
            doc.setFontSize(14);
            doc.text('Nguy cơ sức khỏe tiềm ẩn:', 20, 60);

            let y = 70;
            <c:forEach var="prediction" items="${predictions}">
                doc.setFontSize(12);
                doc.text(`- ${"${prediction.risk}"}: ${"${prediction.probability * 100}"}%`, 20, y);
                y += 10;
            </c:forEach>

            // Chân trang
            doc.setFontSize(10);
            doc.setTextColor(150);
            doc.text('PawHouse - Báo cáo sức khỏe thú cưng', 20, 280);
            doc.text('Ngày: ' + new Date().toLocaleDateString(), 150, 280);

            doc.save('bao_cao_suc_khoe_${pet.petName}.pdf');
        }

        // Chia sẻ (giả lập)
        function shareReport() {
            alert('Chức năng chia sẻ đang được phát triển! Bạn có thể sao chép URL này: ' + window.location.href);
            // Có thể tích hợp API chia sẻ thực tế (email, mạng xã hội) nếu cần
        }
    </script>
</head>
<body>
</body>
</html>