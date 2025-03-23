package DAO;

import Model.MedicalRecords;
import Model.Pet;
import Model.User;
import Model.Appointment;
import Utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO extends DBContext {

    public List<MedicalRecords> getAllWithPetAndDoctor() {
        List<MedicalRecords> recordList = new ArrayList<>();
        String query = 
            "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, " +
            "mr.VaccinationDetails, mr.NextVaccinationDate, " +
            "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, " +
            "p.PetID, p.PetName, u.UserID, u.FullName AS OwnerName, " +
            "d.UserID as DoctorID, d.FullName as DoctorName, " +
            "a.AppointmentID, a.AppointmentDate " +
            "FROM MedicalRecords mr " +
            "LEFT JOIN Pets p ON mr.PetID = p.PetID " +
            "LEFT JOIN Users u ON p.UserID = u.UserID " +
            "LEFT JOIN Users d ON mr.DoctorID = d.UserID " +
            "LEFT JOIN Appointments a ON mr.AppointmentID = a.AppointmentID " +
            "ORDER BY mr.RecordDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
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

                User owner = new User();
                owner.setUserID(rs.getInt("UserID"));
                owner.setFullName(rs.getString("OwnerName"));
                pet.setOwner(owner);

                User doctor = new User();
                doctor.setUserID(rs.getInt("DoctorID"));
                doctor.setFullName(rs.getString("DoctorName"));
                record.setDoctor(doctor);

                int appointmentId = rs.getInt("AppointmentID");
                if (!rs.wasNull()) {
                    Appointment appointment = new Appointment();
                    appointment.setAppointmentID(appointmentId);
                    appointment.setAppointmentDate(rs.getTimestamp("AppointmentDate"));
                    record.setAppointment(appointment);
                }

                record.setPet(pet);
                recordList.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recordList;
    }

    public MedicalRecords getById(int recordId) {
        String query = 
            "SELECT mr.RecordID, mr.Diagnosis, mr.Treatment, mr.Prescription, " +
            "mr.VaccinationDetails, mr.NextVaccinationDate, " +
            "mr.Weight, mr.Temperature, mr.Notes, mr.RecordDate, " +
            "p.PetID, p.PetName, u.UserID, u.FullName AS OwnerName, " +
            "d.UserID as DoctorID, d.FullName as DoctorName, " +
            "a.AppointmentID, a.AppointmentDate " +
            "FROM MedicalRecords mr " +
            "LEFT JOIN Pets p ON mr.PetID = p.PetID " +
            "LEFT JOIN Users u ON p.UserID = u.UserID " +
            "LEFT JOIN Users d ON mr.DoctorID = d.UserID " +
            "LEFT JOIN Appointments a ON mr.AppointmentID = a.AppointmentID " +
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

                    Pet pet = new Pet();
                    pet.setPetID(rs.getInt("PetID"));
                    pet.setPetName(rs.getString("PetName"));

                    User owner = new User();
                    owner.setUserID(rs.getInt("UserID"));
                    owner.setFullName(rs.getString("OwnerName"));
                    pet.setOwner(owner);

                    User doctor = new User();
                    doctor.setUserID(rs.getInt("DoctorID"));
                    doctor.setFullName(rs.getString("DoctorName"));
                    record.setDoctor(doctor);

                    int appointmentId = rs.getInt("AppointmentID");
                    if (!rs.wasNull()) {
                        Appointment appointment = new Appointment();
                        appointment.setAppointmentID(appointmentId);
                        appointment.setAppointmentDate(rs.getTimestamp("AppointmentDate"));
                        record.setAppointment(appointment);
                    }

                    record.setPet(pet);
                    return record;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean create(MedicalRecords record) {
        String query = "INSERT INTO MedicalRecords (PetID, DoctorID, AppointmentID, Diagnosis, Treatment, " +
                      "Prescription, VaccinationDetails, NextVaccinationDate, Weight, Temperature, Notes, RecordDate) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, record.getPet().getPetID());
            ps.setInt(2, record.getDoctor().getUserID());
            if (record.getAppointment() != null) {
                ps.setInt(3, record.getAppointment().getAppointmentID());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setString(4, record.getDiagnosis());
            ps.setString(5, record.getTreatment());
            ps.setString(6, record.getPrescription());
            ps.setString(7, record.getVaccinationDetails());
            ps.setTimestamp(8, record.getNextVaccinationDate());
            ps.setDouble(9, record.getWeight());
            ps.setDouble(10, record.getTemperature());
            ps.setString(11, record.getNotes());
            ps.setTimestamp(12, new Timestamp(System.currentTimeMillis()));
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(MedicalRecords record) {
        String query = "UPDATE MedicalRecords SET Diagnosis=?, Treatment=?, Prescription=?, " +
                      "VaccinationDetails=?, NextVaccinationDate=?, Weight=?, Temperature=?, " +
                      "Notes=? WHERE RecordID=?";
        
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

    public boolean delete(int recordId) {
        String query = "DELETE FROM MedicalRecords WHERE RecordID=?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, recordId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
