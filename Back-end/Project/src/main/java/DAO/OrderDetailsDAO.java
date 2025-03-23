/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.OrderDetails;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class OrderDetailsDAO extends DBContext {

    public List<OrderDetails> getAll() {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        String query = "SELECT * FROM OrderDetails";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetails details = new OrderDetails();
                details.setOrderDetailID(rs.getInt("OrderDetailID"));
                details.setQuantity(rs.getInt("Quantity"));
                details.setPrice(rs.getDouble("Price"));
                orderDetailsList.add(details);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetailsList;
    }

    public boolean addOrderDetail(OrderDetails orderDetails) {
        String sql = "INSERT INTO [dbo].[OrderDetails]\n"
                + "           ([OrderID]\n"
                + "           ,[ProductID]\n"
                + "           ,[Quantity]\n"
                + "           ,[Price])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderDetails.getOrder().getOrderID());
            ps.setInt(2, orderDetails.getProduct().getProductID());
            ps.setInt(3, orderDetails.getQuantity());
            ps.setDouble(4, orderDetails.getPrice());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("addOrderDetail: " + e.getMessage());
        }
        return false;
    }
}
