/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Service;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class ServiceDAO extends DBContext {

    public List<Service> getAll() {
        List<Service> serviceList = new ArrayList<>();
        String query = "SELECT * FROM Services";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setStatus(rs.getBoolean("ServiceStatus"));
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceList;
    }
}
