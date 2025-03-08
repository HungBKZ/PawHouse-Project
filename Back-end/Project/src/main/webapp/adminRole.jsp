<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Quản Lý Phân Quyền - PawHouse</title>
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
        .role-container {
            max-width: 1000px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            flex: 1;
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
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">PawHouse</a>
    </div>
</nav>

<section class="container role-container my-5">
    <h2 class="text-center mb-4">Quản Lý Phân Quyền</h2>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên Người Dùng</th>
                <th>Vai Trò</th>
                <th>Thao Tác</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>#U101</td>
                <td>Nguyễn Văn A</td>
                <td>
                    <select class="form-select">
                        <option value="admin" selected>Quản Trị Viên</option>
                        <option value="staff">Nhân Viên</option>
                        <option value="customer">Khách Hàng</option>
                        <option value="doctor">Bác Sĩ</option>
                    </select>
                </td>
                <td>
                    <button class="btn btn-primary btn-sm">Lưu</button>
                </td>
            </tr>
            <tr>
                <td>#U102</td>
                <td>Trần Thị B</td>
                <td>
                    <select class="form-select">
                        <option value="admin">Quản Trị Viên</option>
                        <option value="staff" selected>Nhân Viên</option>
                        <option value="customer">Khách Hàng</option>
                        <option value="doctor">Bác Sĩ</option>
                    </select>
                </td>
                <td>
                    <button class="btn btn-primary btn-sm">Lưu</button>
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