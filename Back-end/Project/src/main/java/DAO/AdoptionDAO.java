/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.AdoptionHistory;
import Model.Pet;
import Model.PetCategories;
import Model.User;
import Utils.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hungv
 */
public class AdoptionDAO extends DBContext {

    public List<AdoptionHistory> getAdoptionHistoryByPetId(int petId) {
        List<AdoptionHistory> historyList = new ArrayList<>();
        String query = "SELECT ah.AdoptionID, ah.PetID, ah.AdoptionDate, ah.Status, ah.Notes, "
                + "p.CategoryID, pc.CategoryName, p.PetName, p.Species, p.Breed, p.Age, p.Gender, "
                + "p.PetImage, p.AdoptionStatus, p.UserID, p.InUseService "
                + "FROM AdoptionHistory ah "
                + "JOIN Pets p ON ah.PetID = p.PetID "
                + "JOIN PetCategories pc ON p.CategoryID = pc.CategoryID "
                + "WHERE ah.PetID = ? ORDER BY ah.AdoptionDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, petId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo đối tượng Pet từ dữ liệu database
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

                // Tạo đối tượng AdoptionHistory với đầy đủ thông tin
                AdoptionHistory history = new AdoptionHistory(
                        rs.getInt("AdoptionID"),
                        pet,
                        rs.getDate("AdoptionDate"),
                        rs.getString("Status"),
                        rs.getString("Notes")
                );

                historyList.add(history);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }

    public void addAdoptionHistory(AdoptionHistory adoption) {
        String query = "INSERT INTO AdoptionHistory (PetID, AdoptionDate, Status, Notes) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, adoption.getPet().getPetID());
            ps.setDate(2, (Date) adoption.getAdoptionDate());
            ps.setString(3, adoption.getAdoptionStatus());
            ps.setString(4, adoption.getNotes());

            ps.executeUpdate();
            System.out.println("✅ Lịch sử nhận nuôi đã được lưu!");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("⚠️ Lỗi khi lưu lịch sử nhận nuôi: " + e.getMessage());
        }
    }
}
