<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Thú Cưng - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
    <style>
        body {
            background-color: #eef5f9;
            font-family: 'Arial', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .pet-container {
            max-width: 1200px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            flex: 1;
        }
        .pet-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        .pet-table th {
            background-color: #007bff;
            color: white;
        }
        .pet-table td {
            vertical-align: middle;
            text-align: center;
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

<section class="container pet-container my-5">
    <h2 class="text-center mb-4">Quản Lý Thú Cưng</h2>
    <div class="table-responsive">
        <table class="table table-striped table-hover pet-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Hình Ảnh</th>
                <th>Tên Thú Cưng</th>
                <th>Loại</th>
                <th>Tuổi</th>
                <th>Chủ Sở Hữu</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>#P101</td>
                <td><img src="https://source.unsplash.com/50x50/?dog" class="pet-avatar" alt="Avatar" /></td>
                <td>Lucky</td>
                <td>Chó</td>
                <td>3 năm</td>
                <td>Nguyễn Văn A</td>
                <td><span class="badge bg-success">Đang Chăm Sóc</span></td>
                <td>
                    <button class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i></button>
                    <button class="btn btn-danger btn-sm"><i class="bi bi-trash"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</section>

<%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>