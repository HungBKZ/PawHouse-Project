<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
        <style>
            .welcome-container {
                width: 600px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                text-align: center;
            }
            .user-info {
                margin: 20px 0;
                text-align: left;
            }
            .user-info p {
                margin: 10px 0;
            }
            .logout-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #dc3545;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }
            .avatar {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 20px;
            }
            .welcome-header {
                font-size: 24px;
                color: #4CAF50;
                margin-bottom: 10px;
            }
            .user-email {
                font-size: 18px;
                color: #666;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%
            // Check if user is logged in
            User user = (User)session.getAttribute("user");
            if(user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="welcome-container">
            <div class="welcome-header">Welcome!</div>
            <div class="user-email"><%= user.getEmail() %></div>
            
            <div class="user-info">
                <% if(user.getAvatar() != null && !user.getAvatar().isEmpty()) { %>
                    <img src="<%= user.getAvatar() %>" alt="Avatar" class="avatar">
                <% } %>
                <p><strong>Full Name:</strong> <%= user.getFullName() %></p>
                <p><strong>Username:</strong> <%= user.getUsername() %></p>
                <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                <p><strong>Role ID:</strong> <%= user.getRoleID() %></p>
            </div>
            
            <a href="logout" class="logout-btn">Logout</a>
        </div>
    </body>
</html>
