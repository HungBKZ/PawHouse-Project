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
        String query = "SELECT * FROM Pets";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                pet.setCategory(category);
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                pet.setOwner(user);
                petList.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    // Phương thức thêm (insert) pet
    public void insertPet(Pet pet) {
        String query = "INSERT INTO Pets (CategoryID, PetName, Species, Breed, Age, Gender, PetImage, AdoptionStatus, UserID) VALUES (?,?,?,?,?,?,?,?,?)";
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
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa Pet dựa trên ID (PetID)
    public void deletePet(int petID) {
        String query = "DELETE FROM Pets WHERE PetID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, petID);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Pet getById(int petID) {
        Pet pet = null;
        String query = "SELECT * FROM Pets WHERE PetID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, petID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));

                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                pet.setCategory(category);

                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));

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

    // Phương thức cập nhật Pet theo tên
    public void updatePetByName(String petName, Pet pet) {
        String query = "UPDATE Pets SET CategoryID = ?, PetName = ?, Species = ?, Breed = ?, Age = ?, Gender = ?, PetImage = ?, AdoptionStatus = ?, UserID = ? WHERE PetName = ?";
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
            ps.setString(10, petName);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin Pet theo ID (id được truyền riêng và đối tượng pet chứa dữ liệu mới)
    public void updatePetById(int petID, Pet pet) {
        String query = "UPDATE Pets SET CategoryID=?, PetName=?, Species=?, Breed=?, Age=?, Gender=?, PetImage=?, AdoptionStatus=?, UserID=? WHERE PetID=?";
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
            ps.setInt(10, petID);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Tìm kiếm pet theo tên (PetName)
    public List<Pet> searchPetByName(String petName) {
        List<Pet> petList = new ArrayList<>();
        String query = "SELECT * FROM Pets WHERE PetName LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + petName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));

                PetCategories category = new PetCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                pet.setCategory(category);

                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setPetImage(rs.getString("PetImage"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));

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

}
