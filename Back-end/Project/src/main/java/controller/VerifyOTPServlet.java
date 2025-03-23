package controller;

import DAO.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/verifyOTP"})
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String enteredOTP = request.getParameter("otp");
        int otp = (int) session.getAttribute("otp");

        if (enteredOTP.equals(String.valueOf(otp))) {
            // OTP hợp lệ, đăng ký user vào database
            String username = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");
            String email = (String) session.getAttribute("email");
            String fullName = (String) session.getAttribute("fullName");
            String phone = (String) session.getAttribute("phone");
            String address = (String) session.getAttribute("address");

            User newUser = new User(username, password, email, fullName, phone,address, true);
            UserDAO userDAO = new UserDAO();
            try {
                userDAO.registerUser(newUser);
                session.removeAttribute("otp");
                session.removeAttribute("username");
                session.removeAttribute("password");
                session.removeAttribute("email");
                session.removeAttribute("fullName");
                session.removeAttribute("phone");
                 session.removeAttribute("address");
                response.sendRedirect("index.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error while registering: " + e.getMessage());
                request.getRequestDispatcher("verifyOTP.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("verifyOTP.jsp?error=Invalid OTP, please try again.");
        }
    }
}
