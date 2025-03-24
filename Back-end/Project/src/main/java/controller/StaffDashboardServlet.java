package controller;

import DAO.AdoptionDAO;
import DAO.AppointmentDAO;
import DAO.OrderDAO;
import DAO.PetDAO;
import DAO.ProductDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StaffDashboardServlet", urlPatterns = {"/staffDashboard"})
public class StaffDashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StaffDashboardServlet.class.getName());

    private PetDAO petDAO;
    private AdoptionDAO adoptionDAO;
    private AppointmentDAO appointmentDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        try {
            petDAO = new PetDAO();
            adoptionDAO = new AdoptionDAO();
            appointmentDAO = new AppointmentDAO();
            productDAO = new ProductDAO();
            orderDAO = new OrderDAO();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing DAOs", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy số lượng thú cưng
            int totalPets = petDAO.getAll().size();

            // Lấy số lượng yêu cầu nhận nuôi đang chờ duyệt
            int pendingAdoptions = adoptionDAO.getPendingAdoptions().size();
            System.out.println("Debug - Number of pending adoptions: " + pendingAdoptions);

            // Lấy số lượng cuộc hẹn trong hôm nay
            int todayAppointments = appointmentDAO.getAllAppointments().size(); // Cần sửa logic để lấy đúng hôm nay

            // Lấy số lượng sản phẩm
            int totalProducts = productDAO.getAll().size();

            // Lấy doanh thu theo tháng
            List<Double> revenueData = orderDAO.getMonthlyRevenue(); // Cần thêm phương thức getMonthlyRevenue()

            // Truyền dữ liệu sang JSP
            request.setAttribute("totalPets", totalPets);
            request.setAttribute("pendingAdoptions", pendingAdoptions);
            request.setAttribute("todayAppointments", todayAppointments);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("revenueData", revenueData);

            request.getRequestDispatcher("staffIndex.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving dashboard data", e);
        }
    }
    
}
