<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đổi Mật Khẩu - PawHouse</title>
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
        .change-password-container {
            max-width: 500px;
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

<section class="container change-password-container my-5">
    <h2 class="text-center mb-4">Đổi Mật Khẩu</h2>
    <form>
        <div class="mb-3">
            <label class="form-label">Mật Khẩu Hiện Tại</label>
            <input type="password" class="form-control" required />
        </div>
        <div class="mb-3">
            <label class="form-label">Mật Khẩu Mới</label>
            <input type="password" class="form-control" required />
        </div>
        <div class="mb-3">
            <label class="form-label">Xác Nhận Mật Khẩu Mới</label>
            <input type="password" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-primary w-100">Cập Nhật Mật Khẩu</button>
    </form>
</section>

    <%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
