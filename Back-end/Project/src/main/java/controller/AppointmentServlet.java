/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.AppointmentDAO;
import DAO.PetDAO;
import DAO.UserDAO;
import DAO.ServiceDAO;
import Model.Appointment;
import Model.Pet;
import Model.Service;
import Model.User;
import com.google.gson.Gson;
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
    private UserDAO userDAO;
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        petDAO = new PetDAO();
        userDAO = new UserDAO();
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("getPets".equals(action)) {
            handleGetPets(request, response);
            return;
        }
        
        try {
            // Lấy danh sách lịch hẹn và dữ liệu cần thiết
            List<User> customers = userDAO.getCustomersWithPets();
            List<User> doctors = userDAO.getDoctor();
            List<Service> services = serviceDAO.getMedicalServices();
            List<Appointment> appointments = appointmentDAO.getAllAppointmentsDoctor();
            
            request.setAttribute("customers", customers);
            request.setAttribute("staff", doctors);
            request.setAttribute("services", services);
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

            request.getRequestDispatcher("/doctorAppointment.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/doctorAppointment.jsp").forward(request, response);
        }
    }

    private void handleGetPets(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            System.out.println("Getting pets for customer ID: " + customerId);
            
            List<Pet> pets = petDAO.getPetsByCustomerId(customerId);
            System.out.println("Found " + pets.size() + " pets");
            
            // Convert pets list to JSON and send response
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=UTF-8");
            
            Gson gson = new Gson();
            String jsonPets = gson.toJson(pets);
            System.out.println("JSON response: " + jsonPets);
            
            response.getWriter().write(jsonPets);
        } catch (NumberFormatException e) {
            System.err.println("Invalid customer ID format: " + request.getParameter("customerId"));
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid customer ID");
        } catch (Exception e) {
            System.err.println("Error getting pets: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                handleCreateAppointment(request, response);
            } else if ("update".equals(action)) {
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
            // Get all parameters first
            String customerIdStr = request.getParameter("customerId");
            String petIdStr = request.getParameter("petId");
            String doctorIdStr = request.getParameter("doctorId");
            String serviceIdStr = request.getParameter("serviceId");
            String appointmentDate = request.getParameter("appointmentDate");
            String note = request.getParameter("note");

            // Validate all required fields
            if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn khách hàng");
            }
            if (petIdStr == null || petIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn thú cưng");
            }
            if (doctorIdStr == null || doctorIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn bác sĩ");
            }
            if (serviceIdStr == null || serviceIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn dịch vụ");
            }
            if (appointmentDate == null || appointmentDate.trim().isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn ngày hẹn");
            }

            // Parse IDs after validation
            int customerId = Integer.parseInt(customerIdStr);
            int petId = Integer.parseInt(petIdStr);
            int doctorId = Integer.parseInt(doctorIdStr);
            int serviceId = Integer.parseInt(serviceIdStr);

            // Create appointment object
            Appointment appointment = new Appointment();
            
            // Set customer
            User customer = new User();
            customer.setUserID(customerId);
            appointment.setCustomer(customer);
            
            // Set pet
            Pet pet = new Pet();
            pet.setPetID(petId);
            appointment.setPet(pet);
            
            // Set doctor
            User doctor = new User();
            doctor.setUserID(doctorId);
            appointment.setStaff(doctor);
            
            // Set service
            Service service = new Service();
            service.setServiceID(serviceId);
            appointment.setService(service);
            
            // Set other fields
            appointment.setAppointmentDate(Timestamp.valueOf(appointmentDate.replace("T", " ") + ":00"));
            appointment.setNotes(note);
            appointment.setAppointmentStatus("Chờ duyệt");
            appointment.setBookingDate(new Timestamp(System.currentTimeMillis()));

            // Lưu vào database
            appointmentDAO.addAppointment(appointment);

            // Chuyển hướng với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/AppointmentServlet?success=created");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi tạo lịch hẹn: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String idParam = request.getParameter("appointmentID");
            String statusParam = request.getParameter("appointmentStatus");
            String staffParam = request.getParameter("userID");

            // Kiểm tra dữ liệu đầu vào có hợp lệ không
            if (idParam == null || statusParam == null) {
                request.setAttribute("errorMessage", "Thiếu dữ liệu cần thiết!");
                doGet(request, response);
                return;
            }

            int appointmentID = Integer.parseInt(idParam);
            
            Integer userID= Integer.parseInt(staffParam);
            
            String status = statusParam;
            if (statusParam.equals("null")) {
                status = null;
            }
            

            // Cập nhật trạng thái trong database
            boolean success = appointmentDAO.updateAppointmentStatus2(appointmentID, status, userID);

            if (success) {
                response.sendRedirect("AppointmentServlet?success=updated");
            } else {
                request.setAttribute("errorMessage", "Cập nhật trạng thái thất bại.");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ!");
            doGet(request, response);
        }
    }
}
