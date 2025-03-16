package controller;

import DAO.ProductCommentDAO;
import Model.User;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet(name = "EditCommentServlet", urlPatterns = {"/EditComment"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class EditCommentServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/comments";
    
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
            String content = request.getParameter("content");
            int star = Integer.parseInt(request.getParameter("star"));
            
            if (content == null || content.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Nội dung đánh giá không được để trống");
                response.getWriter().write(jsonResponse.toString());
                return;
            }
            
            if (star < 1 || star > 5) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Số sao phải từ 1 đến 5");
                response.getWriter().write(jsonResponse.toString());
                return;
            }
            
            // Handle image upload
            String imagePath = null;
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
                
                // Get the project's root directory path
                String projectPath = new File(getServletContext().getRealPath("")).getParentFile().getParentFile().getParentFile().getPath();
                
                // Create path to upload directory in project structure
                Path uploadPath = Paths.get(projectPath, "src", "main", "webapp", UPLOAD_DIR);
                File uploadDir = uploadPath.toFile();
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Save the file to project directory
                String filePath = uploadPath.resolve(fileName).toString();
                filePart.write(filePath);
                
                // Also save to the deployed directory for immediate access
                String deployedPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File deployedDir = new File(deployedPath);
                if (!deployedDir.exists()) {
                    deployedDir.mkdirs();
                }
                filePart.write(deployedPath + File.separator + fileName);
                
                // Store the web-accessible path
                imagePath = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
            }
            
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            boolean success = commentDAO.updateComment(commentId, content, star, imagePath);
            
            jsonResponse.addProperty("success", success);
            if (success) {
                jsonResponse.addProperty("message", "Đã cập nhật đánh giá thành công");
                if (imagePath != null) {
                    jsonResponse.addProperty("imagePath", imagePath);
                }
            } else {
                jsonResponse.addProperty("message", "Không thể cập nhật đánh giá. Vui lòng thử lại sau");
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Dữ liệu không hợp lệ");
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra khi cập nhật đánh giá");
            e.printStackTrace();
        }
        
        response.getWriter().write(jsonResponse.toString());
    }
    
    private String getFileExtension(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                int dotIndex = fileName.lastIndexOf(".");
                return dotIndex > 0 ? fileName.substring(dotIndex) : "";
            }
        }
        return "";
    }
}
