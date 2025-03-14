package controller;

import DAO.AppointmentDAO;
import Model.Appointment;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "StaffAppointmentServlet", urlPatterns = {"/StaffAppointmentServlet"})
public class StaffAppointmentServlet extends HttpServlet {

    private static final Map<String, String> STATUS_MAP = new HashMap<>();
    static {
        STATUS_MAP.put("Pending", "Chờ xác nhận");
        STATUS_MAP.put("Confirmed", "Đã xác nhận");
        STATUS_MAP.put("Completed", "Hoàn thành");
        STATUS_MAP.put("Cancelled", "Đã hủy");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập và quyền staff
        if (user == null || user.getRole() == null || !"staff".equalsIgnoreCase(user.getRole().getRoleName())) {
            session.setAttribute("error", "Bạn cần đăng nhập với quyền nhân viên để truy cập trang này!");
            session.setAttribute("redirectUrl", "StaffAppointmentServlet?action=list");
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        
        try {
            switch (action) {
                case "list":
                    List<Appointment> appointments = appointmentDAO.getAllAppointments();
                    request.setAttribute("appointments", appointments);
                    request.setAttribute("statusMap", STATUS_MAP);
                    request.getRequestDispatcher("staffManageAppointment.jsp").forward(request, response);
                    break;
                    
                case "updateStatus":
                    int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                    String newStatus = request.getParameter("status");
                    String notes = request.getParameter("notes");
                    
                    boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, newStatus, notes);
                    if (success) {
                        session.setAttribute("success", "Cập nhật trạng thái cuộc hẹn thành công!");
                    } else {
                        session.setAttribute("error", "Có lỗi xảy ra khi cập nhật trạng thái cuộc hẹn!");
                    }
                    response.sendRedirect("StaffAppointmentServlet?action=list");
                    break;
                    
                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("appointmentId"));
                    boolean deleteSuccess = appointmentDAO.deleteAppointment(deleteId);
                    if (deleteSuccess) {
                        session.setAttribute("success", "Xóa cuộc hẹn thành công!");
                    } else {
                        session.setAttribute("error", "Có lỗi xảy ra khi xóa cuộc hẹn!");
                    }
                    response.sendRedirect("StaffAppointmentServlet?action=list");
                    break;
                    
                default:
                    response.sendRedirect("StaffAppointmentServlet?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("staffManageAppointment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
