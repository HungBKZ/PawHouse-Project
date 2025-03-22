/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AppointmentDAO;
import DAO.PetDAO;
import DAO.ServiceDAO;
import DAO.UserDAO;
import Model.Appointment;
import Model.Pet;
import Model.Service;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookServiceServlet", urlPatterns = {"/BookService"})
public class BookServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isBlank()) {
            request.getRequestDispatcher("Service").forward(request, response);
            return;
        }
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        // Nếu user chưa có trong session, kiểm tra trong cookie
        if (user == null) {
            user = getUserFromCookies(request);
            if (user != null) {
                session.setAttribute("loggedInUser", user);
            }
        }

        // Nếu vẫn chưa có user, chuyển hướng về trang đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Pet> lstPet= new PetDAO().getPetsByUserId(user.getUserID());
        for (int i = 0; i < lstPet.size(); i++) {
            Pet get = lstPet.get(i);
            if (!get.getAdoptionStatus().equalsIgnoreCase("Đã nhận nuôi")){
                lstPet.remove(i);
            }
        }
        request.setAttribute("service", new ServiceDAO().getServiceByID(Integer.parseInt(id)));
        request.setAttribute("lstPet", lstPet);
        request.getRequestDispatcher("bookService.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy appointmentTime
            String appointmentTimeStr = request.getParameter("appointmentTime");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime localDateTime = LocalDateTime.parse(appointmentTimeStr, formatter);
            Timestamp appointmentTime = Timestamp.valueOf(localDateTime);

            int petID = Integer.parseInt(request.getParameter("pet"));
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            Service service = new ServiceDAO().getServiceByID(serviceID);
            String note = request.getParameter("note");

            Appointment appointment = new Appointment();
            appointment.setCustomer(new UserDAO().getUserByUsername(((User) request.getSession().getAttribute("loggedInUser")).getUsername()));
            appointment.setBookingDate(appointmentTime);
            appointment.setAppointmentDate(new java.sql.Timestamp(new Date().getTime()));
            appointment.setPrice(service.getPrice());
            appointment.setPet(new PetDAO().getById(petID));
            appointment.setService(service);
            appointment.setNotes(note);
            appointment.setAppointmentStatus("0");

            new AppointmentDAO().addAppointment(appointment);

            request.setAttribute("type", "appointment");
            request.getRequestDispatcher("successOrderAppointment.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BookServiceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
                        Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, e);
                    }
                }
            }
        }
        return null;
    }
}
