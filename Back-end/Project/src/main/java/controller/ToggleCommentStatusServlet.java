package controller;

import DAO.ProductCommentDAO;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ToggleCommentStatusServlet", urlPatterns = {"/ToggleCommentStatus"})
public class ToggleCommentStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Lấy commentId từ request
            String commentIdStr = request.getParameter("commentId");
            if (commentIdStr == null || commentIdStr.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "ID bình luận không hợp lệ");
                response.getWriter().write(jsonResponse.toString());
                return;
            }
            
            int commentId = Integer.parseInt(commentIdStr);
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            boolean success = commentDAO.toggleCommentStatus(commentId);
            
            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Đã thay đổi trạng thái bình luận thành công");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không thể thay đổi trạng thái bình luận");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "ID bình luận không hợp lệ");
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.getWriter().write(jsonResponse.toString());
    }
}
