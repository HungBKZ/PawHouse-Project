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
                order.setOrderDate(rs.getDate("OrderDate"));
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

}
