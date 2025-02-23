/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Service;
import Model.ServiceCategories;
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
                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(category);
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceList;
    }

    // Phương thức lấy dịch vụ theo danh mục
    public List<Service> getServiceByCategory(int categoryID) {
        List<Service> serviceList = new ArrayList<>();
        String query = "SELECT * FROM Services WHERE CategoryID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));
                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(category);
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceList;
    }

    // Phương thức sắp xếp dịch vụ theo giá từ thấp đến cao
    public List<Service> getServicesSortedByPriceAsc() {
        List<Service> serviceList = new ArrayList<>();
        String query = "SELECT * FROM Services ORDER BY Price ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));
                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(category);
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceList;
    }

    // Phương thức sắp xếp dịch vụ theo giá từ cao đến thấp
    public List<Service> getServicesSortedByPriceDesc() {
        List<Service> serviceList = new ArrayList<>();
        String query = "SELECT * FROM Services ORDER BY Price DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));
                ServiceCategories category = new ServiceCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(category);
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceList;
    }

    public Service getById(int id) {
        Service service = null;
        String query = "SELECT * FROM Services WHERE ServiceID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    service = new Service();
                    service.setServiceID(rs.getInt("ServiceID"));
                    ServiceCategories category = new ServiceCategories();
                    category.setCategoryID(rs.getInt("CategoryID"));
                    service.setCategory(category);
                    service.setServiceName(rs.getString("ServiceName"));
                    service.setDescription(rs.getString("Description"));
                    service.setPrice(rs.getDouble("Price"));
                    service.setServiceImage(rs.getString("ServiceImage"));
                    service.setServiceStatus(rs.getBoolean("ServiceStatus"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return service;
    }

    public void updateService(Service service) {
        String query = "UPDATE Services SETCategoryID = ?, SETServiceName = ?, Description = ?, Price = ?, SETServiceImage = ?, ServiceStatus = ? WHERE ServiceID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, service.getCategory().getCategoryID());
            ps.setString(2, service.getServiceName());
            ps.setString(3, service.getDescription());
            ps.setDouble(4, service.getPrice());
            ps.setString(5, service.getServiceImage());
            ps.setBoolean(6, service.isServiceStatus());
            ps.setInt(7, service.getServiceID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertService(Service service) {
        String query = "INSERT INTO Services (CategoryID, ServiceName, Description, Price, ServiceImage, ServiceStatus) VALUES (?,?,?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, service.getCategory().getCategoryID());
            ps.setString(2, service.getServiceName());
            ps.setString(3, service.getDescription());
            ps.setDouble(4, service.getPrice());
            ps.setString(5, service.getServiceImage());
            ps.setBoolean(6, service.isServiceStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteService(int id) {
        String query = "DELETE FROM Services WHERE ServiceID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
