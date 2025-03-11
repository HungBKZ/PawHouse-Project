package controller;

import DAO.PetDAO;
import DAO.PetCategoriesDAO;
import Model.Pet;
import Model.PetCategories;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.ArrayList;

@WebServlet(name = "StaffManagePetServlet", urlPatterns = {"/staff/pets/*"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class StaffManagePetServlet extends HttpServlet {

    private PetDAO petDAO;
    private PetCategoriesDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        petDAO = new PetDAO();
        categoryDAO = new PetCategoriesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Get search parameters
            String searchQuery = request.getParameter("search");
            String categoryFilter = request.getParameter("category");
            String statusFilter = request.getParameter("status");

            // Get all pets with filters
            List<Pet> allPets = petDAO.getAll();
            List<Pet> filteredPets = new ArrayList<>();

            // Apply filters
            for (Pet pet : allPets) {
                boolean matchesSearch = searchQuery == null || searchQuery.isEmpty()
                        || pet.getPetName().toLowerCase().contains(searchQuery.toLowerCase())
                        || pet.getSpecies().toLowerCase().contains(searchQuery.toLowerCase())
                        || pet.getBreed().toLowerCase().contains(searchQuery.toLowerCase());

                boolean matchesCategory = categoryFilter == null || categoryFilter.isEmpty()
                        || String.valueOf(pet.getCategory().getCategoryID()).equals(categoryFilter);

                boolean matchesStatus = statusFilter == null || statusFilter.isEmpty()
                        || pet.getAdoptionStatus().equalsIgnoreCase(statusFilter);

                if (matchesSearch && matchesCategory && matchesStatus) {
                    filteredPets.add(pet);
                }
            }

            // Get all categories for the filter dropdown
            List<PetCategories> categories = categoryDAO.getAll();

            request.setAttribute("pets", filteredPets);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/staffManagePet.jsp").forward(request, response);
        } else if (pathInfo.equals("/add")) {
            // Show add pet form
            List<PetCategories> categories = categoryDAO.getAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/staffAddPet.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Show edit pet form
            try {
                int petId = Integer.parseInt(pathInfo.substring(6));
                Pet pet = petDAO.getById(petId);
                if (pet != null) {
                    List<PetCategories> categories = categoryDAO.getAll();
                    request.setAttribute("pet", pet);
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("/staffEditPet.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/staff/pets");
                    request.getSession().setAttribute("errorMessage", "Pet not found.");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/staff/pets");
                request.getSession().setAttribute("errorMessage", "Invalid pet ID.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/staff/pets");
        } else if (pathInfo.equals("/add")) {
            handleAddPet(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            handleEditPet(request, response);
        } else if (pathInfo.startsWith("/delete/")) {
            handleDeletePet(request, response);
        }
    }

    private void handleAddPet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form data
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String petName = request.getParameter("petName");
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String adoptionStatus = "Available"; // Default status for new pets

            // Handle image upload
            Part filePart = request.getPart("petImage");
            String fileName = "";
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                fileName = UUID.randomUUID().toString() + "_" + submittedFileName;
                String uploadPath = getServletContext().getRealPath("/uploads/pets");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                filePart.write(uploadPath + File.separator + fileName);
            }

            // Create new pet object
            Pet pet = new Pet();
            PetCategories category = new PetCategories();
            category.setCategoryID(categoryId);
            pet.setCategory(category);
            pet.setPetName(petName);
            pet.setSpecies(species);
            pet.setBreed(breed);
            pet.setAge(age);
            pet.setGender(gender);
            pet.setPetImage(fileName);
            pet.setAdoptionStatus(adoptionStatus);

            // Set default owner (system or null)
            User defaultOwner = new User();
            defaultOwner.setUserID(1); // Assuming 1 is the system/admin user ID
            pet.setOwner(defaultOwner);

            // Save to database
            boolean success = petDAO.insertPet(pet);
            if (success) {
                request.getSession().setAttribute("successMessage", "Pet added successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add pet. Please try again.");
            }
            response.sendRedirect(request.getContextPath() + "/staff/pets");

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/staff/pets/add");
        }
    }

    private void handleEditPet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get pet ID from path
            String pathInfo = request.getPathInfo();
            int petId = Integer.parseInt(pathInfo.substring(6));

            // Get existing pet
            Pet existingPet = petDAO.getById(petId);
            if (existingPet == null) {
                request.getSession().setAttribute("errorMessage", "Pet not found.");
                response.sendRedirect(request.getContextPath() + "/staff/pets");
                return;
            }

            // Get form data
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String petName = request.getParameter("petName");
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String adoptionStatus = request.getParameter("adoptionStatus");

            // Handle image upload
            Part filePart = request.getPart("petImage");
            String fileName = existingPet.getPetImage(); // Keep existing image by default

            if (filePart != null && filePart.getSize() > 0) {
                // Delete old image if it exists
                if (fileName != null && !fileName.isEmpty()) {
                    String oldImagePath = getServletContext().getRealPath("/uploads/pets") + File.separator + fileName;
                    File oldImage = new File(oldImagePath);
                    if (oldImage.exists()) {
                        oldImage.delete();
                    }
                }

                // Save new image
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                fileName = UUID.randomUUID().toString() + "_" + submittedFileName;
                String uploadPath = getServletContext().getRealPath("/uploads/pets");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                filePart.write(uploadPath + File.separator + fileName);
            }

            // Update pet object
            PetCategories category = new PetCategories();
            category.setCategoryID(categoryId);
            existingPet.setCategory(category);
            existingPet.setPetName(petName);
            existingPet.setSpecies(species);
            existingPet.setBreed(breed);
            existingPet.setAge(age);
            existingPet.setGender(gender);
            existingPet.setPetImage(fileName);
            existingPet.setAdoptionStatus(adoptionStatus);

            // Save to database
            boolean success = petDAO.updatePet(existingPet);
            if (success) {
                request.getSession().setAttribute("successMessage", "Pet updated successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update pet. Please try again.");
            }
            response.sendRedirect(request.getContextPath() + "/staff/pets");

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/staff/pets");
        }
    }

    private void handleDeletePet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get pet ID from path
            String pathInfo = request.getPathInfo();
            int petId = Integer.parseInt(pathInfo.substring(8));

            // Get existing pet
            Pet existingPet = petDAO.getById(petId);
            if (existingPet == null) {
                request.getSession().setAttribute("errorMessage", "Pet not found.");
                response.sendRedirect(request.getContextPath() + "/staff/pets");
                return;
            }

            // Delete pet image if it exists
            String fileName = existingPet.getPetImage();
            if (fileName != null && !fileName.isEmpty()) {
                String imagePath = getServletContext().getRealPath("/uploads/pets") + File.separator + fileName;
                File image = new File(imagePath);
                if (image.exists()) {
                    image.delete();
                }
            }

            // Delete from database
            boolean success = petDAO.deletePet(petId);
            if (success) {
                request.getSession().setAttribute("successMessage", "Pet deleted successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete pet. Please try again.");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/staff/pets");
    }
}
