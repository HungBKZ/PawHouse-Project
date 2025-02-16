package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.UUID;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {
    
    private static final String EMAIL_FROM = "pawhouse.system@gmail.com"; // Replace with your actual email
    private static final String EMAIL_PASSWORD = "your-app-password"; // Replace with your actual app password
    private static final String BASE_URL = "http://localhost:8080/Project"; // Update with your actual base URL
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token != null) {
            // Show reset password form
            request.setAttribute("token", token);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();
        
        try {
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Please enter your email address.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            if (userDAO.checkEmailExists(email)) {
                // Generate reset token
                String token = UUID.randomUUID().toString();
                
                // Save token to database with expiration (2 hours from now)
                if (userDAO.saveResetToken(email, token)) {
                    try {
                        // Send reset email
                        sendResetEmail(email, token);
                        request.setAttribute("success", "Password reset instructions have been sent to your email. Please check your inbox and spam folder.");
                    } catch (MessagingException e) {
                        request.setAttribute("error", "Failed to send email. Please try again later.");
                        e.printStackTrace();
                    }
                } else {
                    request.setAttribute("error", "Failed to process your request. Please try again.");
                }
            } else {
                request.setAttribute("error", "No account found with this email address.");
            }
        } catch (SQLException e) {
            request.setAttribute("error", "An error occurred. Please try again later.");
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }
    
    private void sendResetEmail(String toEmail, String token) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
            }
        });
        
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EMAIL_FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("PawHouse - Reset Your Password");
        
        String resetLink = BASE_URL + "/forgotPassword?token=" + token;
        String emailContent = 
            "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
            "<h2 style='color: #4A90E2;'>PawHouse Password Reset</h2>" +
            "<p>Hello,</p>" +
            "<p>We received a request to reset your password for your PawHouse account. " +
            "To proceed with the password reset, click the button below:</p>" +
            "<div style='text-align: center; margin: 30px 0;'>" +
            "<a href='" + resetLink + "' style='background-color: #4A90E2; color: white; " +
            "padding: 12px 24px; text-decoration: none; border-radius: 4px;'>" +
            "Reset Password</a></div>" +
            "<p>This link will expire in 2 hours for security reasons.</p>" +
            "<p>If you didn't request this password reset, you can safely ignore this email. " +
            "Your password will remain unchanged.</p>" +
            "<p>Best regards,<br>The PawHouse Team</p>" +
            "<hr style='margin: 20px 0;'>" +
            "<p style='font-size: 12px; color: #666;'>If the button doesn't work, copy and paste " +
            "this link into your browser:<br>" + resetLink + "</p>" +
            "</div>";
        
        message.setContent(emailContent, "text/html; charset=utf-8");
        Transport.send(message);
    }
}
