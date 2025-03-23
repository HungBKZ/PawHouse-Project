package controller;

import DAO.ProductCommentDAO;
import Model.ProductComment;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;

@WebServlet(name = "AdminCommentServlet", urlPatterns = {"/admin-comments"})
public class AdminCommentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            List<ProductComment> comments = commentDAO.getAllComments();
            
            if (comments.isEmpty()) {
                request.setAttribute("message", "Không có bình luận nào.");
            }
            
            request.setAttribute("comments", comments);
            request.getRequestDispatcher("adminComments.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải danh sách bình luận: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Validate required parameters
            if (action == null || action.trim().isEmpty()) {
                throw new IllegalArgumentException("Thiếu thông tin hành động");
            }
            
            String commentIdStr = request.getParameter("commentId");
            if (commentIdStr == null || commentIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Thiếu ID bình luận");
            }
            
            int commentId;
            try {
                commentId = Integer.parseInt(commentIdStr);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("ID bình luận không hợp lệ");
            }
            
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "toggle":
                    success = commentDAO.toggleCommentStatus(commentId);
                    message = success ? "Đã thay đổi trạng thái bình luận thành công" 
                                   : "Không thể thay đổi trạng thái bình luận. Vui lòng thử lại sau.";
                    break;
                    
                case "delete":
                    success = commentDAO.softDeleteComment(commentId);
                    message = success ? "Đã ẩn bình luận thành công" 
                                   : "Không thể ẩn bình luận. Vui lòng thử lại sau.";
                    break;
                    
                default:
                    throw new IllegalArgumentException("Hành động không hợp lệ");
            }
            
            jsonResponse.addProperty("success", success);
            jsonResponse.addProperty("message", message);
            
        } catch (IllegalArgumentException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Lỗi: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Đã xảy ra lỗi không mong muốn. Vui lòng thử lại sau.");
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
}
