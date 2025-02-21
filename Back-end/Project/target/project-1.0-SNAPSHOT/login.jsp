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
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .login-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .login-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .login-header img {
                max-width: 150px;
                margin-bottom: 20px;
            }
            .form-control {
                border-radius: 20px;
                padding: 10px 15px;
            }
            .btn-login {
                border-radius: 20px;
                padding: 10px 20px;
                width: 100%;
                background-color: #4CAF50;
                border: none;
            }
            .btn-login:hover {
                background-color: #45a049;
            }
            .google-btn {
                width: 100%;
                margin: 10px 0;
            }
            .forgot-password {
                text-align: right;
                margin: 10px 0;
            }
            .register-link {
                text-align: center;
                margin-top: 20px;
            }
            .form-check {
                margin: 15px 0;
            }
        </style>
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
                    <img src="assets/images/logo.png" alt="PawHouse Logo">
                    <h2>Welcome to PawHouse</h2>
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
                        <input type="email" class="form-control" name="email" placeholder="Email" required value="<%= savedEmail%>">
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password" required value="<%= savedPassword%>">
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" <%= !savedEmail.isEmpty() ? "checked" : ""%>>
                        <label class="form-check-label" for="rememberMe">Lưu mật khẩu</label>
                    </div>
                    <div class="forgot-password">
                        <a href="forgotPassword.jsp">Forgot Password?</a>
                    </div>
                    <button type="submit" class="btn btn-primary btn-login">Login</button>
                </form>

                <div class="text-center my-3">
                    <span>OR</span>
                </div>

                <div class="google-btn">
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/PawShop/home&response_type=code&client_id=258928862015-ucaiqoesja38egasp7r5ncnjmb0hhsm2.apps.googleusercontent.com&approval_prompt=force" class="btn btn-lg btn-danger">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16">
                        <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                        </svg>
                        <span class="ms-2 fs-6">Sign in with Google</span>
                    </a>
                </div>

                <div class="register-link">
                    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
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
        </script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </body>
</html>
