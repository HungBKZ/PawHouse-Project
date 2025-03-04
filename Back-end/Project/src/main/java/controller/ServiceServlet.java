package controller;

import DAO.ServiceDAO;
import Model.Service;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServiceServlet", urlPatterns = {"/Service"})
public class ServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách dịch vụ từ database
        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> serviceList = serviceDAO.getAll();

        // Gửi danh sách dịch vụ đến trang JSP
        request.setAttribute("serviceList", serviceList);
        request.getRequestDispatcher("services.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
