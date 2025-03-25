package controller;

import DAO.ServiceAdminDAO;
import Model.ServiceAdmin;
import Model.ServiceCategories; // Đổi từ ServiceCategory sang ServiceCategories
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Utils.DBContext;

@WebServlet("/admin/services")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AdminServiceServlet extends HttpServlet {

    private static String getUploadDir(HttpServletRequest request) {
        return request.getServletContext().getRealPath("/imgs/service");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DBContext.getConnection()) {
            ServiceAdminDAO serviceDAO = new ServiceAdminDAO(conn);

            // Lấy danh sách danh mục
            List<ServiceCategories> categoryList = serviceDAO.getAllCategories(); // Đổi từ ServiceCategory sang ServiceCategories
            request.setAttribute("categoryList", categoryList);

            // Lấy danh sách dịch vụ (có thể tìm kiếm)
            String search = request.getParameter("search");
            List<ServiceAdmin> serviceList = serviceDAO.getServicesByName(search);
            request.setAttribute("serviceList", serviceList);

            request.getRequestDispatcher("/adminService-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean isRedirected = false;
        try (Connection conn = DBContext.getConnection()) {
            ServiceAdminDAO serviceDAO = new ServiceAdminDAO(conn);
            String action = request.getParameter("action");

            if ("delete".equals(action)) {
                int serviceID = Integer.parseInt(request.getParameter("id"));
                serviceDAO.deleteService(serviceID);
            } else {
                int categoryID = Integer.parseInt(request.getParameter("categoryID"));
                String serviceName = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int status = Integer.parseInt(request.getParameter("status"));

                if (serviceName.trim().isEmpty() || description.trim().isEmpty() || price < 0) {
                    response.sendRedirect("/admin/services?error=invalidInput");
                    isRedirected = true;
                    return;
                }

                Part filePart = request.getPart("image");
                String imagePath = request.getParameter("existingImage");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = " Puzzle" + System.currentTimeMillis() + ".jpg";
                    String uploadDir = getUploadDir(request);
                    File uploadFolder = new File(uploadDir);
                    if (!uploadFolder.exists()) uploadFolder.mkdirs();
                    Path filePath = new File(uploadFolder, fileName).toPath();
                    Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    imagePath = "imgs/service/" + fileName;
                }

                int serviceID = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                        ? Integer.parseInt(request.getParameter("id"))
                        : 0;

                ServiceAdmin service = new ServiceAdmin(serviceID, categoryID, serviceName, description, price, imagePath, status);
                if ("add".equals(action)) {
                    boolean success = serviceDAO.addService(service);
                    if (!success) {
                        response.sendRedirect("/admin/services?error=addFailed");
                        isRedirected = true;
                        return;
                    }
                } else if ("update".equals(action)) {
                    serviceDAO.updateService(service);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (!isRedirected) {
                response.sendRedirect("/admin/services?error=serverError");
            }
        }
        if (!isRedirected) {
            response.sendRedirect("/admin/services");
        }
    }
}