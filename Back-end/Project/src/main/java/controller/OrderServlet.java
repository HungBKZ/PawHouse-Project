/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.OrderDAO;
import Model.Orders;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(OrderServlet.class.getName());
    private OrderDAO orderDAO;

    @Override
    public void init() {
        try {
            orderDAO = new OrderDAO();
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Failed to initialize OrderDAO", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (orderDAO == null) {
                orderDAO = new OrderDAO();
            }
            List<Orders> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error getting orders", e);
            request.setAttribute("orders", new ArrayList<>());
            request.setAttribute("error", "Không thể tải danh sách đơn hàng. Vui lòng thử lại sau.");
        }
        request.getRequestDispatcher("staffManageOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String action = request.getParameter("action");
        
        try {
            if (orderDAO == null) {
                orderDAO = new OrderDAO();
            }
            
            if (action != null && action.equals("updateStatus")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                
                LOGGER.info("Updating order ID: " + orderID + " to status: " + status);
                
                boolean success = orderDAO.updateOrderStatus(orderID, status);
                if (success) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("failed");
                }
                return;
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid order ID format", e);
            response.getWriter().write("error: ID đơn hàng không hợp lệ");
            return;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating order status", e);
            response.getWriter().write("error: " + e.getMessage());
            return;
        }
        
        response.sendRedirect("staffManageOrder");
    }
}
