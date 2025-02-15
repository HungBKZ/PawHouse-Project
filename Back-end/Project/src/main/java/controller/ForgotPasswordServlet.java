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
    
    private static final String EMAIL_FROM = "your-email@gmail.com"; // Replace with your email
    private static final String EMAIL_PASSWORD = "your-app-password"; // Replace with your app password
    
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
            if (userDAO.checkEmailExists(email)) {
                // Generate reset token
                String token = UUID.randomUUID().toString();
                
                // Save token to database
                if (userDAO.saveResetToken(email, token)) {
                    // Send reset email
                    sendResetEmail(email, token);
                    
                    request.setAttribute("success", "Password reset instructions have been sent to your email.");
                } else {
                    request.setAttribute("error", "Failed to process your request. Please try again.");
                }
            } else {
                request.setAttribute("error", "Email address not found!");
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }
    
    private void sendResetEmail(String toEmail, String token) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Reset Your PawHouse Password");
            
            String resetLink = "http://localhost:8080/PawHouse/forgotPassword?token=" + token;
            String emailContent = 
                "Dear PawHouse User,<br><br>" +
                "We received a request to reset your password. Click the link below to create a new password:<br><br>" +
                "<a href='" + resetLink + "'>" + resetLink + "</a><br><br>" +
                "If you didn't request this, you can safely ignore this email.<br><br>" +
                "Best regards,<br>" +
                "The PawHouse Team";
            
            message.setContent(emailContent, "text/html; charset=utf-8");
            Transport.send(message);
            
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
