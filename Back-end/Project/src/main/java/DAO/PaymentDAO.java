/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Payment;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class PaymentDAO extends DBContext {

    public List<Payment> getAll() {
        List<Payment> paymentList = new ArrayList<>();
        String query = "SELECT * FROM Payment";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setAmount(rs.getDouble("Amount"));
                payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                payment.setPaymentMethod(rs.getString("PaymentMethod"));
                payment.setPaymentStatus(rs.getBoolean("PaymentStatus"));
                paymentList.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList;
    }
}
