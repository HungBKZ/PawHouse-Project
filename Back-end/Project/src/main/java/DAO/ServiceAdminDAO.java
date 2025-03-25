package DAO;

import Model.ServiceAdmin;
import Model.ServiceCategories; // Đổi từ ServiceCategory sang ServiceCategories
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServiceAdminDAO {
    private final Connection conn;

    public ServiceAdminDAO(Connection conn) {
        this.conn = conn;
    }

    public List<ServiceAdmin> getAllServices() {
        return getServicesByName(null); // Gọi phương thức tìm kiếm với tên null để lấy tất cả
    }

    public List<ServiceAdmin> getServicesByName(String searchName) {
        List<ServiceAdmin> services = new ArrayList<>();
        String query = "SELECT s.*, sc.CategoryName FROM Services s " +
                       "JOIN ServiceCategories sc ON s.CategoryID = sc.CategoryID";
        if (searchName != null && !searchName.trim().isEmpty()) {
            query += " WHERE s.ServiceName LIKE ?";
        }
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            if (searchName != null && !searchName.trim().isEmpty()) {
                ps.setString(1, "%" + searchName + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ServiceAdmin service = new ServiceAdmin(
                            rs.getInt("ServiceID"),
                            rs.getInt("CategoryID"),
                            rs.getString("ServiceName"),
                            rs.getString("Description"),
                            rs.getDouble("Price"),
                            rs.getString("ServiceImage"),
                            rs.getInt("ServiceStatus")
                    );
                    service.setCategoryName(rs.getString("CategoryName")); // Thêm tên danh mục
                    services.add(service);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public List<ServiceCategories> getAllCategories() { // Đổi từ ServiceCategory sang ServiceCategories
        List<ServiceCategories> categories = new ArrayList<>();
        String query = "SELECT * FROM ServiceCategories";
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(new ServiceCategories(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getString("Description"),
                        rs.getString("Type")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public boolean addService(ServiceAdmin service) {
        String query = "INSERT INTO Services (CategoryID, ServiceName, Description, Price, ServiceImage, ServiceStatus) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, service.getCategoryID());
            ps.setString(2, service.getServiceName());
            ps.setString(3, service.getDescription());
            ps.setDouble(4, service.getPrice());
            ps.setString(5, service.getServiceImage());
            ps.setInt(6, service.getServiceStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateService(ServiceAdmin service) {
        String query = "UPDATE Services SET CategoryID = ?, ServiceName = ?, Description = ?, Price = ?, ServiceImage = ?, ServiceStatus = ? WHERE ServiceID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, service.getCategoryID());
            ps.setString(2, service.getServiceName());
            ps.setString(3, service.getDescription());
            ps.setDouble(4, service.getPrice());
            ps.setString(5, service.getServiceImage());
            ps.setInt(6, service.getServiceStatus());
            ps.setInt(7, service.getServiceID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteService(int serviceID) {
        String query = "DELETE FROM Services WHERE ServiceID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, serviceID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}