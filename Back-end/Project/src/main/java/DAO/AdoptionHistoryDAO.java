package DAO;

import Model.AdoptionHistory;
import Model.Pet;
import Utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdoptionHistoryDAO extends DBContext {

    /**
     * Lấy toàn bộ lịch sử nhận nuôi từ database.
     */
    public List<AdoptionHistory> getAll() {
        List<AdoptionHistory> adoptionList = new ArrayList<>();
        String query = "SELECT AdoptionID, PetID, AdoptionDate, AdoptionStatus, Notes FROM AdoptionHistory";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                AdoptionHistory adoption = new AdoptionHistory();
                adoption.setAdoptionID(rs.getInt("AdoptionID"));
                adoption.setAdoptionDate(rs.getDate("AdoptionDate"));
                adoption.setAdoptionStatus(rs.getString("AdoptionStatus")); // ✅ Fix lỗi tên cột
                adoption.setNotes(rs.getString("Notes"));
                
                adoptionList.add(adoption);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy dữ liệu lịch sử nhận nuôi: " + e.getMessage());
        }
        return adoptionList;
    }

    /**
     * Cập nhật trạng thái nhận nuôi (được duyệt hoặc từ chối).
     * Nếu được duyệt, cập nhật trạng thái nhận nuôi của thú cưng.
     */
    public boolean updateAdoptionStatus(int adoptionID, String status) {
        String updateAdoptionQuery = "UPDATE AdoptionHistory SET AdoptionStatus = ? WHERE AdoptionID = ?";
        String updatePetQuery = "UPDATE Pets SET AdoptionStatus = 'Adopted' WHERE PetID = (SELECT PetID FROM AdoptionHistory WHERE AdoptionID = ?)";

        Connection conn = null;
        PreparedStatement psAdoption = null;
        PreparedStatement psPet = null;

        try {
            conn = connection;
            conn.setAutoCommit(false); // ✅ Bắt đầu transaction

            // Cập nhật trạng thái nhận nuôi trong AdoptionHistory
            psAdoption = conn.prepareStatement(updateAdoptionQuery);
            psAdoption.setString(1, status);
            psAdoption.setInt(2, adoptionID);
            int adoptionUpdated = psAdoption.executeUpdate();

            // Nếu cập nhật thành công và status = "Accepted" → cập nhật trạng thái pet
            if (adoptionUpdated > 0 && "Accepted".equalsIgnoreCase(status)) {
                psPet = conn.prepareStatement(updatePetQuery);
                psPet.setInt(1, adoptionID);
                psPet.executeUpdate();
            }

            conn.commit(); // ✅ Commit nếu cả hai đều thành công
            return true;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi cập nhật trạng thái nhận nuôi: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback(); // ❌ Rollback nếu lỗi xảy ra
                } catch (SQLException rollbackEx) {
                    System.err.println("❌ Rollback thất bại: " + rollbackEx.getMessage());
                }
            }
            return false;
        } finally {
            try {
                if (psAdoption != null) psAdoption.close();
                if (psPet != null) psPet.close();
                if (conn != null) conn.setAutoCommit(true); // ✅ Reset AutoCommit về trạng thái bình thường
            } catch (SQLException e) {
                System.err.println("❌ Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }
    
    public void updatePetAdoptionStatus(int adoptionID) {
    String query = "UPDATE Pets SET AdoptionStatus = 'Adopted' " +
                   "WHERE PetID = (SELECT PetID FROM AdoptionHistory WHERE AdoptionID = ?)";
    try {
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setInt(1, adoptionID);
        ps.executeUpdate();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    
}
