package controller;

import DAO.AdminPetDAO;
import Model.AdminPet;
import Utils.DBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/pets")
@MultipartConfig
public class AdminPetServlet extends HttpServlet {
    private final String UPLOAD_DIR = "imgs/pet";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            try {
                int petID = Integer.parseInt(request.getParameter("id"));
                AdminPetDAO dao = new AdminPetDAO();
                boolean deleted = dao.deletePet(petID);
                if (!deleted) {
                    request.setAttribute("error", "Không thể xóa thú cưng. Do thú cưng này đang sử dụng dịch vụ hoặc đã được nhận nuôi.");
                } else {
                    request.setAttribute("success", "Đã xóa thú cưng thành công!");
                }
            } catch (RuntimeException e) {
                String errorMsg = e.getMessage();
                if (errorMsg.contains("MedicalRecords")) {
                    request.setAttribute("error", "Không thể xóa thú cưng vì có hồ sơ y tế. Vui lòng xóa hồ sơ y tế trước.");
                } else if (errorMsg.contains("AdoptionHistory")) {
                    request.setAttribute("error", "Không thể xóa thú cưng vì có lịch sử nhận nuôi. Vui lòng xóa lịch sử nhận nuôi trước.");
                } else {
                    request.setAttribute("error", "Lỗi: " + errorMsg);
                }
            }
        }
        
        List<AdminPet> petList = new AdminPetDAO().getAllPets();
        List<Integer> userIds = getUserIdsFromDatabase();
        request.setAttribute("petList", petList);
        request.setAttribute("userIds", userIds);
        request.getRequestDispatcher("/adminPet-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        AdminPetDAO dao = new AdminPetDAO();

        try {
            if ("add".equals(action)) {
                AdminPet pet = extractPetFromRequest(request, true);
                dao.addPet(pet);
                request.setAttribute("success", "Thêm thú cưng thành công!");
            } else if ("update".equals(action)) {
                AdminPet pet = extractPetFromRequest(request, false);
                int petID = pet.getPetID();
                String adoptionStatus = pet.getAdoptionStatus();
                String inUseService = pet.getInUseService();
                
                if ("Chưa nhận nuôi".equals(adoptionStatus)) {
                    dao.deleteAdoptionHistory(petID);
                }
                
                if (inUseService == null || inUseService.isEmpty()) {
                    dao.deleteAppointments(petID);
                }
                
                dao.updatePet(pet);
                request.setAttribute("success", "Cập nhật thú cưng thành công!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/pets");
        } catch (RuntimeException e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            doGet(request, response);
        }
    }

    private AdminPet extractPetFromRequest(HttpServletRequest request, boolean isNew) throws IOException, ServletException {
        int petID = isNew ? 0 : Integer.parseInt(request.getParameter("id"));
        int categoryID = Integer.parseInt(request.getParameter("categoryID"));
        String name = request.getParameter("name");
        String species = request.getParameter("species");
        String breed = request.getParameter("breed");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String adoptionStatus = request.getParameter("adoptionStatus");
        if (adoptionStatus == null || adoptionStatus.isEmpty()) {
            adoptionStatus = "Chưa nhận nuôi";
        }
        
        // Xử lý UserID dựa trên trạng thái nhận nuôi
        Integer userID;
        if ("Chưa nhận nuôi".equals(adoptionStatus) || "Đang chờ duyệt".equals(adoptionStatus)) {
            userID = null; // Đặt null nếu chưa nhận nuôi hoặc đang chờ duyệt
        } else {
            userID = Integer.parseInt(request.getParameter("userID"));
        }
        
        String inUseService = request.getParameter("inUseService");
        if (inUseService != null && inUseService.isEmpty()) {
            inUseService = null;
        }

        Part filePart = request.getPart("image");
        String fileName = extractFileName(filePart);
        String imagePath = null;

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = "pet" + UUID.randomUUID().toString().replace("-", "").substring(0, 8) + extension;
            filePart.write(uploadPath + File.separator + newFileName);
            imagePath = UPLOAD_DIR + "/" + newFileName;
        } else if (!isNew) {
            AdminPet oldPet = new AdminPetDAO().getPetById(petID);
            imagePath = oldPet != null ? oldPet.getPetImage() : null;
        }

        return new AdminPet(petID, categoryID, name, species, breed, age, gender, imagePath, adoptionStatus, userID, inUseService);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private List<Integer> getUserIdsFromDatabase() {
        List<Integer> userIds = new ArrayList<>();
        String query = "SELECT UserID FROM Users";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                userIds.add(rs.getInt("UserID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userIds;
    }
}