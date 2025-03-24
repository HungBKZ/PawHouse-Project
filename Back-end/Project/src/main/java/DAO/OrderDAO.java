/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.OrderDetails;
import Model.Orders;
import Model.Product;
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

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("updateOrder: " + e.getMessage());
        }
        return false;
    }
    
    // Lấy danh sách đơn hàng theo UserID
    public List<Orders> getOrdersByUserId(int userId) {
        List<Orders> ordersList = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderID(rs.getInt("OrderID"));

                User user = new User();
                user.setUserID(userId);
                order.setUser(user);

                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getBoolean("OrderStatus"));
                order.setNotes(rs.getString("Notes"));

                ordersList.add(order);
            }
        } catch (SQLException e) {
            System.err.println("getOrdersByUserId: " + e.getMessage());
        }

        return ordersList;
    }

    // Lấy danh sách chi tiết đơn hàng theo OrderID
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetails> detailsList = new ArrayList<>();
        String sql = "SELECT od.OrderDetailID, od.OrderID, od.ProductID, od.Quantity, od.Price, "
                + "p.ProductName, p.ProductImage "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "WHERE od.OrderID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetails detail = new OrderDetails();
                detail.setOrderDetailID(rs.getInt("OrderDetailID"));

                Orders order = new Orders();
                order.setOrderID(rs.getInt("OrderID"));
                detail.setOrder(order);

                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setProductImage(rs.getString("ProductImage"));
                detail.setProduct(product);

                detail.setQuantity(rs.getInt("Quantity"));
                detail.setPrice(rs.getDouble("Price"));

                detailsList.add(detail);
            }
        } catch (SQLException e) {
            System.err.println("getOrderDetailsByOrderId: " + e.getMessage());
            e.printStackTrace();
        }

        return detailsList;
    }

    // Lấy toàn bộ thông tin đơn hàng + chi tiết theo UserID
    public List<Orders> getFullOrderInfoByUserId(int userId) {
        List<Orders> orders = new ArrayList<>();
        try {
            orders = getOrdersByUserId(userId);

            for (Orders order : orders) {
                System.out.println("🟢 Order ID: " + order.getOrderID());
                List<OrderDetails> details = getOrderDetailsByOrderId(order.getOrderID());
                order.setOrderDetails(details); // ❗ Phải có dòng này
            }

        } catch (Exception e) {
            System.err.println("getFullOrderInfoByUserId: " + e.getMessage());
            e.printStackTrace();
        }

        return orders;
    }

}
