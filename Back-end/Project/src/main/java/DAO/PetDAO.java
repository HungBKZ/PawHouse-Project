/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Pet;
import Model.PetCategories;
import Model.User;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class PetDAO extends DBContext {

    public List<Pet> getAll() {
        List<Pet> petList = new ArrayList<>();
        String query = "SELECT p.*, pc.CategoryName FROM Pets p LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                
                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                pet.setCategory(category);
                
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
                pet.setInUseService(rs.getString("InUseService"));
                
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                pet.setOwner(user);
                
                petList.add(pet);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    public boolean insertPet(Pet pet) {
        String query = "INSERT INTO Pets (CategoryID, PetName, Species, Breed, Age, Gender, PetImage, AdoptionStatus, UserID, InUseService) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, pet.getCategory().getCategoryID());
            ps.setString(2, pet.getPetName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setInt(5, pet.getAge());
            ps.setString(6, pet.getGender());
            ps.setString(7, pet.getPetImage());
            ps.setString(8, pet.getAdoptionStatus());
            ps.setInt(9, pet.getOwner().getUserID());
            ps.setString(10, pet.getInUseService() != null ? pet.getInUseService() : "N");

            int rowsInserted = ps.executeUpdate();
            ps.close();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePet(int petID) {
        String query = "DELETE FROM Pets WHERE PetID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, petID);
            int rowsDeleted = ps.executeUpdate();
            ps.close();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Pet getById(int petID) {
        Pet pet = null;
        String query = "SELECT p.*, pc.CategoryName FROM Pets p LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID WHERE p.PetID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, petID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));

                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                pet.setCategory(category);

                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
                pet.setInUseService(rs.getString("InUseService"));

                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                pet.setOwner(user);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pet;
    }

    public boolean updatePet(Pet pet) {
        String query = "UPDATE Pets SET CategoryID=?, PetName=?, Species=?, Breed=?, Age=?, Gender=?, PetImage=?, AdoptionStatus=?, UserID=?, InUseService=? WHERE PetID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, pet.getCategory().getCategoryID());
            ps.setString(2, pet.getPetName());
            ps.setString(3, pet.getSpecies());
            ps.setString(4, pet.getBreed());
            ps.setInt(5, pet.getAge());
            ps.setString(6, pet.getGender());
            ps.setString(7, pet.getPetImage());
            ps.setString(8, pet.getAdoptionStatus());
            ps.setInt(9, pet.getOwner().getUserID());
            ps.setString(10, pet.getInUseService() != null ? pet.getInUseService() : "N");
            ps.setInt(11, pet.getPetID());
            
            int rowsUpdated = ps.executeUpdate();
            ps.close();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Pet> searchPetByName(String petName) {
        List<Pet> petList = new ArrayList<>();
        String query = "SELECT p.*, pc.CategoryName FROM Pets p LEFT JOIN PetCategories pc ON p.CategoryID = pc.CategoryID WHERE p.PetName LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + petName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));

                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                pet.setCategory(category);

                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
                pet.setInUseService(rs.getString("InUseService"));

                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                pet.setOwner(user);

                petList.add(pet);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    public List<Pet> getPetsByUserId(int userId) {
        List<Pet> pets = new ArrayList<>();
        String query = "SELECT * FROM Pets WHERE UserID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pet pet = new Pet(
                        rs.getInt("PetID"),
                        new PetCategories(rs.getInt("CategoryID"), "", ""),
                        rs.getString("PetName"),
                        rs.getString("Species"),
                        rs.getString("Breed"),
                        rs.getInt("Age"),
                        rs.getString("Gender"),
                        rs.getString("PetImage"),
                        rs.getString("AdoptionStatus"),
                        new User(rs.getInt("UserID"), null, "", "", "", "", "", "", false, ""),
                        rs.getString("InUseService")
                );
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }
    
   public List<Pet> getAllPetsForAdoption() {
    List<Pet> pets = new ArrayList<>();
    String query = "SELECT * FROM Pets"; // Lấy tất cả thú cưng, không giới hạn trạng thái

    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            pets.add(new Pet(
                rs.getInt("PetID"),
                new PetCategories(rs.getInt("CategoryID"), "", ""),
                rs.getString("PetName"),
                rs.getString("Species"),
                rs.getString("Breed"),
                rs.getInt("Age"),
                rs.getString("Gender"),
                rs.getString("PetImage"),
                rs.getString("AdoptionStatus"),
                null,
                rs.getString("InUseService")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return pets;
}

}
