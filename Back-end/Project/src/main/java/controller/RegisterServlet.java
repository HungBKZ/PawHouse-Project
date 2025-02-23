package controller;

import Model.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form data
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        
        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Validate password strength
        if (!password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")) {
            request.setAttribute("error", "Password must be at least 8 characters long and include both letters and numbers!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        try {
            // Check if username or email already exists
            if (userDAO.checkUserExists(username, email)) {
                request.setAttribute("error", "Username or email already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // After all validations pass, attempt to register the user
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password); // Consider hashing the password before storing
            newUser.setEmail(email);
            newUser.setFullName(fullName);
            newUser.setPhone(phone);
            newUser.setUserStatus(true); // Assuming new users are active by default
            try {
                boolean registrationSuccess = userDAO.registerUser(newUser);
                if (registrationSuccess) {
                    response.sendRedirect("login.jsp"); // Redirect to login page after successful registration
                } else {
                    request.setAttribute("error", "Registration failed, please try again.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "An error occurred during registration.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
