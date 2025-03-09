package DAO;

import Model.Appointment;
import Model.Pet;
import Model.PetCategories;
import Model.User;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO extends DBContext {

    public List<Appointment> getAll() {
        List<Appointment> appointmentList = new ArrayList<>();
        String query = "SELECT * FROM Appointments";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentID(rs.getInt("AppointmentID"));
                appointment.setNotes(rs.getString("Notes"));
                appointment.setPrice(rs.getDouble("Price"));

                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointmentList;
    }

    public Appointment getLatestAppointmentByPetId(int petId) {
        String query = "SELECT TOP 1 a.*, p.PetName, p.Species, p.Breed, p.Age, p.Gender, p.PetImage, " +
                      "p.AdoptionStatus, p.UserID, p.InUseService, pc.CategoryName " +
                      "FROM Appointments a " +
                      "INNER JOIN Pets p ON a.PetID = p.PetID " +
                      "INNER JOIN PetCategories pc ON p.CategoryID = pc.CategoryID " +
                      "WHERE a.PetID = ? " +
                      "ORDER BY a.AppointmentDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, petId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Pet pet = new Pet(
                    rs.getInt("PetID"),
                    new PetCategories(rs.getInt("CategoryID"), rs.getString("CategoryName"), ""),
                    rs.getString("PetName"),
                    rs.getString("Species"),
                    rs.getString("Breed"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getString("PetImage"),
                    rs.getString("AdoptionStatus"),
                    new User(rs.getInt("UserID"), null, "", "", "", "", "", "", true, ""),
                    rs.getString("InUseService")
                );

                return new Appointment(
                    rs.getInt("AppointmentID"),
                    null, // Customer (chưa lấy)
                    null, // Staff (chưa lấy)
                    null, // Doctor (chưa lấy)
                    pet,
                    null, // Service (chưa lấy)
                    rs.getDate("AppointmentDate"),
                    rs.getDate("BookingDate"),
                    rs.getString("AppointmentStatus"),
                    rs.getString("Notes"),
                    rs.getDouble("Price")
                );
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy thông tin appointment: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
