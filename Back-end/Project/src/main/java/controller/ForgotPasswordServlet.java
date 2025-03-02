package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show the forgot password form
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("checkEmail".equals(action)) {
            // Step 1: Check email exists
            handleEmailCheck(request, response, userDAO);
        } else if ("resetPassword".equals(action)) {
            // Step 2: Reset password
            handlePasswordReset(request, response, userDAO);
        } else {
            request.setAttribute("error", "Invalid action");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }

    private void handleEmailCheck(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Please enter your email address.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            if (userDAO.checkEmailExists(email)) {
                // Email exists, show password reset form
                request.setAttribute("email", email);
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "No account found with this email address.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "An error occurred. Please try again later.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            e.printStackTrace();
        }
    }

    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Validate inputs
            if (email == null || email.trim().isEmpty()
                    || newPassword == null || newPassword.trim().isEmpty()
                    || confirmPassword == null || confirmPassword.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
                return;
            }

            // Check if passwords match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
                return;
            }

            // Update password in database
            if (userDAO.updatePasswordByEmail(email, newPassword)) {
                request.setAttribute("success", "Password has been reset successfully. You can now login with your new password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to reset password. Please try again.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "An error occurred. Please try again later.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}
