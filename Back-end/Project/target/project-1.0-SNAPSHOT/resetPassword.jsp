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
                    <img src="assets/images/logo.png" alt="PawHouse Logo">
                    <h2>Reset Password</h2>
                    <p class="text-muted">Create your new password</p>
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
                        <label for="newPassword" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required
                               pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">
                    </div>

                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <div class="password-requirements">
                        <strong>Password Requirements:</strong>
                        <ul>
                            <li>At least 8 characters long</li>
                            <li>Must contain letters and numbers</li>
                            <li>Both passwords must match</li>
                        </ul>
                    </div>

                    <button type="submit" class="btn btn-reset">Reset Password</button>
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
                    alert('Passwords do not match!');
                }
            });
        </script>
    </body>
</html>
