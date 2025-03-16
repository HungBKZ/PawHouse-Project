package controller;

import DAO.ProductCommentDAO;
import Model.User;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteCommentServlet", urlPatterns = {"/DeleteComment"})
public class DeleteCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        JsonObject jsonResponse = new JsonObject();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Vui lòng đăng nhập để thực hiện chức năng này");
                response.getWriter().write(jsonResponse.toString());
                return;
            }
        }
        
        try {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            boolean success = commentDAO.deleteComment(commentId);
            
            jsonResponse.addProperty("success", success);
            if (success) {
                jsonResponse.addProperty("message", "Đã xóa đánh giá thành công");
            } else {
                jsonResponse.addProperty("message", "Không thể xóa đánh giá. Vui lòng thử lại sau");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Dữ liệu không hợp lệ");
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra khi xóa đánh giá");
            e.printStackTrace();
        }
        
        response.getWriter().write(jsonResponse.toString());
    }
}
