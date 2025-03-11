package controller;

import DAO.AdoptionDAO;
import Model.AdoptionHistory;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "StaffAdoptionManageServlet", urlPatterns = {"/staff/adoptions/*"})
public class StaffAdoptionManageServlet extends HttpServlet {
    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        adoptionDAO = new AdoptionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<AdoptionHistory> pendingAdoptions = adoptionDAO.getPendingAdoptions();
        request.setAttribute("pendingAdoptions", pendingAdoptions);
        request.getRequestDispatcher("/staffManageAdoptions.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null || !"staff".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int adoptionId = Integer.parseInt(request.getParameter("adoptionId"));
        String notes = request.getParameter("notes");

        if ("approve".equals(action)) {
            adoptionDAO.updateAdoptionStatus(adoptionId, "Approved", notes);
        } else if ("reject".equals(action)) {
            adoptionDAO.updateAdoptionStatus(adoptionId, "Rejected", notes);
        }

        response.sendRedirect(request.getContextPath() + "/staff/adoptions");
    }
}
