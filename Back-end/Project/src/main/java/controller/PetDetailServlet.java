package controller;

import DAO.PetDAO;
import DAO.AdoptionDAO;
import Model.Pet;
import Model.AdoptionHistory;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PetDetailServlet", urlPatterns = {"/PetDetailServlet"})
public class PetDetailServlet extends HttpServlet {
    private PetDAO petDAO;
    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
        adoptionDAO = new AdoptionDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int petId = Integer.parseInt(request.getParameter("petId"));
            Pet pet = petDAO.getById(petId);
            List<AdoptionHistory> adoptionHistory = adoptionDAO.getAdoptionHistoryByPetId(petId);

            if (pet == null) {
                response.sendRedirect("adoption.jsp?error=notfound");
                return;
            }

            request.setAttribute("petDetail", pet);
            request.setAttribute("adoptionHistory", adoptionHistory);
            request.getRequestDispatcher("/petDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("adoption.jsp?error=invalidid");
        }
    }
}
