<%@page import="Model.Role"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.User" %>
<%@ page import="DAO.UserDAO" %>
<%@ page import="Utils.PasswordHasher" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession();
    User user = (User) sessionObj.getAttribute("loggedInUser");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    boolean isGoogleUser = false;

    if (user == null) {
        // Try to get Google user
        user = (User) sessionObj.getAttribute("loggedInUser");
        if (user != null) {
            isGoogleUser = true;
        } else {
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
    }

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String roleName = "";
    if (user.getRole() != null) {
        Role userRole = user.getRole();
        int roleId = userRole.getRoleID();
        roleName = userRole.getRoleName(); // First try to get the role name directly
        
        // Fallback to switch case if roleName is null or empty
        if (roleName == null || roleName.trim().isEmpty()) {
            switch (roleId) {
                case 1:
                    roleName = "Admin";
                    break;
                case 2:
                    roleName = "Người dùng";
                    break;
                case 3:
                    roleName = "Nhân viên";
                    break;
                case 4:
                    roleName = "Bác sĩ";
                    break;
                default:
                    roleName = "Không xác định (ID: " + roleId + ")";
            }
        }
    } else {
        roleName = "Không xác định";
    }
    
    // Add debug information
    System.out.println("Debug - User Role Info:");
    System.out.println("User ID: " + user.getUserID());
    if (user.getRole() != null) {
        System.out.println("Role ID: " + user.getRole().getRoleID());
        System.out.println("Role Name: " + user.getRole().getRoleName());
    } else {
        System.out.println("Role is null");
    }
%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Hồ Sơ Cá Nhân - PawHouse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background: linear-gradient(135deg, #f8b500, #ff6f61);
                min-height: 100vh;
                padding: 20px;
            }
            .profile-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 800px;
                width: 100%;
                margin: 20px auto;
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
            .form-section {
                border-top: 1px solid #dee2e6;
                padding-top: 20px;
                margin-top: 20px;
            }
            .alert {
                margin-bottom: 20px;
            }
            .google-badge {
                background-color: #4285f4;
                color: white;
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <div class="profile-container">
            <div class="text-center mb-4">
                <h2 class="text-primary">Hồ Sơ Cá Nhân</h2>
                <img src="<%= user.getAvatar() != null ? user.getAvatar() : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"%>" 
                     class="profile-avatar" alt="Avatar">
                <h4><%= user.getFullName()%>
                    <% if (isGoogleUser) { %>
                    <span class="google-badge"><i class="fab fa-google"></i> Google</span>
                    <% }%>
                </h4>
               <p class="text-muted">Vai trò: <strong><%= roleName %></strong></p>
            </div>

            <% if (message != null) {%>
            <div class="alert alert-success" role="alert">
                <%= message%>
            </div>
            <% } %>
            <% if (error != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= error%>
            </div>
            <% }%>

            <!-- Thông tin cá nhân -->
            <form action="UpdateProfileServlet" method="POST" enctype="multipart/form-data" class="form-section">
                <h4 class="mb-3">Thông tin cá nhân</h4>

                <!-- Upload Avatar -->
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-image"></i> Thay đổi Avatar</label>
                    <input type="file" name="avatar" class="form-control" accept="image/*" id="avatarInput">
                </div>

                <!-- Thông tin cá nhân -->
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user"></i> Họ và tên</label>
                    <input type="text" name="fullName" class="form-control" value="<%= user.getFullName()%>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-phone"></i> Số điện thoại</label>
                    <input type="tel" name="phone" class="form-control" 
                           value="<%= user.getPhone()%>" 
                           pattern="[0-9]{10}" 
                           maxlength="10" 
                           oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);" 
                           required>
                    <small class="text-muted">Vui lòng nhập đúng 10 chữ số.</small>
                </div>
                <button type="submit" class="btn btn-custom btn-edit w-100">Cập nhật thông tin</button>
            </form>

            <!-- Đổi mật khẩu - Chỉ hiển thị cho người dùng hệ thống -->
            <% if (!isGoogleUser && user.getPassword() != null && !user.getPassword().isEmpty()) { %>
            <form action="ChangePasswordServlet" method="POST" class="form-section" id="changePasswordForm">
                <h4 class="mb-3">Đổi mật khẩu</h4>
                   <div class="mb-3">Đối với tài khoản google, mật khẩu mặc định là "123456"</div>
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-lock"></i> Mật khẩu hiện tại</label>
                    <input type="password" name="currentPassword" class="form-control" required>
                    <small class="text-muted">Nhập mật khẩu hiện tại để xác nhận</small>
                </div>
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-key"></i> Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control" required 
                           minlength="6" maxlength="20"
                           pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$">
                    <small class="text-muted">Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số.</small>
                </div>
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-check"></i> Xác nhận mật khẩu mới</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-custom btn-edit w-100">Đổi mật khẩu</button>
            </form>
            <% }%>

            <div class="text-center mt-4">
                <%
                    String homeLink = "index.jsp"; 
                    if (user.getRole() != null) {
                        switch (user.getRole().getRoleID()) {
                            case 1: 
                                homeLink = "adminDashboard.jsp";
                                break;
                            case 3: 
                                homeLink = "staffDashboard";
                                break;
                            case 4: 
                                homeLink = "doctorIndex.jsp";
                                break;
                        }
                    }
                %>
                <a href="<%= homeLink %>" class="btn btn-secondary me-2"><i class="fas fa-home"></i> Trang chủ</a>
                <a href="logout" class="btn btn-custom"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Validate password match
            document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
                var newPassword = document.querySelector('input[name="newPassword"]');
                var confirmPassword = document.querySelector('input[name="confirmPassword"]');
                
                if (newPassword.value !== confirmPassword.value) {
                    e.preventDefault();
                    alert('Mật khẩu mới và xác nhận mật khẩu không khớp!');
                }
                
                // Validate password pattern
                var passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
                if (!passwordPattern.test(newPassword.value)) {
                    e.preventDefault();
                    alert('Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số!');
                }
            });
        </script>
    </body>
</html>