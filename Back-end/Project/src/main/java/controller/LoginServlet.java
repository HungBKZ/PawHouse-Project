package controller;

import Model.User;
import Model.Role;
import DAO.UserDAO;
import Utils.PasswordHasher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final int COOKIE_MAX_AGE = 7 * 24 * 60 * 60; // 7 days in seconds

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            String savedEmail = null;
            String savedPassword = null;

            for (Cookie cookie : cookies) {
                if ("savedEmail".equals(cookie.getName())) {
                    savedEmail = cookie.getValue();
                }
                if ("savedPassword".equals(cookie.getName())) {
                    savedPassword = PasswordHasher.decodeBase64(cookie.getValue());
                }
            }

            if (savedEmail != null && savedPassword != null) {
                UserDAO userDAO = new UserDAO();
                try {
                    User user = userDAO.checkLogin(savedEmail, savedPassword);
                    if (user != null) {
                        // Kiểm tra trạng thái tài khoản
                        if (user.getUserStatus() == 0) { // Nếu userStatus = 0 (tài khoản bị khóa)
                            session.setAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên!");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                            return;
                        }
                        Role role = userDAO.checkRole(user.getUserID());
                        user.setRole(role);
                        session.setAttribute("user", user);
                        authenticateUser(response, user);
                        
                        String redirectUrl = (String) session.getAttribute("redirectUrl");
                        if (redirectUrl != null) {
                            session.removeAttribute("redirectUrl");
                            response.sendRedirect(redirectUrl);
                        } else {
                            handleUserLogin(user, response);
                        }
                        return;
                    }
                } catch (Exception e) {
                    // Continue to login page if auto-login fails
                }
            }
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        HttpSession session = request.getSession();
        String error = "";

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            error = "Vui lòng nhập email và mật khẩu!";
            session.setAttribute("error", error);
            response.sendRedirect("login");
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.checkLogin(email, password);
            if (user != null) {
                // Kiểm tra trạng thái tài khoản
                if (user.getUserStatus() == 0) { // Nếu userStatus = 0 (tài khoản bị khóa)
                    error = "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên!";
                    session.setAttribute("error", error);
                    response.sendRedirect("login");
                    return;
                }

                // Check user role
                Role role = userDAO.checkRole(user.getUserID());
                if (role == null) {
                    error = "Tài khoản của bạn chưa được cấp quyền. Vui lòng liên hệ quản trị viên!";
                    session.setAttribute("error", error);
                    response.sendRedirect("login");
                    return;
                }

                user.setRole(role);
                session.setAttribute("user", user);
                authenticateUser(response, user);

                // Handle remember me
                if (rememberMe != null) {
                    saveLoginCookies(response, email, password);
                } else {
                    clearLoginCookies(response);
                }

                // Check for redirect URL
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null) {
                    session.removeAttribute("redirectUrl");
                    response.sendRedirect(redirectUrl);
                } else {
                    handleUserLogin(user, response);
                }
            } else {
                error = "Email hoặc mật khẩu không đúng!";
                session.setAttribute("error", error);
                response.sendRedirect("login");
            }
        } catch (Exception e) {
            error = "Có lỗi xảy ra: " + e.getMessage();
            session.setAttribute("error", error);
            response.sendRedirect("login");
        }
    }

    private void authenticateUser(HttpServletResponse response, User user) {
        Cookie authCookie = new Cookie("authToken", PasswordHasher.encodeBase64(user.getEmail() + ":" + user.getUserID()));
        authCookie.setMaxAge(COOKIE_MAX_AGE);
        authCookie.setPath("/");
        response.addCookie(authCookie);
    }

    private void saveLoginCookies(HttpServletResponse response, String email, String password) {
        Cookie emailCookie = new Cookie("savedEmail", email);
        Cookie passwordCookie = new Cookie("savedPassword", PasswordHasher.encodeBase64(password));

        emailCookie.setMaxAge(COOKIE_MAX_AGE);
        passwordCookie.setMaxAge(COOKIE_MAX_AGE);

        emailCookie.setPath("/");
        passwordCookie.setPath("/");

        response.addCookie(emailCookie);
        response.addCookie(passwordCookie);
    }

    private void clearLoginCookies(HttpServletResponse response) {
        Cookie emailCookie = new Cookie("savedEmail", "");
        Cookie passwordCookie = new Cookie("savedPassword", "");

        emailCookie.setMaxAge(0);
        passwordCookie.setMaxAge(0);

        emailCookie.setPath("/");
        passwordCookie.setPath("/");

        response.addCookie(emailCookie);
        response.addCookie(passwordCookie);
    }

    private void handleUserLogin(User user, HttpServletResponse response) throws IOException {
        if (user.getRole() == null) {
            response.sendRedirect("home");
            return;
        }

        switch (user.getRole().getRoleID()) {
            case 1:
                response.sendRedirect("adminDashboard.jsp");
                break;
            case 2:
                response.sendRedirect("home");
                break;
            case 3:
                response.sendRedirect("staffDashboard");
                break;
            case 4:
                response.sendRedirect("doctorIndex.jsp");
                break;
            default:
                response.sendRedirect("home");
                break;
        }
    }
}