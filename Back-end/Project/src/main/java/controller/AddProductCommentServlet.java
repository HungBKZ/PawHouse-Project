package controller;

import DAO.ProductCommentDAO;
import DAO.ProductDAO;
import Model.Product;
import Model.ProductComment;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet(name = "AddProductCommentServlet", urlPatterns = {"/AddProductComment"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class AddProductCommentServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/comments";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
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
            
            // Handle image upload
            String imagePath = null;
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
                
                // Get the deployed directory path
                String deployedPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File deployedDir = new File(deployedPath);
                if (!deployedDir.exists()) {
                    deployedDir.mkdirs();
                }

                // Save file using NIO
                Path targetPath = Paths.get(deployedPath, fileName);
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, targetPath, StandardCopyOption.REPLACE_EXISTING);
                }
                
                // Store the web-accessible path
                imagePath = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;

                // Also save to the project directory for persistence
                try {
                    String projectPath = new File(getServletContext().getRealPath("")).getParentFile().getParentFile().getParentFile().getPath();
                    Path projectUploadPath = Paths.get(projectPath, "Project", "src", "main", "webapp", UPLOAD_DIR);
                    Files.createDirectories(projectUploadPath);
                    Files.copy(targetPath, projectUploadPath.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);
                } catch (IOException e) {
                    // Log the error but continue, as the file is already saved in the deployed directory
                    e.printStackTrace();
                }
            }
            
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                ProductComment comment = new ProductComment();
                comment.setUser(user);
                comment.setProduct(product);
                comment.setStar(star);
                comment.setContent(content);
                comment.setDateComment(new Timestamp(System.currentTimeMillis()));
                comment.setImage(imagePath);
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