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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/DoctorVacxinServlet/*")
public class DoctorVacxinServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all records
            MedicalRecordDAO dao = new MedicalRecordDAO();
            PetDAO pdao = new PetDAO();
            UserDAO udao = new UserDAO();

            List<Pet> Listp = pdao.getAllPets();
            List<User> Listu = udao.getDoctor();
            List<MedicalRecords> list = dao.getAllWithPetAndDoctor2();

            request.setAttribute("pet", Listp);
            request.setAttribute("doctors", Listu);
            request.setAttribute("records", list);
            request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
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
                    request.setAttribute("temperature", record.getTemperature());
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
            record.setVaccinationDetails(request.getParameter("vaccinationDetails"));
            String nextVaccinationDateStr = request.getParameter("nextVaccinationDate");

            if (nextVaccinationDateStr != null && !nextVaccinationDateStr.isEmpty()) {
                try {
                    // Định dạng ngày tháng theo định dạng bạn muốn (ví dụ: "yyyy-MM-dd")
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = sdf.parse(nextVaccinationDateStr); // Chuyển đổi String thành Date
                    Timestamp timestamp = new Timestamp(date.getTime()); // Chuyển Date thành Timestamp
                    record.setNextVaccinationDate(timestamp); // Gán Timestamp vào đối tượng
                } catch (Exception e) {
                    e.printStackTrace(); // Xử lý ngoại lệ nếu định dạng không hợp lệ
                }
            }
            // Kiểm tra cân nặng
            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                double weight = Double.parseDouble(weightStr);
                if (weight > 0) {
                    record.setWeight(weight);
                } else {
                    // Cân nặng phải lớn hơn 0
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Weight must be greater than 0.");
                    return;
                }
            } else {
                // Xử lý nếu weight không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Weight is required.");
                return;
            }

// Kiểm tra nhiệt độ
            String temperatureStr = request.getParameter("temperature");
            if (temperatureStr != null && !temperatureStr.isEmpty()) {
                double temperature = Double.parseDouble(temperatureStr);
                if (temperature > 0) {
                    record.setTemperature(temperature);
                }
                else if (temperature <= 0) {
                    // Nếu nhiệt độ không hợp lệ, gửi thông báo lỗi tới JSP
                    request.setAttribute("errorMessage", "Nhiệt độ phải lớn hơn 0.");
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return; // Dừng tiếp tục xử lý
                }
            } else {
                // Xử lý nếu temperature không hợp lệ
                request.setAttribute("errorMessage", "Lỗi giá trị nhập vào.");
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }

            record.setNotes(request.getParameter("notes"));
            record.setRecordDate(new Timestamp(System.currentTimeMillis()));

            if (dao.addVacxin(record)) {
                response.sendRedirect(request.getContextPath() + "/DoctorVacxinServlet");
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
                response.sendRedirect(request.getContextPath() + "/DoctorVacxinServlet");
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
