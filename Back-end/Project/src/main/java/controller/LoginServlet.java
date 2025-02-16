package controller;

import Model.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            // User is already logged in, redirect to home page
            response.sendRedirect("index.jsp");
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String error = "";
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
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
                // Create new session if it doesn't exist
                session = request.getSession(true);
                session.setAttribute("loggedInUser", user);
                
                // Set session timeout to 30 minutes
                session.setMaxInactiveInterval(30 * 60);
                
                response.sendRedirect("index.jsp");
            } else {
                error = "Email hoặc mật khẩu không đúng!";
                request.setAttribute("error", error);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            error = "Đã xảy ra lỗi, vui lòng thử lại sau!";
            request.setAttribute("error", error);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}
