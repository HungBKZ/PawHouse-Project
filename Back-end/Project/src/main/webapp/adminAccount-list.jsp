<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Quản Lý Tài Khoản - PawHouse</title>
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
            .account-container {
                max-width: 1200px;
                margin: auto;
                background: #ffffff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                flex: 1;
            }
            .account-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
            }
            .account-table th {
                background-color: #007bff;
                color: white;
            }
            .account-table td {
                vertical-align: middle;
                text-align: center;
            }
            .btn-icon {
                display: flex;
                align-items: center;
                justify-content: center;
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

        <!-- Quản Lý Tài Khoản -->
        <section class="container account-container my-5">
            <h2 class="text-center mb-4">Quản Lý Tài Khoản</h2>
            <div class="table-responsive">
                <table class="table table-striped table-hover account-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Hình Ảnh</th>
                            <th>Tên Người Dùng</th>
                            <th>Email</th>
                            <th>Vai Trò</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#U101</td>
                            <td><img src="https://source.unsplash.com/50x50/?person" class="account-avatar" alt="Avatar" /></td>
                            <td>Nguyễn Văn A</td>
                            <td>nguyenvana@gmail.com</td>
                            <td>Admin</td>
                            <td><span class="badge bg-success">Hoạt Động</span></td>
                            <td>
                                <button class="btn btn-warning btn-sm btn-icon"><i class="bi bi-pencil"></i></button>
                                <button class="btn btn-danger btn-sm btn-icon"><i class="bi bi-trash"></i></button>
                            </td>
                        </tr>
                        <!-- Các hàng tiếp theo tương tự -->
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Footer -->
        <%@ include file="includes/footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
