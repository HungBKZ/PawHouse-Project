package controller;

import DAO.PetDAO;
import Model.Pet;
import Model.PetCategories;
import Model.User;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "EditPetServlet", urlPatterns = {"/EditPetServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class EditPetServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "imgs/pet";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int petId = Integer.parseInt(request.getParameter("petId"));
            String petName = request.getParameter("petName");
            int age = Integer.parseInt(request.getParameter("age"));
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            String gender = request.getParameter("gender");
            String adoptionStatus = request.getParameter("adoptionStatus");

            // Xử lý categoryID dựa trên species
            int categoryId;
            switch (species.toLowerCase()) {
                case "chó":
                    categoryId = 1;
                    break;
                case "mèo":
                    categoryId = 2;
                    break;
                case "bò sát":
                    categoryId = 3;
                    break;
                case "gặm nhấm":
                    categoryId = 4;
                    break;
                default:
                    categoryId = 5; // Loại khác
            }

            // Xử lý upload ảnh (nếu có)
            Part filePart = request.getPart("petImage");
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                fileName = UPLOAD_DIRECTORY + "/" + fileName;
            } else {
                // Không thay đổi ảnh nếu không upload ảnh mới
                fileName = request.getParameter("existingImage");
            }

            // Tạo đối tượng Pet
            Pet pet = new Pet(petId, new PetCategories(categoryId, "Loài tự động xác định", ""), petName, species, breed, age, gender, fileName, adoptionStatus, user);

            // Update pet information
            PetDAO petDAO = new PetDAO();
            petDAO.updatePet(pet);

            response.sendRedirect("myPet.jsp?success=updated");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editPet.jsp?petId=" + request.getParameter("petId") + "&error=update_failed");
        }
    }
}
