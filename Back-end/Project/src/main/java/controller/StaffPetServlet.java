package controller;

import DAO.AdoptionHistoryDAO;
import DAO.PetDAO;
import DAO.ServiceDAO;
import DAO.UserDAO;
import Model.Pet;
import Model.PetCategories;
import Model.Service;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;

@WebServlet(name = "StaffPetServlet", urlPatterns = {"/StaffPetServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

public class StaffPetServlet extends HttpServlet {

    private PetDAO petDAO;
    private AdoptionHistoryDAO adoptionDAO;

    @Override
    public void init() {
        petDAO = new PetDAO();
        adoptionDAO = new AdoptionHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list";
            }
            if ("add".equals(action)) {
                // Lấy danh sách các dịch vụ
                ServiceDAO serviceDAO = new ServiceDAO();
                List<Service> services = serviceDAO.getAll();

                // Gửi danh sách dịch vụ sang trang addStaffPet.jsp
                request.setAttribute("services", services);
                request.getRequestDispatcher("addStaffPet.jsp").forward(request, response);
            }

            switch (action) {
                case "getUserID":
                    getUserID(request, response);
                    break;

                case "add":
                    showAddPetForm(request, response); // Gọi phương thức hiển thị form thêm pet
                    break;
                case "edit":
                    editPet(request, response);  // Xử lý chỉnh sửa pet
                    break;
                case "delete":
                    deletePet(request, response);  // ⚠️ THÊM DÒNG NÀY để xử lý xóa pet
                    break;
                case "list":
                    listPets(request, response);  // Hiển thị danh sách pet
                    break;
                default:
                    listPets(request, response);
            }
        } catch (Exception e) {
            // Thêm dòng này trước khi forward sang addStaffPet.jsp
            UserDAO userDAO = new UserDAO();
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("addStaffPet.jsp").forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if (action == null) {
                listPets(request, response);
                return;
            }

            switch (action) {
                case "add":
                    addPet(request, response);
                    break;
                case "update":
                    updatePet(request, response);
                    break;
                case "approveAdoption":  // ✅ Thêm dòng này
                    approveAdoption(request, response);
                    break;
                default:
                    listPets(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void listPets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin tìm kiếm từ request
            String searchKeyword = request.getParameter("search");
            String categoryIDParam = request.getParameter("category");
            String status = request.getParameter("status");

            Integer categoryID = null;
            if (categoryIDParam != null && !categoryIDParam.isEmpty()) {
                categoryID = Integer.parseInt(categoryIDParam);
            }

            // Gọi DAO để lấy danh sách Pet theo tiêu chí tìm kiếm
            List<Pet> petList = petDAO.searchPets(searchKeyword, categoryID, status);

            request.setAttribute("petList", petList);
            request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading pet list: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void searchPets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchKeyword = request.getParameter("search");
            String categoryIDParam = request.getParameter("category");
            String status = request.getParameter("status");

            Integer categoryID = null;
            if (categoryIDParam != null && !categoryIDParam.isEmpty()) {
                categoryID = Integer.parseInt(categoryIDParam);
            }

            List<Pet> petList = petDAO.searchPets(searchKeyword, categoryID, status);

            request.setAttribute("petList", petList);
            request.getRequestDispatcher("partials/petList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addPet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Validate input
            String petName = request.getParameter("petName");
            if (petName == null || petName.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên thú cưng không được để trống!");
            }

            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String adoptionStatus = request.getParameter("adoptionStatus");

            // Handle image upload
            Part filePart = request.getPart("petImage");
            String fileName = "";
            String petImage = "";

            if (filePart != null && filePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = request.getServletContext().getRealPath("") + "imgs" + File.separator + "pet";

                // Create directories if they don't exist
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Write file
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                petImage = "imgs/pet/" + fileName; // Store relative path in database
            } else {
                petImage = "imgs/pet/default-pet.jpg"; // Default image path
            }

            // Handle owner email
            String userEmail = request.getParameter("ownerEmail");
            Integer userID = null;
            if (userEmail != null && !userEmail.trim().isEmpty()) {
                UserDAO userDAO = new UserDAO();
                userID = userDAO.getUserIDByEmail(userEmail);
                if (userID == null) {
                    throw new IllegalArgumentException("Không tìm thấy tài khoản với email này!");
                }
            }

            // Handle service
            String inUseService = request.getParameter("inUseService");
            if (inUseService != null && inUseService.equals("NULL")) {
                inUseService = null;
            }

            // Create and save pet
            Pet newPet = new Pet();
            newPet.setCategory(new PetCategories(categoryID, "", ""));
            newPet.setPetName(petName);
            newPet.setSpecies(species);
            newPet.setBreed(breed);
            newPet.setAge(age);
            newPet.setGender(gender);
            newPet.setPetImage(petImage);
            newPet.setAdoptionStatus(adoptionStatus);
            newPet.setOwner(userID != null ? new User(userID) : null);
            newPet.setInUseService(inUseService);

            if (petDAO.insertPet(newPet)) {
                request.getSession().setAttribute("successMessage", "Thêm thú cưng thành công!");
                response.sendRedirect(request.getContextPath() + "/StaffPetServlet?action=list");
            } else {
                throw new Exception("Không thể thêm thú cưng vào cơ sở dữ liệu!");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            // Reload the form with services
            ServiceDAO serviceDAO = new ServiceDAO();
            List<Service> services = serviceDAO.getAll();
            request.setAttribute("services", services);
            request.getRequestDispatcher("/addStaffPet.jsp").forward(request, response);
        }
    }

    private void updatePet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int petID = Integer.parseInt(request.getParameter("petID"));
            String petName = request.getParameter("petName");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String adoptionStatus = request.getParameter("adoptionStatus");
            String petImage = request.getParameter("petImage");

            // Lấy thông tin Pet hiện tại từ database
            Pet existingPet = petDAO.getById(petID);
            if (existingPet == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thú cưng.");
                request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
                return;
            }

            // Cập nhật thông tin
            PetCategories category = new PetCategories(categoryID, "", "");
            existingPet.setPetName(petName);
            existingPet.setCategory(category);
            existingPet.setSpecies(species);
            existingPet.setBreed(breed);
            existingPet.setAge(age);
            existingPet.setGender(gender);
            existingPet.setAdoptionStatus(adoptionStatus);
            existingPet.setPetImage(petImage); // Đảm bảo ảnh được cập nhật

            // Gọi DAO để cập nhật Pet
            boolean updated = petDAO.updatePet(existingPet);
            if (updated) {
                response.sendRedirect("StaffPetServlet?action=list&success=updated");
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật thú cưng.");
                request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi cập nhật pet: " + e.getMessage());
            request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
        }
    }

    private void deletePet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy petID từ request
            String petIDParam = request.getParameter("petID");
            if (petIDParam == null || petIDParam.isEmpty()) {
                request.setAttribute("errorMessage", "Thiếu ID của thú cưng cần xóa.");
                request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
                return;
            }

            int petID = Integer.parseInt(petIDParam); // Chuyển đổi sang số nguyên

            // Xóa pet trong database
            boolean deleted = petDAO.deletePet(petID);

            if (deleted) {
                response.sendRedirect("StaffPetServlet?action=list&success=deleted");
            } else {
                request.setAttribute("errorMessage", "Không thể xóa thú cưng.");
                request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi xóa thú cưng: " + e.getMessage());
            request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
        }
    }

    private void approveAdoption(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int adoptionID = Integer.parseInt(request.getParameter("adoptionID"));
            String status = request.getParameter("status");

            // Kiểm tra giá trị hợp lệ của status
            if (status == null || (!status.equals("Accepted") && !status.equals("Rejected"))) {
                throw new IllegalArgumentException("Trạng thái không hợp lệ.");
            }

            // Cập nhật trạng thái nhận nuôi
            boolean updated = adoptionDAO.updateAdoptionStatus(adoptionID, status);
            if (!updated) {
                request.setAttribute("error", "Không thể cập nhật trạng thái nhận nuôi.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // Nếu được chấp nhận, cập nhật luôn trạng thái của pet
            if (status.equals("Accepted")) {
                adoptionDAO.updatePetAdoptionStatus(adoptionID);
            }

            // ✅ Thêm dòng này để chuyển hướng lại danh sách pet
            response.sendRedirect("StaffPetServlet?action=list&success=updated");

        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật trạng thái nhận nuôi: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int petID = Integer.parseInt(request.getParameter("petID"));
            Pet pet = petDAO.getById(petID);
            List<Pet> categories = petDAO.getAll();

            if (pet != null) {
                request.setAttribute("pet", pet);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("editStaffPet.jsp").forward(request, response);
            } else {
                response.sendRedirect("StaffPetServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi tải dữ liệu thú cưng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void editPet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int petID = Integer.parseInt(request.getParameter("petID"));
            Pet pet = petDAO.getById(petID);

            if (pet == null) {
                request.setAttribute("errorMessage", "Không tìm thấy thú cưng.");
                request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
                return;
            }

            List<PetCategories> categories = petDAO.getAllCategories(); // GỌI HÀM Ở ĐÂY ✅
            request.setAttribute("pet", pet);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("editStaffPet.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi chỉnh sửa: " + e.getMessage());
            request.getRequestDispatcher("staffManagePet.jsp").forward(request, response);
        }
    }

    private void showAddPetForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách danh mục thú cưng từ database
        List<PetCategories> categories = petDAO.getAllCategories();

        // Kiểm tra danh mục có tồn tại không
        if (categories == null) {
            categories = new ArrayList<>();
        }

        // Đặt danh sách danh mục vào request
        request.setAttribute("categories", categories);

        // Chuyển hướng đến trang addStaffPet.jsp
        request.getRequestDispatcher("addStaffPet.jsp").forward(request, response);
    }

    private void getUserID(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");

        // Khởi tạo đối tượng UserDAO để truy vấn database
        UserDAO userDAO = new UserDAO();
        Integer userID = userDAO.getUserIDByEmail(email);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"userID\": " + (userID != null ? userID : "null") + "}");
    }

}
