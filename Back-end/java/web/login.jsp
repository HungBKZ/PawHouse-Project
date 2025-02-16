<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            .login-container {
                width: 300px;
                margin: 100px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
            }
            .form-group input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .btn-login {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .error-message {
                color: red;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <%
            // Check if user is already logged in
            User user = (User) session.getAttribute("loggedInUser");
            if(user != null) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>
        <div class="login-container">
            <h2 style="text-align: center;">Login</h2>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="login" method="POST">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn-login">Login</button>
            </form>
        </div>
    </body>
</html>
