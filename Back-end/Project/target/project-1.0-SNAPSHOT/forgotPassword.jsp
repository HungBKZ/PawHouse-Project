<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .forgot-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .forgot-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .forgot-header img {
                max-width: 150px;
                margin-bottom: 20px;
            }
            .form-control {
                border-radius: 20px;
                padding: 10px 15px;
            }
            .btn-submit {
                border-radius: 20px;
                padding: 10px 20px;
                width: 100%;
                background-color: #4CAF50;
                border: none;
                color: white;
                font-weight: bold;
                margin-top: 20px;
            }
            .btn-submit:hover {
                background-color: #45a049;
            }
            .back-to-login {
                text-align: center;
                margin-top: 20px;
            }
            .steps {
                margin: 20px 0;
                padding: 0;
                list-style: none;
            }
            .steps li {
                margin-bottom: 10px;
                padding-left: 25px;
                position: relative;
            }
            .steps li:before {
                content: "✓";
                position: absolute;
                left: 0;
                color: #4CAF50;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="forgot-container">
                <div class="forgot-header">
                    <img src="assets/images/logo.png" alt="PawHouse Logo">
                    <h2>Forgot Password?</h2>
                    <p class="text-muted">Don't worry! We'll help you recover your password.</p>
                </div>
                
                <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                
                <% if(request.getAttribute("success") != null) { %>
                    <div class="alert alert-success" role="alert">
                        <%= request.getAttribute("success") %>
                    </div>
                <% } %>
                
                <form action="forgotPassword" method="POST" id="forgotForm">
                    <input type="hidden" name="action" value="checkEmail">
                    <div class="mb-3">
                        <label for="email" class="form-label">Enter your email address</label>
                        <input type="email" class="form-control" id="email" name="email" required
                               placeholder="Enter your registered email">
                    </div>
                    
                    <ul class="steps">
                        <li>Enter your registered email address</li>
                        <li>Create your new password</li>
                        <li>Start using your new password</li>
                    </ul>
                    
                    <button type="submit" class="btn btn-submit">Continue</button>
                </form>
                
                <div class="back-to-login">
                    <a href="login.jsp">Back to Login</a>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
