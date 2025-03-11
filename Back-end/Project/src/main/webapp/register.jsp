<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .register-container {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .register-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .register-header img {
                max-width: 150px;
                margin-bottom: 20px;
            }
            .form-control {
                border-radius: 20px;
                padding: 10px 15px;
                margin-bottom: 15px;
            }
            .btn-register {
                border-radius: 20px;
                padding: 10px 20px;
                width: 100%;
                background-color: #4CAF50;
                border: none;
                color: white;
                font-weight: bold;
            }
            .btn-register:hover {
                background-color: #45a049;
            }
            .login-link {
                text-align: center;
                margin-top: 20px;
            }
            .required::after {
                content: " *";
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="register-container">
                <div class="register-header">
                    <img src="assets/images/logo.png" alt="PawHouse Logo">
                    <h2>Create Your Account</h2>
                    <p class="text-muted">Đăng Ký PawHouse Và Bắt Đầu Qúa Trình Chăm Sóc Thú Cưng Của Bạn!</p>
                </div>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error")%>
                </div>
                <% }%>

                <form action="register" method="POST" id="registerForm">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="username" class="form-label required">Tên Đăng Nhập</label>
                                <input type="text" class="form-control" id="username" name="username" required
                                       pattern="[a-zA-Z0-9_]{3,20}" 
                                       title="Tên người dùng phải có độ dài từ 3 đến 20 ký tự và chỉ được chứa chữ cái, số và dấu gạch dưới.">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="email" class="form-label required">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="password" class="form-label required">Nhập Mật Khẩu</label>
                                <input type="password" class="form-control" id="password" name="password" required
                                       pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
                                       title=" Mật khẩu phải có ít nhất 8 ký tự và bao gồm cả chữ cái và số">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label required">Nhập Lại Mật Khẩu</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <input type="checkbox" id="showPasswordCheckbox" onclick="togglePasswordVisibility()"> Hiển thị mật khẩu
                    </div>

                    <div class="mb-3">
                        <label for="fullName" class="form-label required">Họ Và Tên</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label required">Số Điện Thoại</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required
                               pattern="[0-9]{10}"
                               title="Chỉ Được Nhập 10 số">
                    </div>

                    <button type="submit" class="btn btn-register">Tạo Tài Khoản</button>
                </form>

                <div class="login-link">
                    Nếu Đã Có Tài Khoản? <a href="login.jsp">Đăng Nhập ở đây</a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
        document.getElementById('registerForm').addEventListener('submit', function (event) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                event.preventDefault();
                alert('Passwords do not match!');
            }
        });
        
        function togglePasswordVisibility() {
    var passwordField = document.getElementById("password");
    var confirmPasswordField = document.getElementById("confirmPassword");

    if (passwordField.type === "password") {
        passwordField.type = "text";
        confirmPasswordField.type = "text";
    } else {
        passwordField.type = "password";
        confirmPasswordField.type = "password";
    }
}

        </script>
    </body>
</html>
