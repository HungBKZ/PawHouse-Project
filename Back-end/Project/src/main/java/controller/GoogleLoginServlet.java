package controller;

import DAO.UserDAO;
import Model.GoogleAccount;
import Utils.DBContext;
import constant.Iconstant;
import controller.GoogleLogin;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserinfo(accessToken);
        System.out.println(acc);

        try {
            UserDAO userDAO = new UserDAO();
            boolean saved = userDAO.saveGoogleEmail(acc.getEmail(), acc.getName(), acc.getPicture());
            if (saved) {
                // Create cookies for user information with URL encoding
                Cookie emailCookie = new Cookie("email", java.net.URLEncoder.encode(acc.getEmail(), "UTF-8"));
                Cookie usernameCookie = new Cookie("username", java.net.URLEncoder.encode(acc.getName(), "UTF-8"));
                Cookie welcomeCookie = new Cookie("welcomeMessage", java.net.URLEncoder.encode("Welcome, " + acc.getName() + "!", "UTF-8"));

                // Set cookie expiration time (24 hours)
                emailCookie.setMaxAge(24 * 60 * 60);
                usernameCookie.setMaxAge(24 * 60 * 60);
                welcomeCookie.setMaxAge(24 * 60 * 60);

                // Set cookie path
                emailCookie.setPath("/");
                usernameCookie.setPath("/");
                welcomeCookie.setPath("/");

                // Add cookies to response
                response.addCookie(emailCookie);
                response.addCookie(usernameCookie);
                response.addCookie(welcomeCookie);

                response.sendRedirect("home");
            } else {
                response.sendRedirect("login?error=failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login?error=database"); // Redirect back to login if database error
        }
    }
}
