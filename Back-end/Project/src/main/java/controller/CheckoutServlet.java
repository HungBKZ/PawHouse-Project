/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CartDAO;
import DAO.OrderDAO;
import DAO.OrderDetailsDAO;
import DAO.ProductDAO;
import DAO.UserDAO;
import Model.Cart;
import Model.OrderDetails;
import Model.Orders;
import Model.Product;
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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/Checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        if (type == null || type.isBlank()) {
            request.getRequestDispatcher("Cart").forward(request, response);
            return;
        }

        request.setAttribute("type", type);
        request.getRequestDispatcher("successOrderAppointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<OrderDetails> lstOrderDetails = new ArrayList<>();
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

            //Lấy danh sách id product người dùng chọn
            String[] productIDs = request.getParameter("selectedProducts").split(",");

            //Tạo và lưu đơn đặt hàng xuống DB
            Orders order = new Orders();
            order.setUser(user);

            OrderDAO orderDAO = new OrderDAO();
            if (orderDAO.addOrder(order)) {
                order = orderDAO.getLastestOrderByUser(user);
            }

            //Thêm hàng hóa cho Order
            ProductDAO productDAO = new ProductDAO();
            CartDAO cartDAO = new CartDAO();
            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
            double totalAmount = 0;
            int totalItem = 0;
            for (String productID : productIDs) {
                OrderDetails orderDetails = new OrderDetails();
                Product product = productDAO.getProductById(Integer.parseInt(productID));
                Cart cart = cartDAO.getCartByUserAndProduct(user.getUserID(), Integer.parseInt(productID));

                //Thêm bản ghi vào OrderDetail
                orderDetails.setOrder(order);
                orderDetails.setProduct(product);
                orderDetails.setPrice(product.getPrice());
                orderDetails.setQuantity(cart.getQuantity());
                orderDetailsDAO.addOrderDetail(orderDetails);
                lstOrderDetails.add(orderDetails);

                //Xóa bản ghi trong Cart
                cartDAO.removeFromCart(cart.getCartID());
                
                //Cập nhật stock cho Product
                int remainStock=product.getStock() - cart.getQuantity();
                product.setStock(remainStock);
                productDAO.updateProduct(product);

                //Tính tổng tiền cho đơn hàng
                totalAmount += orderDetails.getPrice() * orderDetails.getQuantity();
                totalItem += orderDetails.getQuantity();
            }

            //Cập nhật thông tin thanh toán cho Order
            order.setTotalAmount(totalAmount);
            orderDAO.updateOrder(order);

            //Chuyen huong qua trang thanh toan
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("totalItem", totalItem);
            request.setAttribute("user", user);
            request.setAttribute("lstOrderDetails", lstOrderDetails);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
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
