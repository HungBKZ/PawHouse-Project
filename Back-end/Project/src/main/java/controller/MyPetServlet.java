package controller;

import DAO.PetDAO;
import Model.Pet;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "MyPetServlet", urlPatterns = {"/MyPet"})
public class MyPetServlet extends HttpServlet {

    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        boolean isStaff = user.getRole() != null && user.getRole().getRoleID() == 2;

        if (action != null && isStaff) {
            int petId = Integer.parseInt(request.getParameter("petId"));
            switch (action) {
                case "edit":
                    response.sendRedirect("editPet.jsp?petId=" + petId);
                    return;
                case "delete":
                    petDAO.deletePet(petId);
                    response.sendRedirect("MyPet");
                    return;
            }
        }

        // Lấy danh sách thú cưng của người dùng
        List<Pet> petList = petDAO.getPetsByUserId(user.getUserID());

        // Kiểm tra trạng thái dịch vụ của từng thú cưng
        for (Pet pet : petList) {
            String inUseService = pet.getInUseService();
            if (inUseService == null || inUseService.trim().isEmpty()) {
                pet.setInUseService("Chưa từng sử dụng dịch vụ");
                System.out.println("Pet " + pet.getPetName() + " has no service status");
            } else {
                // Chuyển đổi giá trị số sang text
                switch (inUseService) {
                    case "Đang tiến hành":
                        pet.setInUseService("Đang tiến hành");
                        break;
                    case "Chưa hoàn thành":
                        pet.setInUseService("Chưa hoàn thành");
                        break;
                    case "Hoàn thành":
                        pet.setInUseService("Hoàn thành");
                        break;
                    default:
                        pet.setInUseService("Chưa từng sử dụng dịch vụ");
                }
                System.out.println("Pet " + pet.getPetName() + " service status: " + inUseService + " -> " + pet.getInUseService());
            }
        }

        request.setAttribute("myPets", petList);
        request.setAttribute("isStaff", isStaff);
        request.getRequestDispatcher("/myPet.jsp").forward(request, response);
    }
}
