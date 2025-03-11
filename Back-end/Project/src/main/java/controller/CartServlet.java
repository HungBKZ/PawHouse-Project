package controller;

import DAO.ProductDAO;
import Model.CartItem;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        String referer = request.getHeader("Referer"); // Get the page that sent the request
        
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "add";
        }
        
        String productIdStr = request.getParameter("productId");
        String message = null;
        
        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                switch (action) {
                    case "add":
                        String quantityStr = request.getParameter("quantity");
                        int quantity = Integer.parseInt(quantityStr);
                        
                        if (quantity <= 0) {
                            message = "Số lượng phải lớn hơn 0";
                        } else if (quantity > product.getStock()) {
                            message = "Số lượng vượt quá hàng tồn kho";
                        } else {
                            boolean found = false;
                            for (CartItem item : cart) {
                                if (item.getProduct().getProductID() == productId) {
                                    int newQuantity = item.getQuantity() + quantity;
                                    if (newQuantity <= product.getStock()) {
                                        item.setQuantity(newQuantity);
                                        message = "Đã cập nhật số lượng trong giỏ hàng";
                                    } else {
                                        message = "Tổng số lượng vượt quá hàng tồn kho";
                                    }
                                    found = true;
                                    break;
                                }
                            }
                            
                            if (!found) {
                                cart.add(new CartItem(product, quantity));
                                message = "Đã thêm sản phẩm vào giỏ hàng";
                            }
                        }
                        break;
                        
                    case "update":
                        String changeStr = request.getParameter("change");
                        int change = Integer.parseInt(changeStr);
                        
                        for (CartItem item : cart) {
                            if (item.getProduct().getProductID() == productId) {
                                int newQuantity = item.getQuantity() + change;
                                if (newQuantity > 0 && newQuantity <= product.getStock()) {
                                    item.setQuantity(newQuantity);
                                    message = "Đã cập nhật số lượng";
                                } else {
                                    message = "Số lượng không hợp lệ";
                                }
                                break;
                            }
                        }
                        break;
                        
                    case "remove":
                        Iterator<CartItem> iterator = cart.iterator();
                        while (iterator.hasNext()) {
                            CartItem item = iterator.next();
                            if (item.getProduct().getProductID() == productId) {
                                iterator.remove();
                                message = "Đã xóa sản phẩm khỏi giỏ hàng";
                                break;
                            }
                        }
                        break;
                }
                
                session.setAttribute("cart", cart);
            } else {
                message = "Không tìm thấy sản phẩm";
            }
        } catch (NumberFormatException e) {
            message = "Dữ liệu không hợp lệ";
        }
        
        if (message != null) {
            session.setAttribute("cartMessage", message);
        }
        
        // Redirect back to the referring page or cart page
        if (referer != null && referer.contains("ProductDetail.jsp")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("cart.jsp");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cart.jsp");
    }
}
