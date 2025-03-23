package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hủy phiên (session) nếu tồn tại
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Danh sách các tên cookie cần xóa
        String[] cookieNamesToRemove = {
            "authToken",
            "savedEmail",
            "savedPassword",
            "email",
            "username",
            "welcomeMessage"
        };

        // Lấy tất cả cookie từ request
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // Nếu cookie hiện tại nằm trong danh sách cần xóa thì đặt maxAge=0
                for (String name : cookieNamesToRemove) {
                    if (name.equals(cookie.getName())) {
                        cookie.setValue("");
                        cookie.setPath("/");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                    }
                }
            }
        }

        // Chuyển hướng về trang chủ hoặc trang đăng nhập (ở đây chuyển về home)
        response.sendRedirect("home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
