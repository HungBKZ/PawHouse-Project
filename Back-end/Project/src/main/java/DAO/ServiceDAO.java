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
            ps.setInt(2, categoryID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getDouble("Price"));
                service.setServiceStatus(rs.getBoolean("ServiceStatus"));
                ServiceCategories cat = new ServiceCategories();
                cat.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(cat);
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
                ServiceCategories cat = new ServiceCategories();
                cat.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(cat);
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
                ServiceCategories cat = new ServiceCategories();
                cat.setCategoryID(rs.getInt("CategoryID"));
                service.setCategory(cat);
                serviceList.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serviceList;
    }
}
