package DAO;

import Model.Service;
import Model.ServiceCategories;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

                // Liên kết với ServiceCategories
                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(category);

                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceImage(rs.getString("ServiceImage"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));

                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return serviceList;
    }
     
     public List<Service> getServiceByType(String type) {
        List<Service> serviceList = new ArrayList<>();
        String query = "SELECT s.*, sc.CategoryID, sc.CategoryName, sc.Type "
                     + "FROM Services s "
                     + "JOIN ServiceCategories sc ON s.CategoryID = sc.CategoryID "
                     + "WHERE sc.Type = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));

                // Liên kết với ServiceCategories
                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setType(rs.getString("Type"));
                service.setCategory(category);

                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceImage(rs.getString("ServiceImage"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));

                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return serviceList;
    }
     
     public Service getServiceByID(int id) {
        Service service = null;
        String query = "SELECT s.*, sc.CategoryID, sc.CategoryName, sc.Type "
                     + "FROM Services s "
                     + "JOIN ServiceCategories sc ON s.CategoryID = sc.CategoryID "
                     + "WHERE s.ServiceID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));

                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setType(rs.getString("Type"));
                service.setCategory(category);

                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceImage(rs.getString("ServiceImage"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));

                return service;
            }
        } catch (SQLException e) {
             System.err.println("getServiceByID: " + e.getMessage());
        }

        return service;
    }
}

