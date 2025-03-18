/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AppointmentDAO;
import DAO.PetDAO;
import Model.Appointment;
import Model.Pet;
import Model.Service;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author hungv
 */
@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AppointmentDAO appointmentDAO;
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        petDAO = new PetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách lịch hẹn từ database
            List<Appointment> appointments = appointmentDAO.getAllAppointments();
            request.setAttribute("appointments", appointments);

            // Kiểm tra thông báo thành công
            String successParam = request.getParameter("success");
            if (successParam != null) {
                switch (successParam) {
                    case "created":
                        request.setAttribute("successMessage", "Tạo lịch hẹn mới thành công!");
                        break;
                    case "updated":
                        request.setAttribute("successMessage", "Cập nhật trạng thái thành công!");
                        break;
                }
            }

            // Chuyển hướng đến trang doctorAppointment.jsp để hiển thị
            request.getRequestDispatcher("/doctorAppointment.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách lịch hẹn: " + e.getMessage());
            request.getRequestDispatcher("/doctorAppointment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                handleCreateAppointment(request, response);
            } else if ("updateStatus".equals(action)) {
                handleUpdateStatus(request, response);
            } else {
                throw new ServletException("Invalid action parameter");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void handleCreateAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy và kiểm tra các tham số bắt buộc
            String petId = request.getParameter("petId");
            String appointmentDate = request.getParameter("appointmentDate");
            String serviceId = request.getParameter("serviceId");
            String customerId = request.getParameter("customerId");
            String doctorId = request.getParameter("doctorId");
            String notes = request.getParameter("notes");
            String price = request.getParameter("price");

            // Kiểm tra dữ liệu đầu vào
            if (petId == null || petId.isEmpty() || serviceId == null || serviceId.isEmpty() ||
                customerId == null || customerId.isEmpty() || doctorId == null || doctorId.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng điền đầy đủ thông tin bắt buộc");
            }

            // Chuyển đổi ID sang Integer
            int petIdInt = Integer.parseInt(petId);
            int serviceIdInt = Integer.parseInt(serviceId);
            int customerIdInt = Integer.parseInt(customerId);
            int doctorIdInt = Integer.parseInt(doctorId);

            // Lấy thông tin Pet
            Pet pet = petDAO.getById(petIdInt);
            if (pet == null) {
                throw new IllegalArgumentException("Không tìm thấy thú cưng với ID: " + petId);
            }

            // Tạo đối tượng Appointment
            Appointment appointment = new Appointment();
            appointment.setPet(pet);
            appointment.setService(new Service(serviceIdInt));
            appointment.setCustomer(new User(customerIdInt));
            appointment.setDoctor(new User(doctorIdInt));
            appointment.setAppointmentDate(Timestamp.valueOf(appointmentDate.replace("T", " ") + ":00"));
            appointment.setBookingDate(new Timestamp(System.currentTimeMillis()));
            appointment.setAppointmentStatus("Chờ duyệt");
            appointment.setNotes(notes);
            appointment.setPrice(Double.parseDouble(price));

            // Lưu lịch hẹn vào database
            appointmentDAO.addAppointment(appointment);

            // Chuyển hướng với thông báo thành công
            response.sendRedirect("AppointmentServlet?success=created");

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String appointmentId = request.getParameter("appointmentID");
            String newStatus = request.getParameter("newStatus");

            if (appointmentId == null || newStatus == null) {
                throw new IllegalArgumentException("Thiếu thông tin cập nhật trạng thái");
            }

            boolean success = appointmentDAO.updateAppointmentStatus(
                Integer.parseInt(appointmentId), newStatus
            );

            if (success) {
                response.sendRedirect("AppointmentServlet?success=updated");
            } else {
                throw new Exception("Không thể cập nhật trạng thái");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi cập nhật trạng thái: " + e.getMessage());
            doGet(request, response);
        }
    }
}
