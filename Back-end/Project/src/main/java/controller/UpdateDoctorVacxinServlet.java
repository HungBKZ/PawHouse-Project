package controller;

import DAO.MedicalRecordDAO;
import Model.MedicalRecords;
import Model.Pet;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "UpdateDoctorVacxinServlet", urlPatterns = {"/UpdateDoctorVacxin"})
public class UpdateDoctorVacxinServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            try {
                int recordId = Integer.parseInt(request.getParameter("recordId"));
                MedicalRecordDAO dao = new MedicalRecordDAO();
                MedicalRecords record = dao.getRecordById(recordId);

                if (record != null) {
                    request.setAttribute("record", record);
                    request.getRequestDispatcher("UpdateDoctorVacxin.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/DoctorVacxinServlet");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            try {
                int recordID = Integer.parseInt(request.getParameter("recordId"));
                String diagnosis = request.getParameter("diagnosis");
                String vaccinationDetails = request.getParameter("vaccinationDetails");
                String dateStr = request.getParameter("nextVaccinationDate");

                Timestamp nextVaccinationDate = null;
                if (dateStr != null && !dateStr.isEmpty()) {
                    dateStr = dateStr.replace("T", " ") + ":00"; // Chuyển thành "2025-03-25 15:30:00"
                    nextVaccinationDate = Timestamp.valueOf(dateStr);
                }
                String notes = request.getParameter("notes");
                double weight = Double.parseDouble(request.getParameter("weight"));
                double temperature = Double.parseDouble(request.getParameter("temperature"));

                MedicalRecordDAO dao = new MedicalRecordDAO();
                MedicalRecords existingRecord = dao.getRecordById(recordID);

                if (existingRecord != null) {
                    existingRecord.setDiagnosis(diagnosis);
                    existingRecord.setVaccinationDetails(vaccinationDetails);
                    existingRecord.setNextVaccinationDate(nextVaccinationDate);
                    existingRecord.setNotes(notes);
                    existingRecord.setWeight(weight);
                    existingRecord.setTemperature(temperature);

                    boolean success = dao.updateMedicalRecord2(existingRecord);

                    if (success) {
                        response.sendRedirect("/DoctorVacxinServlet");
                    } else {
                        request.setAttribute("error", "Cập nhật thất bại.");
                        request.setAttribute("record", existingRecord);
                        request.getRequestDispatcher("UpdateDoctorVacxin.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect("/DoctorVacxinServlet");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }
}
