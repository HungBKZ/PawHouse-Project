package DAO;

import Model.*;
import Utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO extends DBContext {

    public List<MedicalRecords> getAllWithPetAndDoctor() {
        List<MedicalRecords> recordList = new ArrayList<>();
        String query =
            "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, " +
            "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, " +
            "p.PetID, p.PetName, u.UserID, u.FullName AS OwnerName " +
            "FROM MedicalRecords mr " +
            "LEFT JOIN Pets p ON mr.PetID = p.PetID " +
            "LEFT JOIN Users u ON p.UserID = u.UserID";

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
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

                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setPetName(rs.getString("PetName"));

                User owner = new User();
                owner.setUserID(rs.getInt("UserID"));
                owner.setFullName(rs.getString("OwnerName"));

                pet.setOwner(owner);
                record.setPet(pet);

                recordList.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recordList;
    }

    public MedicalRecords getRecordById(int recordId) {
        String query =
            "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, " +
            "mr.VaccinationDetails, mr.NextVaccinationDate, " +
            "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, " +
            "p.PetID, p.PetName, p.Species, p.Breed, p.Age, p.Gender, p.PetImage, " +
            "pc.CategoryName, " +
            "u.UserID, u.FullName AS OwnerName, u.Email AS OwnerEmail, u.Phone AS OwnerPhone, " +
            "d.UserID AS DoctorID, d.FullName AS DoctorName, d.Email AS DoctorEmail, " +
            "a.AppointmentID, a.AppointmentDate, a.BookingDate, a.AppointmentStatus, a.Notes AS AppointmentNotes, " +
            "s.ServiceID, s.ServiceName, s.Description AS ServiceDescription " +
            "FROM MedicalRecords mr " +
            "LEFT JOIN Pets p ON mr.PetID = p.PetID " +
            "LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID " +
            "LEFT JOIN Users u ON p.UserID = u.UserID " +
            "LEFT JOIN Users d ON mr.DoctorID = d.UserID " +
            "LEFT JOIN Appointments a ON mr.AppointmentID = a.AppointmentID " +
            "LEFT JOIN Services s ON a.ServiceID = s.ServiceID " +
            "WHERE mr.RecordID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, recordId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    MedicalRecords record = new MedicalRecords();
                    record.setRecordID(rs.getInt("RecordID"));
                    record.setDiagnosis(rs.getString("Diagnosis"));
                    record.setTreatment(rs.getString("Treatment"));
                    record.setPrescription(rs.getString("Prescription"));
                    record.setVaccinationDetails(rs.getString("VaccinationDetails"));
                    record.setNextVaccinationDate(rs.getTimestamp("NextVaccinationDate"));
                    record.setWeight(rs.getDouble("Weight"));
                    record.setTemperature(rs.getDouble("Temperature"));
                    record.setNotes(rs.getString("Notes"));
                    record.setRecordDate(rs.getTimestamp("RecordDate"));

                    // Pet information
                    Pet pet = new Pet();
                    pet.setPetID(rs.getInt("PetID"));
                    pet.setPetName(rs.getString("PetName"));
                    pet.setSpecies(rs.getString("Species"));
                    pet.setBreed(rs.getString("Breed"));
                    pet.setAge(rs.getInt("Age"));
                    pet.setGender(rs.getString("Gender"));
                    pet.setPetImage(rs.getString("PetImage"));
                    
                    // Pet Category
                    PetCategories category = new PetCategories();
                    category.setCategoryName(rs.getString("CategoryName"));
                    pet.setCategory(category);

                    // Owner information
                    User owner = new User();
                    owner.setUserID(rs.getInt("UserID"));
                    owner.setFullName(rs.getString("OwnerName"));
                    owner.setEmail(rs.getString("OwnerEmail"));
                    owner.setPhone(rs.getString("OwnerPhone"));
                    pet.setOwner(owner);

                    // Doctor information
                    User doctor = new User();
                    doctor.setUserID(rs.getInt("DoctorID"));
                    doctor.setFullName(rs.getString("DoctorName"));
                    doctor.setEmail(rs.getString("DoctorEmail"));

                    // Appointment information
                    int appointmentId = rs.getInt("AppointmentID");
                    if (!rs.wasNull()) {
                        Appointment appointment = new Appointment();
                        appointment.setAppointmentID(appointmentId);
                        appointment.setAppointmentDate(rs.getTimestamp("AppointmentDate"));
                        appointment.setBookingDate(rs.getTimestamp("BookingDate"));
                        appointment.setAppointmentStatus(rs.getString("AppointmentStatus"));
                        appointment.setNotes(rs.getString("AppointmentNotes"));
                        
                        // Service information
                        Service service = new Service();
                        service.setServiceID(rs.getInt("ServiceID"));
                        service.setServiceName(rs.getString("ServiceName"));
                        service.setDescription(rs.getString("ServiceDescription"));
                        appointment.setService(service);
                        
                        record.setAppointment(appointment);
                    }

                    record.setPet(pet);
                    record.setDoctor(doctor);

                    return record;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
