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
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
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
            
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                ProductComment comment = new ProductComment();
                comment.setUser(user);
                comment.setProduct(product);
                comment.setStar(star);
                comment.setContent(content);
                comment.setDateComment(Date.valueOf(LocalDate.now()));
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
