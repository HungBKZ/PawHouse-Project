package DAO;

import Model.*;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO extends DBContext {

    public List<MedicalRecords> getAllWithPetAndDoctor() {
        List<MedicalRecords> recordList = new ArrayList<>();
        String query = "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, mr.VaccinationDetails, mr.NextVaccinationDate, "
                + "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, "
                + "p.PetID, p.PetName, p.Species, p.Breed, p.PetImage, "
                + "u.UserID, u.FullName AS OwnerName, s.CategoryID "
                + "FROM MedicalRecords mr "
                + "LEFT JOIN Pets p ON mr.PetID = p.PetID "
                + "LEFT JOIN Users u ON p.UserID = u.UserID "
                + "LEFT JOIN Appointments a ON mr.AppointmentID = a.AppointmentID "
                + "LEFT JOIN Services s ON a.ServiceID = s.ServiceID "
                + "WHERE s.CategoryID != 8";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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

                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setPetImage(rs.getString("PetImage"));

                User owner = new User();
                owner.setUserID(rs.getInt("UserID"));
                owner.setFullName(rs.getString("OwnerName"));

                pet.setOwner(owner);
                record.setPet(pet);

                // Optional: Bạn có thể lấy CategoryID nếu cần xử lý thêm
                // int categoryId = rs.getInt("CategoryID");
                recordList.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recordList;
    }

    public List<MedicalRecords> getAllWithPetAndDoctor2() {
        List<MedicalRecords> recordList = new ArrayList<>();
        String query = "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, mr.VaccinationDetails, mr.NextVaccinationDate, "
                + "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, "
                + "p.PetID, p.PetName, p.Species, p.Breed, p.PetImage, "
                + "u.UserID, u.FullName AS OwnerName, s.CategoryID "
                + "FROM MedicalRecords mr "
                + "LEFT JOIN Pets p ON mr.PetID = p.PetID "
                + "LEFT JOIN Users u ON p.UserID = u.UserID "
                + "LEFT JOIN Appointments a ON mr.AppointmentID = a.AppointmentID "
                + "LEFT JOIN Services s ON a.ServiceID = s.ServiceID "
                + "WHERE s.CategoryID = 8";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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

                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setPetImage(rs.getString("PetImage"));

                User owner = new User();
                owner.setUserID(rs.getInt("UserID"));
                owner.setFullName(rs.getString("OwnerName"));

                pet.setOwner(owner);
                record.setPet(pet);

                // Optional: Bạn có thể lấy CategoryID nếu cần xử lý thêm
                // int categoryId = rs.getInt("CategoryID");
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

    public MedicalRecords getRecordById(int recordId) {
        String query
                = "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, "
                + "mr.VaccinationDetails, mr.NextVaccinationDate, "
                + "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, "
                + "p.PetID, p.PetName, p.Species, p.Breed, p.Age, p.Gender, p.PetImage, "
                + "pc.CategoryName, "
                + "u.UserID, u.FullName AS OwnerName, u.Email AS OwnerEmail, u.Phone AS OwnerPhone, "
                + "d.UserID AS DoctorID, d.FullName AS DoctorName, d.Email AS DoctorEmail, "
                + "a.AppointmentID, a.AppointmentDate, a.BookingDate, a.AppointmentStatus, a.Notes AS AppointmentNotes, "
                + "s.ServiceID, s.ServiceName, s.Description AS ServiceDescription "
                + "FROM MedicalRecords mr "
                + "LEFT JOIN Pets p ON mr.PetID = p.PetID "
                + "LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID "
                + "LEFT JOIN Users u ON p.UserID = u.UserID "
                + "LEFT JOIN Users d ON mr.DoctorID = d.UserID "
                + "LEFT JOIN Appointments a ON mr.AppointmentID = a.AppointmentID "
                + "LEFT JOIN Services s ON a.ServiceID = s.ServiceID "
                + "WHERE mr.RecordID = ?";

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

    public boolean addMedicalRecord(MedicalRecords record) {
        String query = "INSERT INTO MedicalRecords (PetID, DoctorID, AppointmentID, Diagnosis, Treatment, "
                + "Prescription, Weight, Temperature, Notes, RecordDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, record.getPet().getPetID());
            ps.setInt(2, record.getDoctor().getUserID());
            ps.setInt(3, record.getAppointment().getAppointmentID());
            ps.setString(4, record.getDiagnosis());
            ps.setString(5, record.getTreatment());
            ps.setString(6, record.getPrescription());
            ps.setDouble(7, record.getWeight());
            ps.setDouble(8, record.getTemperature());
            ps.setString(9, record.getNotes());
            ps.setTimestamp(10, record.getRecordDate());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean addVacxin(MedicalRecords record) {
        String query = "INSERT INTO MedicalRecords (PetID, DoctorID, AppointmentID, Diagnosis, VaccinationDetails, "
                + "NextVaccinationDate, Weight, Temperature, Notes, RecordDate) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, record.getPet().getPetID());
            ps.setInt(2, record.getDoctor().getUserID());
            ps.setInt(3, record.getAppointment().getAppointmentID());
            ps.setString(4, record.getDiagnosis());
            ps.setString(5, record.getVaccinationDetails());
            ps.setTimestamp(6, record.getNextVaccinationDate());
            ps.setDouble(7, record.getWeight());
            ps.setDouble(8, record.getTemperature());
            ps.setString(9, record.getNotes());
            ps.setTimestamp(10, record.getRecordDate());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateMedicalRecord(MedicalRecords record) {
        String query = "UPDATE MedicalRecords SET Diagnosis = ?, Treatment = ?, Prescription = ?, "
                + "Weight = ?, Temperature = ?, Notes = ? WHERE RecordID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, record.getDiagnosis());
            ps.setString(2, record.getTreatment());
            ps.setString(3, record.getPrescription());
            ps.setDouble(4, record.getWeight());
            ps.setDouble(5, record.getTemperature());
            ps.setString(6, record.getNotes());
            ps.setInt(7, record.getRecordID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMedicalRecord(int recordId) {
        String query = "DELETE FROM MedicalRecords WHERE RecordID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, recordId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateMedicalRecord2(MedicalRecords record) {
    String query = "UPDATE MedicalRecords SET Diagnosis = ?, Treatment = ?, Prescription = ?, "
                 + "VaccinationDetails = ?, NextVaccinationDate = ?, "
                 + "Weight = ?, Temperature = ?, Notes = ? "
                 + "WHERE RecordID = ?";

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, record.getDiagnosis());
        ps.setString(2, record.getTreatment());
        ps.setString(3, record.getPrescription());
        ps.setString(4, record.getVaccinationDetails());
        ps.setTimestamp(5, record.getNextVaccinationDate());
        ps.setDouble(6, record.getWeight());
        ps.setDouble(7, record.getTemperature());
        ps.setString(8, record.getNotes());
        ps.setInt(9, record.getRecordID());

        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

}
