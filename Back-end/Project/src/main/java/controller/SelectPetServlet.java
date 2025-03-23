package controller;

import DAO.PetDAO;
import Model.Pet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/selectPet")
public class SelectPetServlet extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy danh sách tất cả thú cưng
        List<Pet> pets = new ArrayList<>();

        // Truy vấn danh sách thú cưng từ database
        String sql = "SELECT PetID, PetName, Species, Breed, Age FROM Pets";
        try (var conn = Utils.DBContext.getConnection();
             var ps = conn.prepareStatement(sql);
             var rs = ps.executeQuery()) {
            while (rs.next()) {
                Pet pet = new Pet(
                    rs.getInt("PetID"),
                    rs.getString("Species"),
                    rs.getString("Breed"),
                    rs.getInt("Age")
                );
                pet.setPetName(rs.getString("PetName"));
                pets.add(pet);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi lấy danh sách thú cưng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Chuyển danh sách thú cưng sang selectPet.jsp
        request.setAttribute("pets", pets);
        request.getRequestDispatcher("selectPet.jsp").forward(request, response);
    }
}