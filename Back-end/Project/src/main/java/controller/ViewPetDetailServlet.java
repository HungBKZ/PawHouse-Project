/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Model.Pet;
import Model.MedicalRecords;
import DAO.PetDAO;
import DAO.MedicalRecordDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewPetDetailServlet")
public class ViewPetDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String petIdStr = request.getParameter("petId");
        if (petIdStr == null || petIdStr.trim().isEmpty()) {
            response.sendRedirect("adoption.jsp?error=missing_petId");
            return;
        }
        try {
            int petId = Integer.parseInt(petIdStr);
            PetDAO petDAO = new PetDAO();
            Pet pet = petDAO.getById(petId);
            if (pet != null) {
                MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
                List<MedicalRecords> medicalRecords = medicalRecordDAO.getMedicalRecordsByPetId(petId);
                request.setAttribute("petDetail", pet);
                request.setAttribute("medicalRecords", medicalRecords);
                RequestDispatcher dispatcher = request.getRequestDispatcher("MyPetDetail.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("adoption.jsp?error=not_found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("adoption.jsp?error=invalid_petId");
        }

    }
}
