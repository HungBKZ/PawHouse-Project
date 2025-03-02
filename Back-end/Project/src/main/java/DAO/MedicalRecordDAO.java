/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.MedicalRecords;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class MedicalRecordDAO extends DBContext {

    public List<MedicalRecords> getAll() {
        List<MedicalRecords> recordList = new ArrayList<>();
        String query = "SELECT * FROM MedicalRecords";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecords record = new MedicalRecords();
                record.setRecordID(rs.getInt("RecordID"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setTreatment(rs.getString("Treatment"));
                record.setPrescription(rs.getString("Prescription"));
                record.setWeight(rs.getDouble("Weight"));
                record.setTemperature(rs.getDouble("Temperature"));
                record.setNotes(rs.getString("Notes"));
                record.setRecordDate(rs.getDate("RecordDate"));
                recordList.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recordList;
    }
}
