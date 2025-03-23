package controller;

import DAO.OrderDAO;
import DAO.UserDAO;
import java.sql.SQLException;
import Model.Orders;
import Model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ViewOrderServlet", urlPatterns = {"/ViewOrder"})
public class ViewOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");

            // Nếu user chưa có trong session, lấy từ cookie
            if (user == null) {
                user = getUserFromCookies(request);
                if (user != null) {
                    session.setAttribute("loggedInUser", user);
                }
            }

            // Nếu user vẫn chưa có, yêu cầu đăng nhập
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy danh sách đơn nhận nuôi của user
            OrderDAO orderDAO = new OrderDAO();
            List<Orders> orderList = orderDAO.getFullOrderInfoByUserId(user.getUserID());

            // Đưa danh sách vào request và chuyển hướng đến vieworder.jsp
            request.setAttribute("orderList", orderList);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Lấy thông tin User từ Cookie nếu chưa có trong session
     */
    private User getUserFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("authToken".equals(cookie.getName())) {
                    try {
                        String decodedValue = decodeAuthToken(cookie.getValue());
                        if (decodedValue != null && decodedValue.contains(":")) {
                            String email = decodedValue.split(":")[0];
                            UserDAO userDAO = new UserDAO();
                            return userDAO.getUserByEmail(email);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return null;
    }

    /**
     * Giải mã authToken từ Base64
     */
    private String decodeAuthToken(String token) {
        return new String(java.util.Base64.getDecoder().decode(token));
    }
}
