package controller;

import DAO.PetDAO;
import DAO.UserDAO;
import Model.Pet;
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

@WebServlet(name = "MyPetServlet", urlPatterns = {"/MyPet"})
public class MyPetServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        // Nếu vẫn chưa có user, chuyển hướng về trang đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy danh sách thú cưng của user
            PetDAO petDAO = new PetDAO();
            List<Pet> petList = petDAO.getPetsByUserId2(user.getUserID());

            // Lưu danh sách vào request và chuyển tiếp đến trang hiển thị
            request.setAttribute("petList", petList);
            request.getRequestDispatcher("myPet.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
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
