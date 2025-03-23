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

        // Validate password pattern
        if (!newPassword.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số!");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        try {
            // Xác thực mật khẩu hiện tại
            User verifiedUser = userDAO.checkLogin(user.getEmail(), currentPassword);
            if (verifiedUser == null) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Nếu mật khẩu hiện tại đúng, tiến hành đổi mật khẩu mới
            boolean success = userDAO.updateUserPassword(user.getUserID(), newPassword);
            
            if (success) {
                // Cập nhật lại thông tin user trong session với mật khẩu đã băm
                user.setPassword(PasswordHasher.hashMD5(newPassword));
                session.setAttribute("loggedInUser", user);
                request.setAttribute("message", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
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