package controller;

import DAO.MedicalRecordDAO;
import DAO.PetDAO;
import DAO.UserDAO;

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
            PetDAO pdao = new PetDAO();
            UserDAO udao = new UserDAO();

            List<MedicalRecords> list = dao.getAllWithPetAndDoctor();
            List<Pet> Listp = pdao.getAllPets();
            List<User> Listu = udao.getDoctor();

            request.setAttribute("pet", Listp);
            request.setAttribute("doctors", Listu);
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

            Pet pet = new Pet();
            String petIdStr = request.getParameter("petId");
            if (petIdStr != null && !petIdStr.isEmpty()) {
                pet.setPetID(Integer.parseInt(petIdStr));
            } else {
                // Xử lý nếu petId không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Pet ID is required.");
                return;
            }
            record.setPet(pet);

            // Set doctor information
            User doctor = new User();
            String doctorIdStr = request.getParameter("doctorId");
            if (doctorIdStr != null && !doctorIdStr.isEmpty()) {
                doctor.setUserID(Integer.parseInt(doctorIdStr));
            } else {
                // Xử lý nếu doctorId không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Doctor ID is required.");
                return;
            }
            record.setDoctor(doctor);
            
            Appointment appointment = new Appointment();
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
                appointment.setAppointmentID(Integer.parseInt(appointmentIdStr));
            } else {
                // Xử lý nếu appointmentId không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Appointment ID is required.");
                return;
            }
            record.setAppointment(appointment);

            // Set medical record details
            record.setDiagnosis(request.getParameter("diagnosis"));
            record.setVaccinationDetails(request.getParameter("treatment"));
            record.setPrescription(request.getParameter("prescription"));
            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                record.setWeight(Double.parseDouble(weightStr));
            } else {
                // Xử lý nếu weight không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Weight is required.");
                return;
            }
            String temperatureStr = request.getParameter("temperature");
            if (temperatureStr != null && !temperatureStr.isEmpty()) {
                record.setTemperature(Double.parseDouble(temperatureStr));
            } else {
                // Xử lý nếu temperature không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Temperature is required.");
                return;
            }
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
