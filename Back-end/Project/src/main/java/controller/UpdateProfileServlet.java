package controller;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        try {
            UserDAO userDAO = new UserDAO();
            
            // Update user object with new information
            user.setFullName(fullName);
            user.setPhone(phone);

            // Update in database
            boolean success = userDAO.updateUserProfile(user);
            
            if (success) {
                // Update session with new user info
                session.setAttribute("loggedInUser", user);
                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
