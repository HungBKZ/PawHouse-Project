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
            System.out.println("Error in getAll: " + e.getMessage());
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
                        new User(rs.getInt("UserID"), null, "", "", "", "", "", "", 1, ""),
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
                try {
                    // Khách hàng
                    User customer = new User(rs.getInt("CustomerID"),
                            rs.getString("CustomerUsername"),
                            rs.getString("CustomerName"));

                    // Chủ sở hữu thú cưng
                    User owner = rs.getInt("UserID") != 0
                            ? new User(rs.getInt("UserID"),
                                    rs.getString("OwnerUsername"), "") : null;

                    // Nhân viên & bác sĩ
                    User staff = rs.getInt("StaffID") != 0
                            ? new User(rs.getInt("StaffID"),
                                    "", rs.getString("StaffName")) : null;
                    User doctor = rs.getInt("DoctorID") != 0
                            ? new User(rs.getInt("DoctorID"),
                                    "", rs.getString("DoctorName")) : null;

                    // Thông tin thú cưng
                    Pet pet = new Pet(rs.getInt("PetID"),
                            rs.getString("PetName"),
                            owner);

                    // Dịch vụ
                    Service service = new Service(rs.getInt("ServiceID"),
                            rs.getString("ServiceName"),
                            rs.getDouble("Price"));

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
                } catch (Exception e) {
                    System.out.println("Error processing appointment row: " + e.getMessage());
                    e.printStackTrace();
                    // Continue to next row instead of breaking the entire loop
                    continue;
                }
            }

        } catch (SQLException e) {
            System.out.println("Error in getAllAppointments: " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

    public List<Appointment> getAppointmentsSpa() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, "
                + "c.FullName AS CustomerName, c.Username AS CustomerUsername, "
                + "s.FullName AS StaffName, d.FullName AS DoctorName, "
                + "p.PetName, p.UserID, u.Username AS OwnerUsername, "
                + "svc.ServiceName, svc.Price, sc.Type "
                + "FROM Appointments a "
                + "JOIN Users c ON a.CustomerID = c.UserID "
                + "LEFT JOIN Users s ON a.StaffID = s.UserID "
                + "LEFT JOIN Users d ON a.DoctorID = d.UserID "
                + "JOIN Pets p ON a.PetID = p.PetID "
                + "LEFT JOIN Users u ON p.UserID = u.UserID " // Chủ sở hữu thú cưng
                + "JOIN Services svc ON a.ServiceID = svc.ServiceID "
                + "JOIN ServiceCategories sc ON svc.CategoryID = sc.CategoryID "
                + "WHERE sc.Type = 'Spa & Grooming'";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                try {
                    // Khách hàng
                    User customer = new User(rs.getInt("CustomerID"),
                            rs.getString("CustomerUsername"),
                            rs.getString("CustomerName"));

                    // Chủ sở hữu thú cưng
                    User owner = rs.getInt("UserID") != 0
                            ? new User(rs.getInt("UserID"),
                                    rs.getString("OwnerUsername"), "") : null;

                    // Nhân viên & bác sĩ
                    User staff = rs.getInt("StaffID") != 0
                            ? new User(rs.getInt("StaffID"),
                                    "", rs.getString("StaffName")) : null;
                    User doctor = rs.getInt("DoctorID") != 0
                            ? new User(rs.getInt("DoctorID"),
                                    "", rs.getString("DoctorName")) : null;

                    // Thông tin thú cưng
                    Pet pet = new Pet(rs.getInt("PetID"),
                            rs.getString("PetName"),
                            owner);

                    // Dịch vụ
                    Service service = new Service(rs.getInt("ServiceID"),
                            rs.getString("ServiceName"),
                            rs.getDouble("Price"));

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
                } catch (Exception e) {
                    System.out.println("Error processing appointment row: " + e.getMessage());
                    e.printStackTrace();
                    // Continue to next row instead of breaking the entire loop
                    continue;
                }
            }

        } catch (SQLException e) {
            System.out.println("Error in getAllAppointments: " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

    public List<Appointment> getAllAppointmentsDoctor() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*,\n"
                + "                c.FullName AS CustomerName, c.Username AS CustomerUsername,\n"
                + "                s.FullName AS StaffName, d.FullName AS DoctorName,\n"
                + "                p.PetName, p.UserID, u.Username AS OwnerUsername,\n"
                + "                svc.ServiceName, svc.Price\n"
                + "                FROM Appointments a\n"
                + "                JOIN Users c ON a.CustomerID = c.UserID \n"
                + "                LEFT JOIN Users s ON a.StaffID = s.UserID \n"
                + "                LEFT JOIN Users d ON a.DoctorID = d.UserID \n"
                + "                JOIN Pets p ON a.PetID = p.PetID\n"
                + "                LEFT JOIN Users u ON p.UserID = u.UserID\n"
                + "                JOIN Services svc ON a.ServiceID = svc.ServiceID\n"
                + "				JOIN ServiceCategories sc ON sc.CategoryID = svc.CategoryID\n"
                + "				where sc.Type = 'Thú y'";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                try {
                    // Khách hàng
                    User customer = new User(rs.getInt("CustomerID"),
                            rs.getString("CustomerUsername"),
                            rs.getString("CustomerName"));

                    // Chủ sở hữu thú cưng
                    User owner = rs.getInt("UserID") != 0
                            ? new User(rs.getInt("UserID"),
                                    rs.getString("OwnerUsername"), "") : null;

                    // Nhân viên & bác sĩ
                    User staff = rs.getInt("StaffID") != 0
                            ? new User(rs.getInt("StaffID"),
                                    "", rs.getString("StaffName")) : null;
                    User doctor = rs.getInt("DoctorID") != 0
                            ? new User(rs.getInt("DoctorID"),
                                    "", rs.getString("DoctorName")) : null;

                    // Thông tin thú cưng
                    Pet pet = new Pet(rs.getInt("PetID"),
                            rs.getString("PetName"),
                            owner);

                    // Dịch vụ
                    Service service = new Service(rs.getInt("ServiceID"),
                            rs.getString("ServiceName"),
                            rs.getDouble("Price"));

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
                } catch (Exception e) {
                    System.out.println("Error processing appointment row: " + e.getMessage());
                    e.printStackTrace();
                    // Continue to next row instead of breaking the entire loop
                    continue;
                }
            }

        } catch (SQLException e) {
            System.out.println("Error in getAllAppointments: " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

    public void addAppointment(Appointment appointment) {
        String sql = "INSERT INTO Appointments (CustomerID, StaffID, DoctorID, PetID, ServiceID, AppointmentDate, BookingDate, AppointmentStatus, Notes, Price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            // Validate required fields
            if (appointment.getCustomer() == null || appointment.getPet() == null
                    || appointment.getService() == null) {
                throw new IllegalArgumentException("Customer, Pet, and Service are required fields");
            }

            statement.setInt(1, appointment.getCustomer().getUserID());
            statement.setObject(2, appointment.getStaff() != null
                    ? appointment.getStaff().getUserID() : null);
            statement.setObject(3, appointment.getDoctor() != null
                    ? appointment.getDoctor().getUserID() : null);
            statement.setInt(4, appointment.getPet().getPetID());
            statement.setInt(5, appointment.getService().getServiceID());
            statement.setTimestamp(6, appointment.getAppointmentDate());
            statement.setTimestamp(7, appointment.getBookingDate());
            statement.setString(8, appointment.getAppointmentStatus());
            statement.setString(9, appointment.getNotes());
            statement.setDouble(10, appointment.getPrice());

            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in addAppointment: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to add appointment", e);
        }
    }

    public boolean updateAppointmentStatus(int appointmentID, String status) {
        String sql = "UPDATE Appointments SET AppointmentStatus = ? WHERE AppointmentID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setInt(2, appointmentID);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateAppointmentStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAppointmentStatus2(int appointmentID, String status, int staffId) {
        String sql = "UPDATE Appointments SET AppointmentStatus = ?, StaffID = ?   WHERE AppointmentID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            if (staffId == 0) {
                statement.setNull(2, java.sql.Types.INTEGER);
            } else {
                statement.setInt(2, staffId);
            }

            statement.setInt(3, appointmentID);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateAppointmentStatus: " + e.getMessage());
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
            System.out.println("Error in deleteAppointment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Appointment> getAppointmentsByCustomerId(int customerId) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT a.*, "
                + "       p.PetName, p.PetImage, s.ServiceName, s.Price, "
                + "       d.FullName AS DoctorName, st.FullName AS StaffName "
                + "FROM Appointments a "
                + "JOIN Pets p ON a.PetID = p.PetID "
                + "JOIN Services s ON a.ServiceID = s.ServiceID "
                + "LEFT JOIN Users d ON a.DoctorID = d.UserID "
                + "LEFT JOIN Users st ON a.StaffID = st.UserID "
                + "WHERE a.CustomerID = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Pet pet = new Pet();
            pet.setPetID(rs.getInt("PetID"));
            pet.setPetImage(rs.getNString("PetImage"));
            pet.setPetName(rs.getString("PetName"));

            Service service = new Service();
            service.setServiceID(rs.getInt("ServiceID"));
            service.setServiceName(rs.getString("ServiceName"));
            service.setPrice(rs.getDouble("Price"));

            User doctor = null;
            if (rs.getString("DoctorName") != null) {
                doctor = new User();
                doctor.setUserID(rs.getInt("DoctorID"));
                doctor.setFullName(rs.getString("DoctorName"));
            }

            User staff = null;
            if (rs.getString("StaffName") != null) {
                staff = new User();
                staff.setUserID(rs.getInt("StaffID"));
                staff.setFullName(rs.getString("StaffName"));
            }

            Appointment a = new Appointment();
            a.setAppointmentID(rs.getInt("AppointmentID"));
            a.setPet(pet);
            a.setService(service);
            a.setAppointmentDate(rs.getTimestamp("AppointmentDate"));
            a.setBookingDate(rs.getTimestamp("BookingDate"));
            a.setAppointmentStatus(rs.getString("AppointmentStatus"));
            a.setNotes(rs.getString("Notes"));
            a.setPrice(rs.getDouble("Price"));
            a.setDoctor(doctor);
            a.setStaff(staff);

            list.add(a);
        }

        return list;
    }
}
