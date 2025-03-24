package DAO;

import Model.AdminPet;
import Utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminPetDAO {

    public List<AdminPet> getAllPets() {
        List<AdminPet> pets = new ArrayList<>();
        String query = "SELECT * FROM Pets";
        try (Connection conn = DBContext.getConnection()) {
            if (conn == null) {
                System.err.println("\u274C Không kết nối được database");
                return pets;
            }
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pets.add(new AdminPet(
                    rs.getInt("PetID"),
                    rs.getInt("CategoryID"),
                    rs.getString("PetName"),
                    rs.getString("Species"),
                    rs.getString("Breed"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getString("PetImage"),
                    rs.getString("AdoptionStatus"),
                    rs.getObject("UserID") != null ? rs.getInt("UserID") : null, // Xử lý NULL
                    rs.getString("InUseService")
                ));
            }
        } catch (SQLException e) {
            System.err.println("\u274C Lỗi SQL khi lấy danh sách thú cưng: " + e.getMessage());
            e.printStackTrace();
        }
        return pets;
    }

    public AdminPet getPetById(int petID) {
        String query = "SELECT * FROM Pets WHERE PetID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, petID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new AdminPet(
                    rs.getInt("PetID"),
                    rs.getInt("CategoryID"),
                    rs.getString("PetName"),
                    rs.getString("Species"),
                    rs.getString("Breed"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getString("PetImage"),
                    rs.getString("AdoptionStatus"),
                    rs.getObject("UserID") != null ? rs.getInt("UserID") : null, // Xử lý NULL
                    rs.getString("InUseService")
                );
            }
        } catch (SQLException e) {
            System.err.println("\u274C Lỗi SQL khi lấy thú cưng theo ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public void addPet(AdminPet pet) {
        if (("Chưa nhận nuôi".equals(pet.getAdoptionStatus()) || "Đang chờ duyệt".equals(pet.getAdoptionStatus())) && pet.getUserID() != null) {
            throw new IllegalArgumentException("UserID phải là null khi trạng thái là 'Chưa nhận nuôi' hoặc 'Đang chờ duyệt'");
        }
        String query = "INSERT INTO Pets (CategoryID, PetName, Species, Breed, Age, Gender, PetImage, AdoptionStatus, UserID, InUseService) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, pet.getCategoryID());
            ps.setString(2, pet.getPetName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setInt(5, pet.getAge());
            ps.setString(6, pet.getGender());
            ps.setString(7, pet.getPetImage());
            ps.setString(8, pet.getAdoptionStatus());
            if (pet.getUserID() != null) {
                ps.setInt(9, pet.getUserID());
            } else {
                ps.setNull(9, Types.INTEGER); // Gán NULL nếu userID là null
            }
            ps.setString(10, pet.getInUseService());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Không thể thêm thú cưng vào database.");
            }
        } catch (SQLException e) {
            System.err.println("\u274C Lỗi SQL khi thêm thú cưng: " + e.getMessage());
            throw new RuntimeException("Không thể thêm thú cưng: " + e.getMessage(), e);
        }
    }

    public void updatePet(AdminPet pet) {
        if (("Chưa nhận nuôi".equals(pet.getAdoptionStatus()) || "Đang chờ duyệt".equals(pet.getAdoptionStatus())) && pet.getUserID() != null) {
            throw new IllegalArgumentException("UserID phải là null khi trạng thái là 'Chưa nhận nuôi' hoặc 'Đang chờ duyệt'");
        }
        String query = "UPDATE Pets SET CategoryID = ?, PetName = ?, Species = ?, Breed = ?, Age = ?, " +
                      "Gender = ?, PetImage = ?, AdoptionStatus = ?, UserID = ?, InUseService = ? WHERE PetID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, pet.getCategoryID());
            ps.setString(2, pet.getPetName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setInt(5, pet.getAge());
            ps.setString(6, pet.getGender());
            ps.setString(7, pet.getPetImage());
            ps.setString(8, pet.getAdoptionStatus());
            if (pet.getUserID() != null) {
                ps.setInt(9, pet.getUserID());
            } else {
                ps.setNull(9, Types.INTEGER); // Gán NULL nếu userID là null
            }
            ps.setString(10, pet.getInUseService());
            ps.setInt(11, pet.getPetID());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Không thể cập nhật thú cưng, PetID không tồn tại.");
            }
        } catch (SQLException e) {
            System.err.println("\u274C Lỗi SQL khi cập nhật thú cưng: " + e.getMessage());
            throw new RuntimeException("Không thể cập nhật thú cưng: " + e.getMessage(), e);
        }
    }

    public boolean deletePet(int petID) {
        String checkAdoptionQuery = "SELECT COUNT(*) as count FROM AdoptionHistory WHERE PetID = ?";
        String checkMedicalQuery = "SELECT COUNT(*) as count FROM MedicalRecords WHERE PetID = ?";
        String deletePetQuery = "DELETE FROM Pets WHERE PetID = ?";
        
        try (Connection conn = DBContext.getConnection()) {
            PreparedStatement psAdoption = conn.prepareStatement(checkAdoptionQuery);
            psAdoption.setInt(1, petID);
            ResultSet rsAdoption = psAdoption.executeQuery();
            if (rsAdoption.next() && rsAdoption.getInt("count") > 0) {
                System.err.println("\u274C Không thể xóa vì PetID: " + petID + ".vì pet này đang sử dụng dịch vụ hoặc đã được nhận nuôi");
                return false;
            }

            PreparedStatement psMedical = conn.prepareStatement(checkMedicalQuery);
            psMedical.setInt(1, petID);
            ResultSet rsMedical = psMedical.executeQuery();
            if (rsMedical.next() && rsMedical.getInt("count") > 0) {
                System.err.println("\u274C Không thể xóa vì PetID: " + petID + " vì pet này đang sử dụng dịch vụ y tế");
                return false;
            }

            PreparedStatement ps = conn.prepareStatement(deletePetQuery);
            ps.setInt(1, petID);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                System.err.println("\u274C Không tìm thấy PetID: " + petID + " để xóa.");
                return false;
            }
            System.out.println("\u2705 Đã xóa thú cưng với PetID: " + petID);
            return true;
        } catch (SQLException e) {
            System.err.println("\u274C Lỗi SQL khi xóa thú cưng: " + e.getMessage());
            throw new RuntimeException("Không thể xóa thú cưng vì có dữ liệu liên quan trong các bảng khác.", e);
        }
    }

    public void deleteAdoptionHistory(int petID) {
        String query = "DELETE FROM AdoptionHistory WHERE PetID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, petID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("\u274C Lỗi SQL khi xóa lịch sử nhận nuôi: " + e.getMessage());
            throw new RuntimeException("Không thể xóa lịch sử nhận nuôi: " + e.getMessage(), e);
        }
    }

    public void deleteAppointments(int petID) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            
            String findAppointmentsQuery = "SELECT a.AppointmentID FROM Appointments a WHERE a.PetID = ?";
            List<Integer> appointmentIds = new ArrayList<>();
            
            try (PreparedStatement psFind = conn.prepareStatement(findAppointmentsQuery)) {
                psFind.setInt(1, petID);
                ResultSet rs = psFind.executeQuery();
                while (rs.next()) {
                    appointmentIds.add(rs.getInt("AppointmentID"));
                }
            }
            
            if (!appointmentIds.isEmpty()) {
                String deletePaymentsQuery = "DELETE FROM Payment WHERE AppointmentID IN (SELECT AppointmentID FROM Appointments WHERE PetID = ?)";
                try (PreparedStatement psPayment = conn.prepareStatement(deletePaymentsQuery)) {
                    psPayment.setInt(1, petID);
                    psPayment.executeUpdate();
                }
            }
            
            String deleteAppointmentsQuery = "DELETE FROM Appointments WHERE PetID = ?";
            try (PreparedStatement psAppointment = conn.prepareStatement(deleteAppointmentsQuery)) {
                psAppointment.setInt(1, petID);
                psAppointment.executeUpdate();
            }
            
            conn.commit();
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    System.err.println("\u274C Lỗi khi rollback: " + rollbackEx.getMessage());
                }
            }
            System.err.println("\u274C Lỗi SQL khi xóa lịch hẹn và thanh toán: " + e.getMessage());
            throw new RuntimeException("Không thể xóa lịch hẹn và thanh toán: " + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    System.err.println("\u274C Lỗi khi đóng kết nối: " + closeEx.getMessage());
                }
            }
        }
    }
}