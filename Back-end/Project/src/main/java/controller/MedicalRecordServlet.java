package controller;

import DAO.MedicalRecordDAO;
import Model.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Timestamp;
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
            request.getRequestDispatcher("/doctorMedicalRecord.jsp").forward(request, response);
        } else {
            // Get record details
            try {
                int recordId = Integer.parseInt(pathInfo.substring(1));
                MedicalRecordDAO dao = new MedicalRecordDAO();
                MedicalRecords record = dao.getRecordById(recordId);
                
                if (record != null) {
                    request.setAttribute("record", record);
                    request.setAttribute("doctorName", record.getDoctor().getFullName());
                    request.setAttribute("doctorEmail", record.getDoctor().getEmail());
                    request.setAttribute("weight", record.getWeight());
                    request.setAttribute("temperature", record.getTemperature());
                    request.setAttribute("diagnosis", record.getDiagnosis());
                    request.setAttribute("treatment", record.getTreatment());
                    request.setAttribute("prescription", record.getPrescription());
                    request.setAttribute("notes", record.getNotes());
                    
                    if (record.getAppointment() != null) {
                        request.setAttribute("appointmentId", record.getAppointment().getAppointmentID());
                        request.setAttribute("appointmentDate", record.getAppointment().getAppointmentDate());
                        request.setAttribute("appointmentStatus", record.getAppointment().getAppointmentStatus());
                        request.setAttribute("serviceName", record.getAppointment().getService().getServiceName());
                        request.setAttribute("bookingDate", record.getAppointment().getBookingDate());
                    }
                    
                    request.getRequestDispatcher("/medicalRecordDetail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Medical record not found");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid record ID");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        MedicalRecordDAO dao = new MedicalRecordDAO();
        
        if ("add".equals(action)) {
            MedicalRecords record = new MedicalRecords();
            
            // Set pet information
            Pet pet = new Pet();
            pet.setPetID(Integer.parseInt(request.getParameter("petId")));
            record.setPet(pet);
            
            // Set doctor information
            User doctor = new User();
            doctor.setUserID(Integer.parseInt(request.getParameter("doctorId")));
            record.setDoctor(doctor);
            
            // Set appointment information
            Appointment appointment = new Appointment();
            appointment.setAppointmentID(Integer.parseInt(request.getParameter("appointmentId")));
            record.setAppointment(appointment);
            
            // Set medical record details
            record.setDiagnosis(request.getParameter("diagnosis"));
            record.setTreatment(request.getParameter("treatment"));
            record.setPrescription(request.getParameter("prescription"));
            record.setWeight(Double.parseDouble(request.getParameter("weight")));
            record.setTemperature(Double.parseDouble(request.getParameter("temperature")));
            record.setNotes(request.getParameter("notes"));
            record.setRecordDate(new Timestamp(System.currentTimeMillis()));
            
            if (dao.addMedicalRecord(record)) {
                response.sendRedirect(request.getContextPath() + "/medical-record");
            } else {
                request.setAttribute("error", "Không thể thêm hồ sơ bệnh án");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            MedicalRecords record = new MedicalRecords();
            record.setRecordID(Integer.parseInt(request.getParameter("recordId")));
            record.setDiagnosis(request.getParameter("diagnosis"));
            record.setTreatment(request.getParameter("treatment"));
            record.setPrescription(request.getParameter("prescription"));
            record.setWeight(Double.parseDouble(request.getParameter("weight")));
            record.setTemperature(Double.parseDouble(request.getParameter("temperature")));
            record.setNotes(request.getParameter("notes"));
            
            if (dao.updateMedicalRecord(record)) {
                response.sendRedirect(request.getContextPath() + "/medical-record");
            } else {
                request.setAttribute("error", "Không thể cập nhật hồ sơ bệnh án");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            try {
                int recordId = Integer.parseInt(pathInfo.substring(1));
                MedicalRecordDAO dao = new MedicalRecordDAO();
                
                if (dao.deleteMedicalRecord(recordId)) {
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa hồ sơ bệnh án");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID hồ sơ không hợp lệ");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID hồ sơ");
        }
    }
}
