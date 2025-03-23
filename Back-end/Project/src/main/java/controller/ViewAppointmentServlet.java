package controller;

import DAO.AppointmentDAO;
import DAO.UserDAO;
import Model.Appointment;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ViewAppointmentServlet", urlPatterns = {"/ViewAppointment"})
public class ViewAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            if (user == null) {
                user = getUserFromCookies(request);
                if (user != null) {
                    session.setAttribute("loggedInUser", user);
                }
            }

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            AppointmentDAO dao = new AppointmentDAO();
            List<Appointment> appointmentList = dao.getAppointmentsByCustomerId(user.getUserID());

            request.setAttribute("appointmentList", appointmentList);
            request.getRequestDispatcher("viewAppointment.jsp").forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(ViewAppointmentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private User getUserFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("authToken".equals(cookie.getName())) {
                    try {
                        String decodedValue = new String(java.util.Base64.getDecoder().decode(cookie.getValue()));
                        if (decodedValue.contains(":")) {
                            String email = decodedValue.split(":")[0];
                            UserDAO userDAO = new UserDAO();
                            return userDAO.getUserByEmail(email);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return null;
    }
}
