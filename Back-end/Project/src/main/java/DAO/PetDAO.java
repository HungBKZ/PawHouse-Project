/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Pet;
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
                pet.setPetName(rs.getString("PetName"));
                pet.setSpecies(rs.getString("Species"));
                pet.setBreed(rs.getString("Breed"));
                pet.setAge(rs.getInt("Age"));
                pet.setGender(rs.getString("Gender"));
                pet.setAdoptionStatus(rs.getString("AdoptionStatus"));
                petList.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }
}
