/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Orders;
import Model.User;
import Utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDAO {

    private Connection conn;

    public OrderDAO() throws SQLException {
        conn = DBContext.getConnection();
    }

    // Lấy danh sách đơn hàng
    public List<Orders> getAllOrders() {
        List<Orders> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            UserDAO userDAO = new UserDAO(); // Để lấy thông tin User
            while (rs.next()) {
                User user = userDAO.getUserByID(rs.getInt("UserID"));
                Orders order = new Orders();
                order.setOrderID(rs.getInt("OrderID"));
                order.setUser(user);
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getBoolean("OrderStatus"));
                order.setNotes(rs.getString("Notes"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderID, boolean status) {
        String sql = "UPDATE Orders SET OrderStatus = ? WHERE OrderID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, orderID);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("✅ Order " + orderID + " updated successfully to " + status);
                return true;
            } else {
                System.out.println("❌ No order updated. Check if OrderID exists or OrderStatus is already set.");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Double> getMonthlyRevenue() {
        List<Double> revenue = new ArrayList<>();
        String sql = "SELECT SUM(TotalAmount) FROM Orders WHERE MONTH(OrderDate) = ? GROUP BY MONTH(OrderDate)";

        try {
            for (int month = 1; month <= 12; month++) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, month);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    revenue.add(rs.getDouble(1));
                } else {
                    revenue.add(0.0);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenue;
    }

    public boolean addOrder(Orders orders) {
        String sql = "INSERT INTO Orders(UserID, OrderDate, OrderStatus) VALUES (?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orders.getUser().getUserID());
            ps.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
            ps.setBoolean(3, false);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("addOrder: " + e.getMessage());
        }
        return false;
    }

    public Orders getLastestOrderByUser(User user) {
        String sql = "SELECT TOP 1 * FROM Orders WHERE UserID=? ORDER BY OrderID DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getUserID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderID(rs.getInt("OrderID"));
                order.setUser(user);
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getBoolean("OrderStatus"));
                order.setNotes(rs.getString("Notes"));
                return order;
            }
        } catch (SQLException e) {
            System.err.println("getLastestOrder: " + e.getMessage());
        }
        return null;
    }

    public boolean updateOrder(Orders order) {
        String sql = "UPDATE Orders SET TotalAmount=?, OrderStatus=?, Notes=? WHERE OrderID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, order.getTotalAmount());
            ps.setBoolean(2, order.isOrderStatus());
            ps.setString(3, order.getNotes());
            ps.setInt(4, order.getOrderID());

            return ps.executeUpdate()>0;
        } catch (SQLException e) {
           System.err.println("updateOrder: " + e.getMessage());
        }
        return false;
    }
}
