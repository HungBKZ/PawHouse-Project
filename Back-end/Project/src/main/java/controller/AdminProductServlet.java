package controller;

import DAO.ProductAdminDAO;
import DAO.ProductCategoriesDAO;
import Model.ProductAdmin;
import Model.ProductCategories;
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

    private String getUploadDirectory(HttpServletRequest request) {
        Properties properties = new Properties();
        String configPath = "src/main/config/config.properties";

        try (InputStream input = new FileInputStream(configPath)) {
            properties.load(input);
            String uploadPath = properties.getProperty("upload.directory");
            if (uploadPath == null || uploadPath.isEmpty()) {
                uploadPath = request.getServletContext().getRealPath("/imgs/product");
            }
            return uploadPath;
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return request.getServletContext().getRealPath("/imgs/product");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductAdminDAO productDAO = new ProductAdminDAO();
        ProductCategoriesDAO categoryDAO = new ProductCategoriesDAO();

        String searchTerm = request.getParameter("search");
        List<ProductAdmin> productList;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            productList = productDAO.searchProductsByName(searchTerm);
        } else {
            productList = productDAO.getAllProducts();
        }

        List<ProductCategories> categoryList = categoryDAO.getAllCategories();

        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);
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

                if (price < 0 || stock < 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?error=InvalidValues");
                    return;
                }

                String uploadPath = getUploadDirectory(request);
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                Part filePart = request.getPart("image");
                String imagePath = request.getParameter("existingImage");

                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = "product" + System.currentTimeMillis() + ".jpg";
                    Path filePath = new File(uploadDir, fileName).toPath();
                    Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
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