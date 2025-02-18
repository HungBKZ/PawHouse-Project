package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Remove authentication cookie
        Cookie authCookie = new Cookie("authToken", "");
        authCookie.setMaxAge(0);
        authCookie.setPath("/");
        response.addCookie(authCookie);
        
        // Optionally remove saved credentials if user explicitly logs out
        Cookie emailCookie = new Cookie("savedEmail", "");
        Cookie passwordCookie = new Cookie("savedPassword", "");
        
        emailCookie.setMaxAge(0);
        passwordCookie.setMaxAge(0);
        
        emailCookie.setPath("/");
        passwordCookie.setPath("/");
        
        response.addCookie(emailCookie);
        response.addCookie(passwordCookie);
        
        // Redirect to login page with a success message
        request.setAttribute("success", "Bạn đã đăng xuất thành công!");
       
                response.sendRedirect("index.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
