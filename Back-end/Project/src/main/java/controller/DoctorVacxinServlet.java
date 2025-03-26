package controller;

import DAO.MedicalRecordDAO;
import DAO.PetDAO;
import DAO.UserDAO;
import DAO.AppointmentDAO;
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

    private void loadAndSetLists(HttpServletRequest request) {
        MedicalRecordDAO dao = new MedicalRecordDAO();
        PetDAO pdao = new PetDAO();
        UserDAO udao = new UserDAO();
        AppointmentDAO adao = new AppointmentDAO();
        

        List<Appointment> Lista = adao.getAllAppointmentsDoctorVacxin();
        List<Pet> Listp = pdao.getAllPets();
        List<User> Listu = udao.getDoctor();
        List<MedicalRecords> list = dao.getAllWithPetAndDoctor2();
        
        
        request.setAttribute("AppointmentsDoctor", Lista);
        request.setAttribute("pet", Listp);
        request.setAttribute("doctors", Listu);
        request.setAttribute("records", list);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            loadAndSetLists(request);
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
                    request.setAttribute("errorMessage", "Hồ sơ bệnh án không tồn tại");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID hồ sơ không hợp lệ");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
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
                try {
                    pet.setPetID(Integer.parseInt(petIdStr));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "ID thú cưng phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "ID thú cưng là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }
            record.setPet(pet);

            // Set doctor information
            User doctor = new User();
            String doctorIdStr = request.getParameter("doctorId");
            if (doctorIdStr != null && !doctorIdStr.isEmpty()) {
                try {
                    doctor.setUserID(Integer.parseInt(doctorIdStr));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "ID bác sĩ phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "ID bác sĩ là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }
            record.setDoctor(doctor);

            Appointment appointment = new Appointment();
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
                try {
                    appointment.setAppointmentID(Integer.parseInt(appointmentIdStr));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "ID lịch hẹn phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "ID lịch hẹn là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }
            record.setAppointment(appointment);

            // Set medical record details
            record.setDiagnosis(request.getParameter("diagnosis"));
            record.setVaccinationDetails(request.getParameter("vaccinationDetails"));
            String nextVaccinationDateStr = request.getParameter("nextVaccinationDate");

            if (nextVaccinationDateStr != null && !nextVaccinationDateStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date nextVaccinationDate = sdf.parse(nextVaccinationDateStr);
                    
                    // Lấy thời gian hiện tại
                    Date currentDate = new Date();
                    
                    // Tính số ngày giữa nextVaccinationDate và ngày hiện tại
                    long diffInMillies = nextVaccinationDate.getTime() - currentDate.getTime();
                    long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
                    
                    if (diffInDays < 30) {
                        request.setAttribute("errorMessage", "Ngày tiêm chủng tiếp theo phải cách ít nhất 30 ngày so với ngày hiện tại.");
                        loadAndSetLists(request);
                        request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                        return;
                    }
                    
                    record.setNextVaccinationDate(new Timestamp(nextVaccinationDate.getTime()));
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            }

            // Kiểm tra cân nặng
            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                try {
                    double weight = Double.parseDouble(weightStr);
                    if (weight > 0) {
                        record.setWeight(weight);
                    } else {
                        request.setAttribute("errorMessage", "Cân nặng phải lớn hơn 0.");
                        loadAndSetLists(request);
                        request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Cân nặng phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Cân nặng là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }

            // Kiểm tra nhiệt độ
            String temperatureStr = request.getParameter("temperature");
            if (temperatureStr != null && !temperatureStr.isEmpty()) {
                try {
                    double temperature = Double.parseDouble(temperatureStr);
                    if (temperature > 0) {
                        record.setTemperature(temperature);
                    } else {
                        request.setAttribute("errorMessage", "Nhiệt độ phải lớn hơn 0.");
                        loadAndSetLists(request);
                        request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Nhiệt độ phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Nhiệt độ là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }

            record.setNotes(request.getParameter("notes"));
            record.setRecordDate(new Timestamp(System.currentTimeMillis()));

            if (dao.addVacxin(record)) {
                response.sendRedirect(request.getContextPath() + "/DoctorVacxinServlet");
            } else {
                request.setAttribute("errorMessage", "Không thể thêm hồ sơ bệnh án");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            MedicalRecords record = new MedicalRecords();
            String recordIdStr = request.getParameter("recordId");
            if (recordIdStr != null && !recordIdStr.isEmpty()) {
                try {
                    record.setRecordID(Integer.parseInt(recordIdStr));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "ID hồ sơ phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "ID hồ sơ là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }

            record.setDiagnosis(request.getParameter("diagnosis"));
            record.setTreatment(request.getParameter("treatment"));
            record.setPrescription(request.getParameter("prescription"));
            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                try {
                    record.setWeight(Double.parseDouble(weightStr));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Cân nặng phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Cân nặng là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }

            String temperatureStr = request.getParameter("temperature");
            if (temperatureStr != null && !temperatureStr.isEmpty()) {
                try {
                    record.setTemperature(Double.parseDouble(temperatureStr));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Nhiệt độ phải là số hợp lệ.");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Nhiệt độ là bắt buộc.");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                return;
            }

            record.setNotes(request.getParameter("notes"));

            if (dao.updateMedicalRecord(record)) {
                response.sendRedirect(request.getContextPath() + "/DoctorVacxinServlet");
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật hồ sơ bệnh án");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
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
                    request.setAttribute("errorMessage", "Không thể xóa hồ sơ bệnh án");
                    loadAndSetLists(request);
                    request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID hồ sơ không hợp lệ");
                loadAndSetLists(request);
                request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Thiếu ID hồ sơ");
            loadAndSetLists(request);
            request.getRequestDispatcher("/doctorVaccination.jsp").forward(request, response);
        }
    }
}
