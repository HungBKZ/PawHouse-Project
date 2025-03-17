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
        String query = "SELECT TOP 1 a.*, p.PetName, p.Species, p.Breed, p.Age, p.Gender, p.PetImage, "
                + "p.AdoptionStatus, p.UserID, p.InUseService, pc.CategoryName "
                + "FROM Appointments a "
                + "INNER JOIN Pets p ON a.PetID = p.PetID "
                + "INNER JOIN PetCategories pc ON p.CategoryID = pc.CategoryID "
                + "WHERE a.PetID = ? "
                + "ORDER BY a.AppointmentDate DESC";

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
                        rs.getTimestamp("AppointmentDate"),
                        rs.getTimestamp("BookingDate"),
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
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, "
                + "c.FullName AS CustomerName, c.Username AS CustomerUsername, "
                + "s.FullName AS StaffName, d.FullName AS DoctorName, "
                + "p.PetName, p.UserID, u.Username AS OwnerUsername, "
                + "svc.ServiceName, svc.Price "
                + "FROM Appointments a "
                + "JOIN Users c ON a.CustomerID = c.UserID "
                + "LEFT JOIN Users s ON a.StaffID = s.UserID "
                + "LEFT JOIN Users d ON a.DoctorID = d.UserID "
                + "JOIN Pets p ON a.PetID = p.PetID "
                + "LEFT JOIN Users u ON p.UserID = u.UserID " // Chủ sở hữu thú cưng
                + "JOIN Services svc ON a.ServiceID = svc.ServiceID";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Khách hàng
                User customer = new User(rs.getInt("CustomerID"), rs.getString("CustomerUsername"), rs.getString("CustomerName"));

                // Chủ sở hữu thú cưng
                User owner = rs.getInt("UserID") != 0 ? new User(rs.getInt("UserID"), rs.getString("OwnerUsername"), "") : null;

                // Nhân viên & bác sĩ
                User staff = rs.getInt("StaffID") != 0 ? new User(rs.getInt("StaffID"), rs.getString("StaffName"), "") : null;
                User doctor = rs.getInt("DoctorID") != 0 ? new User(rs.getInt("DoctorID"), rs.getString("DoctorName"), "") : null;

                // Thông tin thú cưng
                Pet pet = new Pet(rs.getInt("PetID"), rs.getString("PetName"), owner);

                // Dịch vụ
                Service service = new Service(rs.getInt("ServiceID"), rs.getString("ServiceName"), rs.getDouble("Price"));

                // Tạo đối tượng Appointment
                Appointment appointment = new Appointment(
                        rs.getInt("AppointmentID"),
                        customer, staff, doctor, pet, service,
                        rs.getTimestamp("AppointmentDate"),
                        rs.getTimestamp("BookingDate"),
                        rs.getString("AppointmentStatus"),
                        rs.getString("Notes"),
                        rs.getDouble("Price")
                );

                appointments.add(appointment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public boolean updateAppointmentStatus(int appointmentID, int status) {
        String sql = "UPDATE Appointments SET AppointmentStatus = ? WHERE AppointmentID = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, status);
            stmt.setInt(2, appointmentID);
            return stmt.executeUpdate() > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
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
