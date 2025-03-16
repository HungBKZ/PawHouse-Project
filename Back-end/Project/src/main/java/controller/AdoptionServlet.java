package controller;

import DAO.PetDAO;
import DAO.PetCategoriesDAO;
import DAO.UserDAO;
import Model.Pet;
import Model.PetCategories;
import Model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdoptionServlet", urlPatterns = {"/AdoptionServlet"})
public class AdoptionServlet extends HttpServlet {

    private PetDAO petDAO;
    private PetCategoriesDAO petCategoriesDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
        petCategoriesDAO = new PetCategoriesDAO();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            user = getUserFromCookies(request);
            if (user != null) {
                session.setAttribute("loggedInUser", user);
            }
        }

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserID();
        String filter = request.getParameter("filter");
        String category = request.getParameter("category");
        String search = request.getParameter("search");

        List<Pet> adoptionList = petDAO.getAllPetsForAdoption2("Chưa nhận nuôi");
        List<Pet> pendingAdoptionList = petDAO.getPetsByUserAndStatus(userId, "Đang chờ duyệt");

        List<Pet> petList = (filter != null && filter.equals("pendingAdoptionList")) ? pendingAdoptionList : adoptionList;

        // Lọc theo loài
        if (category != null && !category.equals("all")) {
            petList.removeIf(pet -> !pet.getSpecies().equalsIgnoreCase(category));
        }

        // Lọc theo tên thú cưng
        if (search != null && !search.isEmpty()) {
            petList.removeIf(pet -> !pet.getPetName().toLowerCase().contains(search.toLowerCase()));
        }

        List<PetCategories> categoriesList = petCategoriesDAO.getAll();
        request.setAttribute("categoriesList", categoriesList);
        request.setAttribute("petList", petList);
        request.setAttribute("filter", filter != null ? filter : "adoptionList");

        request.getRequestDispatcher("/adoption.jsp").forward(request, response);
    }

    private User getUserFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("authToken".equals(cookie.getName())) {
                    try {
                        String decodedValue = decodeAuthToken(cookie.getValue());
                        if (decodedValue != null && decodedValue.contains(":")) {
                            String email = decodedValue.split(":")[0];
                            return userDAO.getUserByEmail(email);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return null;
    }

    private String decodeAuthToken(String token) {
        return new String(java.util.Base64.getDecoder().decode(token));
    }
}
