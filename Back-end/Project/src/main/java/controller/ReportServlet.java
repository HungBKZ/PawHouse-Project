package controller;

import DAO.ReportDAO;
import Model.ReportDTO;
import Model.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hungv
 */
@WebServlet(name = "ReportServlet", urlPatterns = {"/staff/report"})
public class ReportServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thêm logic kiểm tra quyền truy cập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() == null || 
            (user.getRole().getRoleID() != 1 && user.getRole().getRoleID() != 3)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Giữ nguyên logic gốc
        try {
            // Lấy và xử lý tham số ngày
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reportType = request.getParameter("type");

            Timestamp startDate, endDate;
            if (startDateStr == null || endDateStr == null) {
                // Mặc định lấy báo cáo 7 ngày gần nhất
                Calendar cal = Calendar.getInstance();
                endDate = new Timestamp(cal.getTimeInMillis());
                cal.add(Calendar.DAY_OF_MONTH, -6);
                startDate = new Timestamp(cal.getTimeInMillis());
                reportType = "daily";
            } else {
                startDate = new Timestamp(dateFormat.parse(startDateStr).getTime());
                endDate = new Timestamp(dateFormat.parse(endDateStr).getTime());
            }

            // Lấy dữ liệu báo cáo
            ReportDTO report = reportDAO.getReport(startDate, endDate, reportType);
            report.setStartDate(startDate);
            report.setEndDate(endDate);
            report.setReportType(reportType);

            // Lưu báo cáo vào request attribute
            request.setAttribute("report", report);
            request.getRequestDispatcher("/staffReport.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating report: " + e.getMessage());
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}