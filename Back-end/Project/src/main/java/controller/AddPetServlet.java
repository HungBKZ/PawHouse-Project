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
import java.util.List;

@WebServlet(name = "AddPetServlet", urlPatterns = {"/AddPetServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddPetServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "imgs/pet";  // Thư mục lưu ảnh

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("📥 AddPetServlet: Received request!");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            System.out.println("⚠️ User is not logged in!");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy dữ liệu từ form
            String petName = request.getParameter("petName");
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            String gender = request.getParameter("gender");
            String adoptionStatus = request.getParameter("adoptionStatus");

            // Kiểm tra dữ liệu đầu vào tránh lỗi null
            petName = (petName != null && !petName.trim().isEmpty()) ? petName.trim() : "Không có tên";
            species = (species != null && !species.trim().isEmpty()) ? species.trim().toLowerCase() : "Không xác định";
            breed = (breed != null && !breed.trim().isEmpty()) ? breed.trim() : "Không xác định";
            gender = (gender != null && !gender.trim().isEmpty()) ? gender : "Không rõ";
            adoptionStatus = (adoptionStatus != null) ? adoptionStatus : "Chưa nhận nuôi";

            // Xác định categoryID dựa trên species
            int categoryId;
            switch (species) {
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
                    categoryId = 5; // Mặc định nếu không khớp danh mục
            }

            // Kiểm tra và chuyển đổi age
            int age = 1; // Giá trị mặc định
            try {
                String ageParam = request.getParameter("age");
                if (ageParam != null && !ageParam.isEmpty()) {
                    age = Integer.parseInt(ageParam);
                }
            } catch (NumberFormatException e) {
                System.out.println("⚠️ Lỗi chuyển đổi tuổi, đặt giá trị mặc định là 1.");
            }

            // Tạo đối tượng PetCategories
            PetCategories category = new PetCategories(categoryId, "Loài được chọn", "Tự động nhận dạng");

            // Xử lý upload ảnh vào thư mục `imgs/pet`
            Part filePart = request.getPart("petImage");
            String fileName = "imgs/pet/default-pet.jpg"; // Ảnh mặc định

            if (filePart != null && filePart.getSize() > 0) {
                fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); // Tạo thư mục nếu chưa có
                }
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                fileName = UPLOAD_DIRECTORY + "/" + fileName; // Lưu đường dẫn tương đối
            }

            // Gọi DAO để lưu vào database
            PetDAO petDAO = new PetDAO();
            Pet pet = new Pet(0, category, petName, species, breed, age, gender, fileName, adoptionStatus, user);
            boolean insertSuccess = petDAO.insertPet(pet);

            if (insertSuccess) {
                System.out.println("🎉 Thêm thú cưng thành công!");

                // Cập nhật danh sách thú cưng sau khi thêm
                List<Pet> updatedPetList = petDAO.getPetsByUserId(user.getUserID());
                request.setAttribute("myPets", updatedPetList);

                request.getRequestDispatcher("myPet.jsp").forward(request, response);
            } else {
                System.out.println("❌ Thêm thú cưng thất bại!");
                response.sendRedirect("addPet.jsp?error=true");
            }

        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect("addPet.jsp?error=true");
        }
    }
}
