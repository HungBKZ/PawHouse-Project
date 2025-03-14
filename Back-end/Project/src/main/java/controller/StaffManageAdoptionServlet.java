package controller;

import DAO.AdoptionDAO;
import Model.AdoptionHistory;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StaffManageAdoptionServlet", urlPatterns = {"/staffManageAdoption"})
public class StaffManageAdoptionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        String dateStr = request.getParameter("date");
        
        AdoptionDAO adoptionDAO = new AdoptionDAO();
        List<AdoptionHistory> adoptions;
        
        // Get adoptions based on filters
        if (status != null && !status.isEmpty() || dateStr != null && !dateStr.isEmpty()) {
            adoptions = adoptionDAO.getFilteredAdoptions(status, dateStr);
        } else {
            adoptions = adoptionDAO.getAllAdoptions();
        }
        
        request.setAttribute("adoptions", adoptions);
        request.getRequestDispatcher("/staffManageAdoption.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int adoptionId = Integer.parseInt(request.getParameter("adoptionId"));
        String notes = request.getParameter("notes");
        
        AdoptionDAO adoptionDAO = new AdoptionDAO();
        String status = "";
        
        if ("approve".equals(action)) {
            status = "Approved";
        } else if ("reject".equals(action)) {
            status = "Rejected";
        }
        
        if (!status.isEmpty()) {
            boolean updated = adoptionDAO.updateAdoptionStatus(adoptionId, status, notes);
            if (updated) {
                // Update pet's adoption status if approved
                if ("Approved".equals(status)) {
                    adoptionDAO.updatePetAdoptionStatus(adoptionId, "Adopted");
                }
                response.sendRedirect(request.getContextPath() + "/staffManageAdoption?success=true");
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/staffManageAdoption?error=true");
    }
}
