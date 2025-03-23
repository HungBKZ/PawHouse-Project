/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.MedicalRecords;
import Model.Pet;
import Model.User;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class MedicalRecordDAO extends DBContext {

    public List<MedicalRecords> getAll() {
        List<MedicalRecords> recordList = new ArrayList<>();
        String query = "SELECT * FROM MedicalRecords";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecords record = new MedicalRecords();
                record.setRecordID(rs.getInt("RecordID"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setTreatment(rs.getString("Treatment"));
                record.setPrescription(rs.getString("Prescription"));
                record.setWeight(rs.getDouble("Weight"));
                record.setTemperature(rs.getDouble("Temperature"));
                record.setNotes(rs.getString("Notes"));
                record.setRecordDate(rs.getTimestamp("RecordDate"));
                recordList.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recordList;
    }

    public List<MedicalRecords> getMedicalRecordsByPetId(int petId) {
        List<MedicalRecords> medicalRecords = new ArrayList<>();
        String query = " SELECT mr.RecordID, mr.AppointmentID, mr.DoctorID, mr.PetID, mr.Diagnosis, mr.Treatment, "
                + "mr.Prescription, mr.VaccinationDetails, mr.NextVaccinationDate, mr.Weight, mr.Temperature, mr.Notes, "
                + "mr.RecordDate, a.AppointmentDate, u.FullName, u.Phone FROM MedicalRecords mr LEFT JOIN Appointments a "
                + "ON mr.AppointmentID = a.AppointmentID LEFT JOIN Users u ON mr.DoctorID = u.UserID WHERE mr.PetID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, petId);  // Gán giá trị petId
            System.out.println("🟢 Query: SELECT * FROM MedicalRecords WHERE PetID = " + petId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MedicalRecords record = new MedicalRecords();
                record.setRecordID(rs.getInt("RecordID"));

                // Gán Appointment
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));  // Giả sử AppointmentID được lưu trong bảng MedicalRecords
                record.setAppointment(appointment);

                // Gán Doctor (User)
                User doctor = new User();
                doctor.setUserID(rs.getInt("DoctorID"));
                doctor.setFullName(rs.getString("FullName"));
                doctor.setPhone(rs.getString("Phone"));// Giả sử DoctorID là ID của bác sĩ trong bảng MedicalRecords
                record.setDoctor(doctor);

                // Gán Pet
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                record.setPet(pet);

                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setTreatment(rs.getString("Treatment"));
                record.setPrescription(rs.getString("Prescription"));
                record.setVaccinationDetails(rs.getString("VaccinationDetails"));
                record.setNextVaccinationDate(rs.getTimestamp("NextVaccinationDate"));
                record.setWeight(rs.getDouble("Weight"));
                record.setTemperature(rs.getDouble("Temperature"));
                record.setNotes(rs.getString("Notes"));
                record.setRecordDate(rs.getTimestamp("RecordDate"));

                medicalRecords.add(record);  // Thêm vào danh sách hồ sơ bệnh án
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy hồ sơ bệnh án cho PetID = " + petId + ": " + e.getMessage());
        }

        return medicalRecords;  // Trả về danh sách hồ sơ bệnh án (có thể rỗng nếu không có)
    }

}
