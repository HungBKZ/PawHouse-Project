package controller;

import Model.User;
import DAO.UserDAO;
import Utils.PasswordHasher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
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

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Check if new password matches confirm password
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Verify current password
        UserDAO userDAO = new UserDAO();
        String hashedCurrentPassword = PasswordHasher.hashMD5(currentPassword);
        
        if (!user.getPassword().equals(hashedCurrentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Hash new password and update
        String hashedNewPassword = PasswordHasher.hashMD5(newPassword);
        user.setPassword(hashedNewPassword);
        
        boolean success = false;
        try {
            success = userDAO.updateUserPassword(user.getUserID(), hashedNewPassword);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        if (success) {
            request.setAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại!");
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("profile.jsp");
    }
}
