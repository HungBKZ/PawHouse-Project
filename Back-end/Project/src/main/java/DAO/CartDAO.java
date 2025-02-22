/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Cart;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class CartDAO extends DBContext {

    public List<Cart> getAll() {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT * FROM Cart";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("CartID"));
                cart.setQuantity(rs.getInt("Quantity"));
                cart.setAddedDate(rs.getDate("AddedDate"));
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }
}
