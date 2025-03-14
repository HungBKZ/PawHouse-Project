package DAO;

import Model.Appointment;
import Model.Pet;
import Model.PetCategories;
import Model.Service;
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

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointmentList = new ArrayList<>();
        String query = "SELECT a.*, " +
                      "c.UserID as CustomerID, c.Username as CustomerName, " +
                      "s.UserID as StaffID, s.Username as StaffName, " +
                      "d.UserID as DoctorID, d.Username as DoctorName, " +
                      "p.PetID, p.PetName, p.Species, p.Breed, p.Age, p.Gender, p.PetImage, " +
                      "sv.ServiceID, sv.ServiceName, sv.Description as ServiceDesc, sv.Price as ServicePrice " +
                      "FROM Appointments a " +
                      "LEFT JOIN Users c ON a.CustomerID = c.UserID " +
                      "LEFT JOIN Users s ON a.StaffID = s.UserID " +
                      "LEFT JOIN Users d ON a.DoctorID = d.UserID " +
                      "LEFT JOIN Pets p ON a.PetID = p.PetID " +
                      "LEFT JOIN Services sv ON a.ServiceID = sv.ServiceID " +
                      "ORDER BY a.AppointmentDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User customer = new User();
                customer.setUserID(rs.getInt("CustomerID"));
                customer.setUsername(rs.getString("CustomerName"));

                User staff = new User();
                staff.setUserID(rs.getInt("StaffID"));
                staff.setUsername(rs.getString("StaffName"));

                User doctor = new User();
                doctor.setUserID(rs.getInt("DoctorID"));
                doctor.setUsername(rs.getString("DoctorName"));

                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));

                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("ServiceDesc"));
                service.setPrice(rs.getDouble("ServicePrice"));

                Appointment appointment = new Appointment(
                    rs.getInt("AppointmentID"),
                    customer,
                    staff,
                    doctor,
                    pet,
                    service,
                    rs.getDate("AppointmentDate"),
                    rs.getDate("BookingDate"),
                    rs.getString("AppointmentStatus"),
                    rs.getString("Notes"),
                    rs.getDouble("Price")
                );

                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            System.out.println("Error getting appointments: " + e.getMessage());
            e.printStackTrace();
        }
        return appointmentList;
    }

    public boolean updateAppointmentStatus(int appointmentId, String status, String notes) {
        String query = "UPDATE Appointments SET AppointmentStatus = ?, Notes = ? WHERE AppointmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setInt(3, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating appointment status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAppointment(int appointmentId) {
        String query = "DELETE FROM Appointments WHERE AppointmentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting appointment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
