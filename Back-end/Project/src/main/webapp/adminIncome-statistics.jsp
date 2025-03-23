<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thống Kê Thu Nhập - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #eef5f9;
            font-family: "Arial", sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .income-container {
            max-width: 1200px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            flex: 1;
        }
        .chart-container {
            position: relative;
            height: 400px;
        }
        .filter-container {
            margin-bottom: 20px;
        }
        .footer {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 15px 0;
            width: 100%;
            margin-top: auto;
            border-top: 4px solid #0056b3;
        }
        h2 {
            color: #0056b3;
            font-weight: bold;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">PawHouse</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="adminDashboard.jsp">Trang chủ</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Thống Kê Thu Nhập -->
<section class="container income-container my-5">
    <h2 class="text-center mb-4">Thống Kê Thu Nhập</h2>
    
    <!-- Bộ lọc dữ liệu -->
    <div class="filter-container text-center">
        <label for="yearSelect">Chọn Năm: </label>
        <select id="yearSelect" class="form-select d-inline-block w-auto">
            <option value="2023">2023</option>
            <option value="2024" selected>2024</option>
            <option value="2025">2025</option>
        </select>
    </div>
    
    <div class="chart-container">
        <canvas id="incomeChart"></canvas>
    </div>
</section>

<!-- Footer -->
<%@ include file="includes/footer.jsp" %>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var ctx = document.getElementById("incomeChart").getContext("2d");
        var incomeChart;

        function updateChart(year) {
            var dataSets = {
                "2023": [40000000, 50000000, 60000000, 70000000, 80000000, 90000000],
                "2024": [50000000, 60000000, 70000000, 80000000, 90000000, 100000000],
                "2025": [55000000, 65000000, 75000000, 85000000, 95000000, 105000000]
            };
            
            if (incomeChart) {
                incomeChart.destroy();
            }
            
            incomeChart = new Chart(ctx, {
                type: "line",
                data: {
                    labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"],
                    datasets: [{
                        label: "Doanh thu (VNĐ)",
                        data: dataSets[year],
                        borderColor: "#007bff",
                        backgroundColor: "rgba(0, 123, 255, 0.2)",
                        borderWidth: 2,
                        fill: true,
                    }],
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: "top",
                        },
                    },
                },
            });
        }
        
        document.getElementById("yearSelect").addEventListener("change", function () {
            updateChart(this.value);
        });
        
        updateChart("2024");
    });
</script>
</body>
</html>
