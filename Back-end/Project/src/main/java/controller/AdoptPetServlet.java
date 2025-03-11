package controller;

import DAO.PetDAO;
import DAO.AdoptionDAO;
import Model.Pet;
import Model.AdoptionHistory;
import Model.User;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdoptPetServlet", urlPatterns = {"/AdoptPetServlet"})
public class AdoptPetServlet extends HttpServlet {
    private PetDAO petDAO;
    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
        adoptionDAO = new AdoptionDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String petIdParam = request.getParameter("petId");

        if (petIdParam == null || petIdParam.isEmpty()) {
            response.sendRedirect("adoption.jsp?error=invalidPet");
            return;
        }

        try {
            int petId = Integer.parseInt(petIdParam);

            // Kiểm tra xem thú cưng có tồn tại không
            Pet pet = petDAO.getById(petId);
            if (pet == null || pet.getAdoptionStatus().equals("Đã nhận nuôi")) {
                response.sendRedirect("adoption.jsp?error=notAvailable");
                return;
            }

            // Update pet information
            pet.setAdoptionStatus("Đã nhận nuôi");
            pet.setOwner(user);
            petDAO.updatePet(pet);

            // Lưu lịch sử nhận nuôi
            AdoptionHistory adoption = new AdoptionHistory(0, pet, Date.valueOf(LocalDate.now()), "Đã nhận nuôi", "Thú cưng đã được nhận nuôi");
            adoptionDAO.addAdoptionHistory(adoption);

            response.sendRedirect("myPet.jsp?success=adopted");
        } catch (NumberFormatException e) {
            response.sendRedirect("adoption.jsp?error=invalidPet");
        }
    }
}
