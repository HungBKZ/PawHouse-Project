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
               
            String content = "<html><body style='font-family: Arial, sans-serif; background-color: #FFF3CD; padding: 20px;'>"
                    + "<div style='max-width: 500px; margin: auto; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); text-align: center;'>"
                    + "<h2 style='color: #FF8000;'>🐶 Xác Thực Quên Mật Khẩu PawHouse 🐱</h2>"
                    + "<p style='font-size: 16px; color: #333; margin-bottom: 10px;'>Xin chào,</p>"
                    + "<p style='font-size: 16px; color: #333;'>Mã OTP của bạn là:</p>"
                    + "<p style='font-size: 24px; font-weight: bold; color: #FF5733; background-color: #fff; padding: 15px; display: inline-block; border-radius: 8px; border: 2px dashed #FF5733; letter-spacing: 3px;'>"
                    + otp + "</p>"
                    + "<p style='font-size: 16px; color: #333; margin-top: 20px;'>Vui lòng nhập mã này để hoàn tất lấy lại tài khoản PawHouse.</p>"
                    + "<p style='font-size: 14px; color: #666;'>Lưu ý: Mã OTP có hiệu lực trong <b>5 phút</b>.</p>"
                    + "<p style='margin-top: 20px; font-size: 14px; color: #666;'>Cảm ơn bạn đã tham gia cộng đồng PawHouse! 🐾</p>"
//                    + "<a href='http://localhost:8080/home' style='display: inline-block; margin-top: 15px; padding: 10px 20px; font-size: 16px; color: white; background-color: #FF8000; text-decoration: none; border-radius: 5px;'>Xác Thực Ngay</a>"
                    + "<hr style='border: 1px solid #FF8000; margin-top: 20px;'>"
                    + "<p style='font-size: 12px; color: #999;'>Nếu bạn không yêu cầu lấy lại mật khẩu, vui lòng bỏ qua email này.</p>"
                    + "</div>"
                    + "</body></html>";
                EmailUtility.sendEmail(email, subject, content);

                // Redirect to OTP verification page
                request.getRequestDispatcher("verifyOTPForgotPassword.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không Tìm Thấy Tài Khoản Của Bạn Trong Hệ Thống.");
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
