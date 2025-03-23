package controller;

import DAO.MedicalRecordDAO;
import Model.MedicalRecords;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

@WebServlet("/medical-record/*")
public class MedicalRecordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all records
            MedicalRecordDAO dao = new MedicalRecordDAO();
            List<MedicalRecords> list = dao.getAllWithPetAndDoctor();
            request.setAttribute("records", list);
            request.getRequestDispatcher("doctorMedicalRecord.jsp").forward(request, response);
        } else {
            // Get record details
            try {
                int recordId = Integer.parseInt(pathInfo.substring(1));
                MedicalRecordDAO dao = new MedicalRecordDAO();
                MedicalRecords record = dao.getRecordById(recordId);
                
                if (record != null) {
                    request.setAttribute("record", record);
                    request.getRequestDispatcher("/medicalRecordDetail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Medical record not found");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid record ID");
            }
        }
    }
}
