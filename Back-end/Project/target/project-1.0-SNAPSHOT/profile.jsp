<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="Model.User" %>

<%
    HttpSession sessionObj = request.getSession();
    User user = (User) sessionObj.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hồ Sơ Cá Nhân - PawHouse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f8b500, #ff6f61);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .profile-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto 20px;
        }
        .btn-logout {
            background: #ff6f61;
            border: none;
        }
        .btn-logout:hover {
            background: #e65c50;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2 class="text-center text-primary">Hồ Sơ Cá Nhân</h2>
        <img src="<%= user.getAvatar() %>" class="profile-avatar" alt="Avatar">
        <h4 class="text-center"><%= user.getFullName() %></h4>
        <p class="text-center text-muted">Vai trò: <%= user.getRole().getRoleName() %></p>
        <div class="mt-4">
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Số điện thoại:</strong> <%= user.getPhone() %></p>
            <p><strong>Trạng thái:</strong> <%= user.isStatus() ? "Hoạt động" : "Bị khóa" %></p>
        </div>
        <a href="logout.jsp" class="btn btn-logout w-100 text-white">Đăng Xuất</a>
    </div>
</body>
</html>
