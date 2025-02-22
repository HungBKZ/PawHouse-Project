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
}
