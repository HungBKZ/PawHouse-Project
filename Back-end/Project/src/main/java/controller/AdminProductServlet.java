package controller;

import DAO.ProductAdminDAO;
import Model.ProductAdmin;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Properties;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AdminProductServlet extends HttpServlet {

    // Phương thức đọc đường dẫn thư mục lưu ảnh từ config.properties hoặc mặc định vào webapp/imgs/product
    private String getUploadDirectory(HttpServletRequest request) {
        Properties properties = new Properties();
        String configPath = "src/main/config/config.properties"; // Đường dẫn tương đối

        try (InputStream input = new FileInputStream(configPath)) {
            properties.load(input);
            String uploadPath = properties.getProperty("upload.directory");

            if (uploadPath == null || uploadPath.isEmpty()) {
                // Nếu không có config, tự động lấy thư mục trong webapp
                uploadPath = request.getServletContext().getRealPath("/imgs/product");
            }

            return uploadPath;
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return request.getServletContext().getRealPath("/imgs/product"); // Nếu có lỗi, dùng thư mục trong webapp
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductAdminDAO productDAO = new ProductAdminDAO();
        List<ProductAdmin> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/productAdmin.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductAdminDAO productDAO = new ProductAdminDAO();
        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = productDAO.deleteProduct(id);
                if (!deleted) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?error=DeleteFailed");
                    return;
                }
            } else {
                int categoryID = Integer.parseInt(request.getParameter("categoryID"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                int status = Integer.parseInt(request.getParameter("status"));

                if (categoryID < 1 || categoryID > 15 || (status != 0 && status != 1) || price < 0 || stock < 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?error=InvalidValues");
                    return;
                }

                // Lấy thư mục lưu ảnh từ config hoặc mặc định vào webapp/imgs/product
                String uploadPath = getUploadDirectory(request);
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs(); // Tạo thư mục nếu chưa có

                // Xử lý file ảnh
                Part filePart = request.getPart("image");
                String imagePath = request.getParameter("existingImage");

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = "product" + System.currentTimeMillis() + ".jpg";
                    Path filePath = new File(uploadDir, fileName).toPath();
                    Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                    // Cập nhật đường dẫn để lưu vào database (luôn lưu đường dẫn tương đối)
                    imagePath = "imgs/product/" + fileName;
                }

                if ("add".equals(action)) {
                    ProductAdmin product = new ProductAdmin(0, categoryID, name, description, price, stock, imagePath, status);
                    productDAO.addProduct(product);
                } else if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductAdmin product = new ProductAdmin(id, categoryID, name, description, price, stock, imagePath, status);
                    productDAO.updateProduct(product);
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products?error=InvalidInput");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
