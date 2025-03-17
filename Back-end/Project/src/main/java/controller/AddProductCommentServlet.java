package controller;

import DAO.ProductCommentDAO;
import DAO.ProductDAO;
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
import java.sql.Timestamp;
import java.time.LocalDate;

@WebServlet(name = "AddProductCommentServlet", urlPatterns = {"/AddProductComment"})
public class AddProductCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Try to get the Google logged-in user if system user is not found
            user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        }
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int star = Integer.parseInt(request.getParameter("star"));
            String content = request.getParameter("content");
            
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                ProductComment comment = new ProductComment();
                comment.setUser(user);
                comment.setProduct(product);
                comment.setStar(star);
                comment.setContent(content);
                comment.setDateComment(new Timestamp(System.currentTimeMillis()));
                comment.setProductCommentStatus(true);
                
                ProductCommentDAO commentDAO = new ProductCommentDAO();
                boolean success = commentDAO.addComment(comment);
                
                if (success) {
                    session.setAttribute("message", "Cảm ơn bạn đã đánh giá sản phẩm!");
                } else {
                    session.setAttribute("error", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Dữ liệu không hợp lệ.");
            e.printStackTrace();
        }
        
        response.sendRedirect("ProductDetail?id=" + request.getParameter("productId"));
    }
}
