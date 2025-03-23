<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Hồ Sơ Quản Trị Viên - PawHouse</title>
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
        .profile-container {
            max-width: 800px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            flex: 1;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
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

<section class="container profile-container my-5">
    <h2 class="text-center mb-4">Hồ Sơ Quản Trị Viên</h2>
    <div class="text-center">
        <img src="https://source.unsplash.com/120x120/?person" class="profile-avatar mb-3" alt="Avatar" />
        <h4>Nguyễn Văn A</h4>
        <p class="text-muted">Quản trị viên</p>
    </div>
    <div class="card p-4">
        <h5>Thông Tin Cá Nhân</h5>
        <form>
            <div class="mb-3">
                <label class="form-label">Họ và Tên</label>
                <input type="text" class="form-control" value="Nguyễn Văn A" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" value="nguyenvana@gmail.com" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Số Điện Thoại</label>
                <input type="text" class="form-control" value="0123456789" required />
            </div>
            <div class="mb-3">
                <label class="form-label">Địa Chỉ</label>
                <input type="text" class="form-control" value="Hà Nội, Việt Nam" required />
            </div>
            <button type="submit" class="btn btn-primary w-100">Cập Nhật Thông Tin</button>
        </form>
    </div>
</section>

<section class="container profile-container my-5 text-center">
   <a href="adminNotification.jsp"> <button class="btn btn-outline-secondary w-100 mb-2"><i class="bi bi-bell"></i> Thiết Lập Thông Báo</button></a>
    <a href="adminRole.jsp"><button class="btn btn-outline-info w-100 mb-2"><i class="bi bi-key"></i> Quản Lý Phân Quyền</button></a>
    <a href="adminSupport.jsp"><button class="btn btn-outline-warning w-100 mb-2"><i class="bi bi-question-circle"></i> Hỗ Trợ & Hướng Dẫn</button></a>
    <a href="adminChangePass.jsp"><button class="btn btn-outline-danger w-100 mb-2"><i class="bi bi-lock"></i> Đổi Mật Khẩu</button></a>
    <a href="login.jsp"><button class="btn btn-danger w-100"><i class="bi bi-box-arrow-right"></i> Đăng Xuất</button></a>
</section>

<%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
