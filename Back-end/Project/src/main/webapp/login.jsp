<%-- 
    Document   : login
    Created on : Feb 15, 2025, 10:06:35 PM
    Author     : hungv
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://accounts.google.com/gsi/client" async defer></script>
        <style>
            body {
                background: url('imgs/pethouse.png') no-repeat center center;
                background-size: contain; /* Giữ nguyên tỉ lệ, không kéo giãn ảnh */
                background-attachment: fixed; /* Giữ cố định khi cuộn */
                font-family: 'Arial', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }


            .login-container {
                width: 100%;
                max-width: 420px;
                padding: 30px;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
                text-align: center;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%); /* Đảm bảo canh giữa */
            }



            .login-header img {
                max-width: 120px;
                margin-bottom: 15px;
            }

            .login-header h2 {
                font-size: 26px;
                font-weight: bold;
                color: #ff9900;
            }

            .form-control {
                border-radius: 20px;
                padding: 12px 15px;
                border: 1px solid #ccc;
            }

            .btn-login {
                border-radius: 30px;
                padding: 12px;
                width: 100%;
                background-color: #00a991;
                color: white;
                font-weight: bold;
                border: none;
                transition: 0.3s;
            }

            .btn-login:hover {
                background-color: #008b76;
            }

            .forgot-password {
                text-align: right;
                margin: 10px 0;
            }

            .register-link {
                text-align: center;
                margin-top: 20px;
            }

            /* Google Button */
            .google-btn {
                text-align: center;
                margin-top: 15px;
            }

            .google-login-btn {
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #ffffff;
                color: #757575;
                font-size: 16px;
                font-weight: bold;
                padding: 12px 20px;
                border: 1px solid #d9d9d9;
                border-radius: 30px;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
                width: 100%;
            }

            .google-login-btn img {
                width: 20px;
                height: 20px;
                margin-right: 10px;
            }

            .google-login-btn:hover {
                background-color: #f1f1f1;
                border-color: #c0c0c0;
            }
        </style>
        <script>
            function togglePasswordVisibility() {
            var passwordField = document.getElementById("password");
            if (passwordField.type === "password") {
            passwordField.type = "text";
            } else {
            passwordField.type = "password";
            }
            }
        </script>

    </head>
    <body>
        <div class="container">
            <div class="nav-container">
                <ul class="nav-list">
                    <%
                        // Get cookies
                        String savedEmail = "";
                        String savedPassword = "";
                        Cookie[] cookies = request.getCookies();
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                if (cookie.getName().equals("savedEmail")) {
                                    savedEmail = cookie.getValue();
                                }
                                if (cookie.getName().equals("savedPassword")) {
                                    savedPassword = Utils.PasswordHasher.decodeBase64(cookie.getValue());
                                }
                            }
                        }

                        User user = (User) session.getAttribute("loggedInUser");
                        if (user == null) {
                    %>

                    <% } else {%>
                    <li class="nav-item"><span class="nav-link">Chào mừng, <%= user.getFullName()%></span></li>
                    <li class="nav-item"><a class="nav-link btn btn-danger text-white" href="logout">Đăng Xuất</a></li>
                        <% } %>
                </ul>
            </div>
            <div class="login-container">
                <div class="login-header">
                    <h2>🐾Chào mừng bạn🐾</h2>
                    <h2>đến với PawHouse</h2>
                </div>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error")%>
                </div>
                <% } %>

                <% if (session.getAttribute("success") != null) {%>
                <div class="alert alert-success" role="alert">
                    <%= session.getAttribute("success")%>
                </div>
                <% session.removeAttribute("success"); %>
                <% }%>

                <form action="login" method="POST">
                    <div class="mb-3">
                        <input type="email" class="form-control" name="email" placeholder="Tài khoản email" required value="<%= savedEmail%>">
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required value="<%= savedPassword%>">
                    </div>
                    
                    <div class="mb-3">
                        <input type="checkbox" id="showPasswordCheckbox" onclick="togglePasswordVisibility()"> Hiển thị mật khẩu
                    </div>

                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" <%= !savedEmail.isEmpty() ? "checked" : ""%>>
                        <label class="form-check-label" for="rememberMe">Lưu mật khẩu</label>
                    </div>
                    <div class="forgot-password">
                        <a href="forgotPassword.jsp">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="btn btn-primary btn-login">Đăng nhập</button>
                </form>

                <div class="text-center my-3">
                    <span>Hoặc</span>
                </div>
                <div class="google-btn">
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile
                       &redirect_uri=http://localhost:8080/google-login&response_type=code
                       &client_id=1042966270361-g65nrjskukgb6r5n2b6tbjrkbi9qi9fp.apps.googleusercontent.com">
                        <button class="google-login-btn">🌍  Đăng nhập với Google </button>
                    </a>
                </div>


                <div class="register-link">
                    <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký ngay tại đây</a></p>
                    <a href="index.jsp" class="btn btn-outline-secondary mt-3">
                        <i class="fas fa-arrow-left"></i> Quay Lại Trang Chủ
                    </a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function handleCredentialResponse(response) {
                            // Handle Google Sign-In response
                            console.log("Google Sign-In Response:", response);
                            // You'll need to implement the backend handling for Google Sign-In
            }
                            <script>
                function togglePasswordVisibility() {
                                    var passwordField = document.getElementById("password");
                            if (passwordField.type === "password") {
                            passwordField.type = "text";
                            } else {
                            passwordField.type = "password";
                            }
                }
                </script>

    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</body>
</html>
