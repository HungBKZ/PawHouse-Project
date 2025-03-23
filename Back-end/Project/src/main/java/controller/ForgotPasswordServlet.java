package controller;

import DAO.UserDAO;
import Utils.EmailUtility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("checkEmail".equals(action)) {
            handleEmailCheck(request, response, userDAO);
        } else if ("verifyOTP".equals(action)) {
            handleOTPVerification(request, response, userDAO);
        } else if ("resetPassword".equals(action)) {
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
                // Generate OTP
                Random random = new Random();
                int otp = random.nextInt(900000) + 100000; // 6-digit OTP

                // Store OTP and email in session
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);

                // Send OTP via email
                String subject = "Password Reset OTP - PawHouse";
                String content = String.format(
                    "<h2>Password Reset OTP</h2>" +
                    "<p>Your OTP for password reset is: <strong>%d</strong></p>" +
                    "<p>This OTP will expire in 10 minutes.</p>" +
                    "<p>If you did not request this password reset, please ignore this email.</p>",
                    otp
                );
                EmailUtility.sendEmail(email, subject, content);

                // Redirect to OTP verification page
                request.getRequestDispatcher("verifyOTPForgotPassword.jsp").forward(request, response);
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

    private void handleOTPVerification(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String enteredOTP = request.getParameter("otp");
        int storedOTP = (int) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");

        if (enteredOTP.equals(String.valueOf(storedOTP))) {
            // OTP verified, show password reset form
            request.setAttribute("email", email);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("verifyOTPForgotPassword.jsp").forward(request, response);
        }
    }

    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
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
                // Clear session attributes
                session.removeAttribute("otp");
                session.removeAttribute("email");
                
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
