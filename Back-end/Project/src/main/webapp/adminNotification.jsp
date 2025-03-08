<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thiết Lập Thông Báo - PawHouse</title>
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
        .notification-container {
            max-width: 800px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            flex: 1;
        }
       
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">PawHouse</a>
    </div>
</nav>

<section class="container notification-container my-5">
    <h2 class="text-center mb-4">Thiết Lập Thông Báo</h2>
    <form>
        <div class="form-check mb-2">
            <input class="form-check-input" type="checkbox" id="emailNotification" checked>
            <label class="form-check-label" for="emailNotification">Nhận thông báo qua Email</label>
        </div>
        <div class="form-check mb-2">
            <input class="form-check-input" type="checkbox" id="smsNotification">
            <label class="form-check-label" for="smsNotification">Nhận thông báo qua SMS</label>
        </div>
        <div class="form-check mb-2">
            <input class="form-check-input" type="checkbox" id="systemNotification" checked>
            <label class="form-check-label" for="systemNotification">Nhận thông báo trong hệ thống</label>
        </div>
        <button type="submit" class="btn btn-success w-100">Lưu Thiết Lập</button>
    </form>
</section>

<%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
