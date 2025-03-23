package controller;

import DAO.PetDAO;
import Model.Pet;
import Model.HealthPrediction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/predictHealth")
public class HealthPredictionController extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy tham số petId từ request
        String petIdParam = request.getParameter("petId");

        // Kiểm tra nếu petId không có hoặc rỗng
        if (petIdParam == null || petIdParam.trim().isEmpty()) {
            // Chuyển hướng đến trang chọn thú cưng
            response.sendRedirect("selectPet");
            return;
        }

        int petId;
        try {
            petId = Integer.parseInt(petIdParam);
        } catch (NumberFormatException e) {
            // Nếu petId không phải là số hợp lệ, hiển thị lỗi
            request.setAttribute("error", "ID thú cưng không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin thú cưng
        Pet pet = petDAO.getPetDetailsById(petId);

        if (pet == null) {
            request.setAttribute("error", "Không tìm thấy thú cưng.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Logic dự đoán sức khỏe
        List<HealthPrediction> predictions = predictHealth(pet);

        // Chuyển dữ liệu sang JSP
        request.setAttribute("pet", pet);
        request.setAttribute("predictions", predictions);
        request.getRequestDispatcher("healthPrediction.jsp").forward(request, response);
    }

    private List<HealthPrediction> predictHealth(Pet pet) {
        List<HealthPrediction> predictions = new ArrayList<>();

        String species = pet.getSpecies();
        String breed = pet.getBreed();
        int age = pet.getAge();

        if ("Dog".equalsIgnoreCase(species)) {
            if ("Bulldog".equalsIgnoreCase(breed)) {
                if (age < 2) {
                    predictions.add(new HealthPrediction("Hô hấp", 0.10));
                    predictions.add(new HealthPrediction("Bệnh da", 0.15));
                } else if (age <= 6) {
                    predictions.add(new HealthPrediction("Hô hấp", 0.20));
                    predictions.add(new HealthPrediction("Béo phì", 0.25));
                } else {
                    predictions.add(new HealthPrediction("Hô hấp", 0.30));
                    predictions.add(new HealthPrediction("Viêm khớp", 0.40));
                }
            }
            // Thêm các giống chó khác nếu cần
        } else if ("Cat".equalsIgnoreCase(species)) {
            if ("Persian".equalsIgnoreCase(breed)) {
                if (age < 2) {
                    predictions.add(new HealthPrediction("Nhiễm trùng hô hấp", 0.15));
                } else if (age <= 6) {
                    predictions.add(new HealthPrediction("Bệnh thận", 0.20));
                } else {
                    predictions.add(new HealthPrediction("Suy thận", 0.50));
                }
            }
            // Thêm các giống mèo khác nếu cần
        }

        return predictions;
    }
}