package controller;

import Model.User;
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

        // Lấy dữ liệu từ form đăng ký
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Kiểm tra mật khẩu có khớp không
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật Khẩu Không Trùng Khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra độ mạnh của mật khẩu
        if (!password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")) {
            request.setAttribute("error", "Mật khẩu phải dài ít nhất 8 ký tự và bao gồm cả chữ cái và số!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        try {
            // Kiểm tra xem username hoặc email đã tồn tại chưa
            if (userDAO.checkUserExists(username, email)) {
                request.setAttribute("error", "Tên tài khoản hoặc Email đã tồn tại!!!!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xem số điện thoại đã tồn tại chưa
            if (userDAO.checkPhoneExists(phone)) {
                request.setAttribute("error", "Số điện thoại này đã được đăng ký!!!!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Tạo mã OTP (6 chữ số)
            Random random = new Random();
            int otp = 100000 + random.nextInt(900000);

            // Lưu OTP và thông tin user vào session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("username", username);
            session.setAttribute("password", password); // Cân nhắc mã hóa mật khẩu trước khi lưu
            session.setAttribute("email", email);
            session.setAttribute("fullName", fullName);
            session.setAttribute("phone", phone);
            session.setAttribute("address", address);

            // Gửi email chứa OTP
            String subject = "🐾 Xác Thực Đăng Ký - PawHouse 🐾";

            String content = "<html><body style='font-family: Arial, sans-serif; background-color: #FFF3CD; padding: 20px;'>"
                    + "<div style='max-width: 500px; margin: auto; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); text-align: center;'>"
                    + "<h2 style='color: #FF8000;'>🐶 Xác Thực Đăng Ký PawHouse 🐱</h2>"
                    + "<p style='font-size: 16px; color: #333; margin-bottom: 10px;'>Xin chào,</p>"
                    + "<p style='font-size: 16px; color: #333;'>Mã OTP của bạn là:</p>"
                    + "<p style='font-size: 24px; font-weight: bold; color: #FF5733; background-color: #fff; padding: 15px; display: inline-block; border-radius: 8px; border: 2px dashed #FF5733; letter-spacing: 3px;'>"
                    + otp + "</p>"
                    + "<p style='font-size: 16px; color: #333; margin-top: 20px;'>Vui lòng nhập mã này để hoàn tất đăng ký tài khoản PawHouse.</p>"
                    + "<p style='font-size: 14px; color: #666;'>Lưu ý: Mã OTP có hiệu lực trong <b>5 phút</b>.</p>"
                    + "<p style='margin-top: 20px; font-size: 14px; color: #666;'>Cảm ơn bạn đã tham gia cộng đồng PawHouse! 🐾</p>"
//                    + "<a href='http://localhost:8080/home' style='display: inline-block; margin-top: 15px; padding: 10px 20px; font-size: 16px; color: white; background-color: #FF8000; text-decoration: none; border-radius: 5px;'>Xác Thực Ngay</a>"
                    + "<hr style='border: 1px solid #FF8000; margin-top: 20px;'>"
                    + "<p style='font-size: 12px; color: #999;'>Nếu bạn không yêu cầu đăng ký, vui lòng bỏ qua email này.</p>"
                    + "</div>"
                    + "</body></html>";

            EmailUtility.sendEmail(email, subject, content);

            // Chuyển hướng đến trang nhập OTP
            response.sendRedirect("verifyOTP.jsp");

        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
