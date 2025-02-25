package controller;

import Model.User;
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
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            String savedEmail = null;
            String savedPassword = null;

            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("savedEmail")) {
                    savedEmail = cookie.getValue();
                }
                if (cookie.getName().equals("savedPassword")) {
                    savedPassword = PasswordHasher.decodeBase64(cookie.getValue());
                }
            }

            if (savedEmail != null && savedPassword != null) {
                UserDAO userDAO = new UserDAO();
                try {
                    User user = userDAO.checkLogin(savedEmail, savedPassword);
                    if (user != null) {
                        // Create authentication cookie
                        Cookie authCookie = new Cookie("authToken", PasswordHasher.encodeBase64(savedEmail + ":" + user.getUserID()));
                        authCookie.setMaxAge(COOKIE_MAX_AGE);
                        authCookie.setPath("/");
                        response.addCookie(authCookie);

                        response.sendRedirect("index.jsp");
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
        String error = "";

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            error = "Vui lòng nhập email và mật khẩu!";
            request.setAttribute("error", error);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.checkLogin(email, password);
            if (user != null) {
                // Create authentication cookie
                Cookie authCookie = new Cookie("authToken", PasswordHasher.encodeBase64(email + ":" + user.getUserID()));
                authCookie.setMaxAge(COOKIE_MAX_AGE);
                authCookie.setPath("/");
                response.addCookie(authCookie);

                // Handle remember me
                if (rememberMe != null) {
                    Cookie emailCookie = new Cookie("savedEmail", email);
                    Cookie passwordCookie = new Cookie("savedPassword", PasswordHasher.encodeBase64(password));

                    emailCookie.setMaxAge(COOKIE_MAX_AGE);
                    passwordCookie.setMaxAge(COOKIE_MAX_AGE);

                    emailCookie.setPath("/");
                    passwordCookie.setPath("/");

                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                } else {
                    // Remove saved credentials if remember me is not checked
                    Cookie emailCookie = new Cookie("savedEmail", "");
                    Cookie passwordCookie = new Cookie("savedPassword", "");

                    emailCookie.setMaxAge(0);
                    passwordCookie.setMaxAge(0);

                    emailCookie.setPath("/");
                    passwordCookie.setPath("/");

                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }

                response.sendRedirect("index.jsp");
            } else {
                error = "Email hoặc mật khẩu không đúng!";
                request.setAttribute("error", error);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            error = "Có lỗi xảy ra: " + e.getMessage();
            request.setAttribute("error", error);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
