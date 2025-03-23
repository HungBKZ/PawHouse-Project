package controller;

import DAO.CartDAO;
import Model.User;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteProductFromCartServlet", urlPatterns = {"/DeleteFromCart"})
public class DeleteProductFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy productId từ request
            String productIdParam = request.getParameter("id");
            System.out.println("==> Nhận yêu cầu xóa sản phẩm với ID: " + productIdParam);

            if (productIdParam == null || productIdParam.isEmpty()) {
                System.out.println("❌ Lỗi: Không có productId trong request!");
                response.sendRedirect("error.jsp");
                return;
            }

            int productId = Integer.parseInt(productIdParam);

            // Xóa sản phẩm khỏi giỏ hàng
            CartDAO cartDAO = new CartDAO();
            cartDAO.removeFromCart(user.getUserID(), productId);

            System.out.println("✔ Sản phẩm đã được xóa khỏi giỏ hàng!");

            // Chuyển hướng về giỏ hàng
            response.sendRedirect("Cart");

        } catch (NumberFormatException e) {
            System.out.println("❌ Lỗi: productId không hợp lệ!");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException e) {
            System.out.println("❌ Lỗi SQL khi xóa sản phẩm khỏi giỏ hàng!");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
