<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.UserDAO" %>
<%@ page import="Utils.PasswordHasher" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession();
    User user = (User) sessionObj.getAttribute("loggedInUser");

    if (user == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("authToken".equals(cookie.getName())) {
                    String decodedValue = PasswordHasher.decodeBase64(cookie.getValue());
                    if (decodedValue != null && decodedValue.contains(":")) {
                        String email = decodedValue.split(":")[0];
                        UserDAO userDAO = new UserDAO();
                        user = userDAO.getUserByEmail(email);
                        sessionObj.setAttribute("loggedInUser", user);
                    }
                }
            }
        }
    }

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
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
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
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 500px;
                width: 100%;
                text-align: center;
            }
            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #ff6f61;
                margin-bottom: 20px;
            }
            .profile-info {
                font-size: 1.1rem;
                margin-bottom: 15px;
            }
            .profile-info i {
                color: #ff6f61;
                margin-right: 10px;
            }
            .btn-custom {
                background: #ff6f61;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                transition: 0.3s;
            }
            .btn-custom:hover {
                background: #e65c50;
                transform: scale(1.05);
            }
            .btn-edit {
                background: #007bff;
            }
            .btn-edit:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="profile-container">
            <h2 class="text-primary">Hồ Sơ Cá Nhân</h2>
            <img src="<%= user.getAvatar()%>" class="profile-avatar" alt="Avatar">
            <h4><%= user.getFullName()%></h4>
            <p class="text-muted">Vai trò: <strong><%= user.getRole().getRoleName()%></strong></p>

            <div class="profile-info"><i class="fas fa-envelope"></i> Email: <%= user.getEmail()%></div>
            <div class="profile-info"><i class="fas fa-phone"></i> Số điện thoại: <%= user.getPhone()%></div>
            <div class="profile-info"><i class="fas fa-user-check"></i> Trạng thái: <strong><%= user.isUserStatus() ? "Hoạt động" : "Bị khóa"%></strong></div>

            <div class="d-flex justify-content-between mt-4">
                <a href="editProfile.jsp" class="btn btn-custom btn-edit w-50 me-2"><i class="fas fa-edit"></i> Chỉnh Sửa</a>
                <a href="logout.jsp" class="btn btn-custom w-50"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a>
            </div>
        </div>
    </body>
</html>
