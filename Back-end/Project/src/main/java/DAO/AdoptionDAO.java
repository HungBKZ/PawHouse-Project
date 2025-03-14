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

    public boolean updateAdoptionStatus(int adoptionId, String status, String notes) {
        String query = "UPDATE AdoptionHistory SET AdoptionStatus = ?, Notes = ? WHERE AdoptionID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setInt(3, adoptionId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<AdoptionHistory> getPendingAdoptions() {
        List<AdoptionHistory> pendingList = new ArrayList<>();
        String query = "SELECT ah.AdoptionID, ah.PetID, ah.AdoptionDate, ah.Status, ah.Notes, " +
                "p.CategoryID, pc.CategoryName, p.PetName, p.Species, p.Breed, p.Age, p.Gender, " +
                "p.PetImage, p.AdoptionStatus, p.UserID, p.InUseService, " +
                "u.FullName as CustomerName, u.Email as CustomerEmail " +
                "FROM AdoptionHistory ah " +
                "JOIN Pets p ON ah.PetID = p.PetID " +
                "JOIN PetCategories pc ON p.CategoryID = pc.CategoryID " +
                "JOIN Users u ON p.UserID = u.UserID " +
                "WHERE ah.Status = 'Pending' ORDER BY ah.AdoptionDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
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
                    new User()
                );

                AdoptionHistory adoption = new AdoptionHistory();
                adoption.setAdoptionID(rs.getInt("AdoptionID"));
                adoption.setPet(pet);
                adoption.setAdoptionDate(rs.getDate("AdoptionDate"));
                adoption.setAdoptionStatus(rs.getString("Status"));
                adoption.setNotes(rs.getString("Notes"));
                
                // Add customer information
                User customer = new User();
                customer.setFullName(rs.getString("CustomerName"));
                customer.setEmail(rs.getString("CustomerEmail"));
                pet.setOwner(customer);
                
                pendingList.add(adoption);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendingList;
    }

    public List<AdoptionHistory> getAllAdoptions() {
        List<AdoptionHistory> adoptionList = new ArrayList<>();
        String query = "SELECT ah.AdoptionID, ah.PetID, ah.AdoptionDate, ah.AdoptionStatus as RequestStatus, ah.Notes, "
                + "p.CategoryID, pc.CategoryName, p.PetName, p.Species, p.Breed, p.Age, p.Gender, "
                + "p.PetImage, p.AdoptionStatus as PetStatus, p.UserID, p.InUseService, "
                + "u.FullName as CustomerName, u.Email as CustomerEmail, "
                + "u.Phone as CustomerPhone, u.Address as CustomerAddress "
                + "FROM AdoptionHistory ah "
                + "JOIN Pets p ON ah.PetID = p.PetID "
                + "JOIN PetCategories pc ON p.CategoryID = pc.CategoryID "
                + "LEFT JOIN Users u ON p.UserID = u.UserID "
                + "ORDER BY CASE ah.AdoptionStatus "
                + "    WHEN 'Pending' THEN 1 "
                + "    WHEN 'Approved' THEN 2 "
                + "    WHEN 'Rejected' THEN 3 "
                + "    ELSE 4 END, "
                + "ah.AdoptionDate DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo đối tượng User cho khách hàng
                User customer = new User();
                customer.setUserID(rs.getInt("UserID"));
                customer.setFullName(rs.getString("CustomerName"));
                customer.setEmail(rs.getString("CustomerEmail"));
                customer.setPhone(rs.getString("CustomerPhone"));
                customer.setAddress(rs.getString("CustomerAddress"));

                // Tạo đối tượng Pet
                Pet pet = new Pet(
                    rs.getInt("PetID"),
                    new PetCategories(rs.getInt("CategoryID"), rs.getString("CategoryName"), ""),
                    rs.getString("PetName"),
                    rs.getString("Species"),
                    rs.getString("Breed"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getString("PetImage"),
                    rs.getString("PetStatus"), // Sử dụng trạng thái từ bảng Pets
                    customer,
                    rs.getString("InUseService")
                );

                // Tạo đối tượng AdoptionHistory
                AdoptionHistory adoption = new AdoptionHistory();
                adoption.setAdoptionID(rs.getInt("AdoptionID"));
                adoption.setPet(pet);
                adoption.setAdoptionDate(rs.getDate("AdoptionDate"));
                adoption.setAdoptionStatus(rs.getString("RequestStatus")); // Sử dụng trạng thái từ bảng AdoptionHistory
                adoption.setNotes(rs.getString("Notes"));
                
                adoptionList.add(adoption);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllAdoptions: " + e.getMessage());
            e.printStackTrace();
        }
        return adoptionList;
    }

    public List<AdoptionHistory> getFilteredAdoptions(String status, String dateStr) {
        List<AdoptionHistory> adoptionList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT ah.AdoptionID, ah.PetID, ah.AdoptionDate, ah.AdoptionStatus as RequestStatus, ah.Notes, "
            + "p.CategoryID, pc.CategoryName, p.PetName, p.Species, p.Breed, p.Age, p.Gender, "
            + "p.PetImage, p.AdoptionStatus as PetStatus, p.UserID, p.InUseService, "
            + "u.FullName as CustomerName, u.Email as CustomerEmail, "
            + "u.Phone as CustomerPhone, u.Address as CustomerAddress "
            + "FROM AdoptionHistory ah "
            + "JOIN Pets p ON ah.PetID = p.PetID "
            + "JOIN PetCategories pc ON p.CategoryID = pc.CategoryID "
            + "LEFT JOIN Users u ON p.UserID = u.UserID "
            + "WHERE 1=1"
        );

        List<Object> params = new ArrayList<>();
        
        if (status != null && !status.isEmpty()) {
            query.append(" AND ah.AdoptionStatus = ?");
            params.add(status);
        }
        
        if (dateStr != null && !dateStr.isEmpty()) {
            query.append(" AND CAST(ah.AdoptionDate AS DATE) = ?");
            params.add(Date.valueOf(dateStr));
        }
        
        query.append(" ORDER BY CASE ah.AdoptionStatus "
                + "    WHEN 'Pending' THEN 1 "
                + "    WHEN 'Approved' THEN 2 "
                + "    WHEN 'Rejected' THEN 3 "
                + "    ELSE 4 END, "
                + "ah.AdoptionDate DESC");

        try {
            PreparedStatement ps = connection.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User customer = new User();
                customer.setUserID(rs.getInt("UserID"));
                customer.setFullName(rs.getString("CustomerName"));
                customer.setEmail(rs.getString("CustomerEmail"));
                customer.setPhone(rs.getString("CustomerPhone"));
                customer.setAddress(rs.getString("CustomerAddress"));

                Pet pet = new Pet(
                    rs.getInt("PetID"),
                    new PetCategories(rs.getInt("CategoryID"), rs.getString("CategoryName"), ""),
                    rs.getString("PetName"),
                    rs.getString("Species"),
                    rs.getString("Breed"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getString("PetImage"),
                    rs.getString("PetStatus"),
                    customer,
                    rs.getString("InUseService")
                );

                AdoptionHistory adoption = new AdoptionHistory();
                adoption.setAdoptionID(rs.getInt("AdoptionID"));
                adoption.setPet(pet);
                adoption.setAdoptionDate(rs.getDate("AdoptionDate"));
                adoption.setAdoptionStatus(rs.getString("RequestStatus"));
                adoption.setNotes(rs.getString("Notes"));
                
                adoptionList.add(adoption);
            }
        } catch (SQLException e) {
            System.out.println("Error in getFilteredAdoptions: " + e.getMessage());
            e.printStackTrace();
        }
        return adoptionList;
    }

    public boolean updatePetAdoptionStatus(int adoptionId, String status) {
        String query = "UPDATE Pets p " +
                      "JOIN AdoptionHistory ah ON p.PetID = ah.PetID " +
                      "SET p.AdoptionStatus = ? " +
                      "WHERE ah.AdoptionID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, adoptionId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
