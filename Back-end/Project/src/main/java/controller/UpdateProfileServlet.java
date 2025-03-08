package controller;

import DAO.UserDAO;
import Model.User;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateProfileServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "imgs"; // Thư mục lưu ảnh
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        
        // Xử lý upload file
        Part filePart = request.getPart("avatar");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String avatarPath = user.getAvatar(); // Giữ đường dẫn ảnh cũ nếu không upload ảnh mới
        
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // Tạo thư mục nếu chưa có
            }

            // Đường dẫn lưu file
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath); // Lưu ảnh vào thư mục
            
            // Cập nhật đường dẫn ảnh để hiển thị
            avatarPath = UPLOAD_DIR + "/" + fileName;
        }

        try {
            UserDAO userDAO = new UserDAO();
            
            // Cập nhật thông tin user
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAvatar(avatarPath); // Cập nhật ảnh mới

            boolean success = userDAO.updateUserProfile(user);
            
            if (success) {
                session.setAttribute("loggedInUser", user);
                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
