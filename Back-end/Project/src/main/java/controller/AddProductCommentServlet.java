package controller;

import DAO.ProductCommentDAO;
import Model.Product;
import Model.ProductComment;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet(name = "AddProductCommentServlet", urlPatterns = {"/AddProductComment"})
public class AddProductCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get parameters
            int productId = Integer.parseInt(request.getParameter("productId"));
            int star = Integer.parseInt(request.getParameter("star"));
            String content = request.getParameter("content");
            
            // Create new comment
            ProductComment comment = new ProductComment();
            comment.setUser(user);
            
            Product product = new Product();
            product.setProductID(productId);
            comment.setProduct(product);
            
            comment.setStar(star);
            comment.setContent(content);
            comment.setDateComment(Date.valueOf(LocalDate.now()));
            comment.setProductCommentStatus(true);
            
            // Save comment
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            boolean success = commentDAO.addComment(comment);
            
            if (success) {
                session.setAttribute("message", "Đánh giá của bạn đã được gửi thành công!");
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại!");
            }
            
            // Redirect back to product detail page
            response.sendRedirect("ProductDetail?id=" + productId);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}
