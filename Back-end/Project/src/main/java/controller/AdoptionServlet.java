package controller;

import DAO.PetDAO;
import Model.Pet;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdoptionServlet", urlPatterns = {"/AdoptionServlet"})
public class AdoptionServlet extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("🔍 [AdoptionServlet] Đang lấy danh sách tất cả thú cưng...");

        // 🟢 Lấy danh sách tất cả thú cưng (bao gồm Đã nhận nuôi và Chưa nhận nuôi)
        List<Pet> adoptionList = petDAO.getAllPetsForAdoption();

        if (adoptionList == null || adoptionList.isEmpty()) {
            System.out.println("⚠️ Không có thú cưng nào trong database!");
        } else {
            System.out.println("✅ Tìm thấy " + adoptionList.size() + " thú cưng.");
        }

        request.setAttribute("adoptionList", adoptionList);
        request.getRequestDispatcher("/adoption.jsp").forward(request, response);
    }
}

