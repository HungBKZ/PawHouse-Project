<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .reset-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .reset-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .reset-header img {
                max-width: 150px;
                margin-bottom: 20px;
            }
            .form-control {
                border-radius: 20px;
                padding: 10px 15px;
                margin-bottom: 15px;
            }
            .btn-reset {
                border-radius: 20px;
                padding: 10px 20px;
                width: 100%;
                background-color: #4CAF50;
                border: none;
                color: white;
                font-weight: bold;
            }
            .btn-reset:hover {
                background-color: #45a049;
            }
            .password-requirements {
                font-size: 0.9em;
                color: #666;
                margin: 15px 0;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 5px;
            }
            .password-requirements ul {
                margin: 0;
                padding-left: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="reset-container">
                <div class="reset-header">
                    <h2>Tạo Lại Mật Khẩu</h2>
                    <p class="text-muted">Tạo mật khẩu mới của bạn</p>
                </div>

                <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form action="forgotPassword" method="POST" id="resetForm">
                    <input type="hidden" name="action" value="resetPassword">
                    <input type="hidden" name="email" value="${requestScope.email}">

                    <div class="mb-3">
                        <label for="newPassword" class="form-label">Mật Khẩu Mới</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required
                               pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">
                    </div>

                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Xác Nhận Mật Khẩu Mới</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <div class="password-requirements">
                        <strong>Yêu Cầu Mật Khẩu:</strong>
                        <ul>
                            <li>Ít nhất có 8 ký tự</li>
                            <li>Phải chứa chữ cái và số</li>
                            <li>Cả hai mật khẩu phải trùng nhau</li>
                        </ul>
                    </div>

                    <button type="submit" class="btn btn-reset">Tạo Lại Mật Khẩu</button>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById('resetForm').addEventListener('submit', function (event) {
                var password = document.getElementById('newPassword').value;
                var confirmPassword = document.getElementById('confirmPassword').value;

                if (password !== confirmPassword) {
                    event.preventDefault();
                    alert('Mật khẩu không khớp nhau!');
                }
            });
        </script>
    </body>
</html>
