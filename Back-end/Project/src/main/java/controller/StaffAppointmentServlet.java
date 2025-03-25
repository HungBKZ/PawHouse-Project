package controller;

import DAO.AppointmentDAO;
import Model.Appointment;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StaffAppointmentServlet", urlPatterns = {"/StaffAppointmentServlet"})
public class StaffAppointmentServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() {
        appointmentDAO = new AppointmentDAO();
    }

    /**
     * Xử lý GET: Hiển thị danh sách lịch hẹn
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách lịch hẹn từ database
            List<Appointment> appointments = appointmentDAO.getAppointmentsSpa();

            // Đẩy danh sách lên request
            request.setAttribute("appointments", appointments);

            // Chuyển hướng đến trang quản lý lịch hẹn
            request.getRequestDispatcher("staffManageAppointment.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi tải danh sách lịch hẹn: " + e.getMessage());
            request.getRequestDispatcher("staffManageAppointment.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý POST: Cập nhật trạng thái lịch hẹn
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String idParam = request.getParameter("appointmentID");
            String statusParam = request.getParameter("appointmentStatus");

            // Kiểm tra dữ liệu đầu vào có hợp lệ không
            if (idParam == null || statusParam == null) {
                request.setAttribute("errorMessage", "Thiếu dữ liệu cần thiết!");
                doGet(request, response);
                return;
            }

            int appointmentID = Integer.parseInt(idParam);
            String status = statusParam;
            if (statusParam.equals("null")) {
                status = null;
            }

            // Cập nhật trạng thái trong database
            boolean success = appointmentDAO.updateAppointmentStatus(appointmentID, status);

            if (success) {
                response.sendRedirect("StaffAppointmentServlet?success=updated");
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
