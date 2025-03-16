package controller;

import DAO.PetDAO;
import DAO.AdoptionDAO;
import DAO.UserDAO;
import Model.Pet;
import Model.AdoptionHistory;
import Model.User;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
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

        // Nếu user chưa có trong session, kiểm tra trong cookie
        if (user == null) {
            user = getUserFromCookies(request);
            if (user != null) {
                session.setAttribute("loggedInUser", user);
            }
        }

        // Nếu vẫn chưa có user, chuyển hướng về login
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String petIdParam = request.getParameter("petId");

        if (petIdParam == null || petIdParam.isEmpty()) {
            response.sendRedirect("/AdoptionServlet");
            return;
        }

        try {
            int petId = Integer.parseInt(petIdParam);

            // Kiểm tra xem thú cưng có tồn tại không
            Pet pet = petDAO.getById(petId);
            if (pet == null || pet.getAdoptionStatus().equals("Đã nhận nuôi")) {
                response.sendRedirect("/AdoptionServlet");
                return;
            }

            // Cập nhật trạng thái của thú cưng
            pet.setAdoptionStatus("Đang chờ duyệt");
            pet.setOwner(user);
            petDAO.updatePet2(pet);

            // Lưu lịch sử nhận nuôi
            AdoptionHistory adoption = new AdoptionHistory(0, pet, Date.valueOf(LocalDate.now()), "Đã nhận nuôi", "Thú cưng đã được nhận nuôi");
            adoptionDAO.addAdoptionHistory(adoption);

            response.sendRedirect("/AdoptionServlet?filter=pendingAdoptionList");
        } catch (NumberFormatException e) {
            response.sendRedirect("/AdoptionServlet");
        }
    }

    /**
     * Lấy thông tin User từ Cookie
     */
    private User getUserFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("authToken".equals(cookie.getName())) {
                    try {
                        String decodedValue = decodeAuthToken(cookie.getValue());
                        if (decodedValue != null && decodedValue.contains(":")) {
                            String email = decodedValue.split(":")[0];
                            UserDAO userDAO = new UserDAO();
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

    /**
     * Giải mã authToken từ Base64
     */
    private String decodeAuthToken(String token) {
        return new String(java.util.Base64.getDecoder().decode(token));
    }
}
