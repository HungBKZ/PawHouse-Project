/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author admin
 */
import Model.AdoptionHistory;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdoptionHistoryDAO extends DBContext {
    public List<AdoptionHistory> getAll() {
        List<AdoptionHistory> adoptionList = new ArrayList<>();
        String query = "SELECT * FROM AdoptionHistory";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AdoptionHistory adoption = new AdoptionHistory();
                adoption.setAdoptionID(rs.getInt("AdoptionID"));
                adoption.setAdoptionDate(rs.getDate("AdoptionDate"));
                adoption.setAdoptionStatus(rs.getString("Status"));
                adoption.setNotes(rs.getString("Notes"));
                adoptionList.add(adoption);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return adoptionList;
    }
}
