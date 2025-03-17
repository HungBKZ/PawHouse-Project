package controller;

import DAO.CartDAO;
import DAO.UserDAO;
import DAO.ProductDAO;
import Model.Cart;
import Model.Product;
import Model.User;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        // Nếu user chưa có trong session, kiểm tra trong cookie
        if (user == null) {
            user = getUserFromCookies(request);
            if (user != null) {
                session.setAttribute("loggedInUser", user);
            }
        }

        // Nếu vẫn chưa có user, chuyển hướng về login
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy productId và số lượng từ request
            String productIdParam = request.getParameter("productId");
            String quantityParam = request.getParameter("quantity");
            
            if (productIdParam == null || productIdParam.isEmpty()) {
                response.sendRedirect("error.jsp");
                return;
            }
            
            int productId = Integer.parseInt(productIdParam);
            int quantity = 1; // mặc định là 1
            if (quantityParam != null && !quantityParam.isEmpty()) {
                quantity = Integer.parseInt(quantityParam);
            }
            
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
            CartDAO cartDAO = new CartDAO();
            Cart existingCartItem = cartDAO.getCartItem(user.getUserID(), productId);

            if (existingCartItem != null) {
                // Nếu sản phẩm đã tồn tại, cập nhật số lượng
                int newQuantity = existingCartItem.getQuantity() + quantity;
                cartDAO.updateCartQuantity(user.getUserID(), productId, newQuantity);
            } else {
                // Nếu sản phẩm chưa có, thêm mới vào giỏ hàng
                Cart cartItem = new Cart();
                cartItem.setUser(user);
                cartItem.setProduct(product);
                cartItem.setQuantity(quantity);
                cartItem.setAddedDate(new Timestamp(System.currentTimeMillis()));
                cartDAO.addToCart(cartItem);
            }

            // Chuyển hướng đến trang giỏ hàng
            response.sendRedirect("Cart");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Lấy thông tin User từ Cookie
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