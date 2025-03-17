/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Cart;
import Model.Product;
import Model.User;
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
                cart.setAddedDate(rs.getTimestamp("AddedDate"));
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public void addToCart(Cart cart) {
        String query = "INSERT INTO Cart (UserID, ProductID, Quantity, AddedDate) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, cart.getUser().getUserID());
            ps.setInt(2, cart.getProduct().getProductID());
            ps.setInt(3, cart.getQuantity());
            ps.setTimestamp(4, cart.getAddedDate());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Sản phẩm đã được thêm vào giỏ hàng!");
            } else {
                System.out.println("Không thể thêm sản phẩm vào giỏ hàng!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Cart> getCartByUser(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT c.*, p.* FROM Cart c "
                + "JOIN Products p ON c.ProductID = p.ProductID "
                + "WHERE c.UserID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("CartID"));

                // Tạo đối tượng Product và set thông tin sản phẩm
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                cart.setProduct(product);

                cart.setQuantity(rs.getInt("Quantity"));
                cart.setAddedDate(rs.getTimestamp("AddedDate"));
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public Cart getCartByUserAndProduct(int userId, int productId) {
        String query = "SELECT * FROM Cart WHERE UserID = ? AND ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("CartID"));
                cart.setQuantity(rs.getInt("Quantity"));
                cart.setAddedDate(rs.getTimestamp("AddedDate"));
                return cart;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateCart(Cart cart) {
        String query = "UPDATE Cart SET Quantity = ? WHERE CartID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, cart.getQuantity());
            ps.setInt(2, cart.getCartID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeFromCart(int userId, int productId) throws SQLException {
        String query = "DELETE FROM Cart WHERE UserID = ? AND ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✔ Sản phẩm đã được xóa khỏi giỏ hàng!");
            } else {
                System.out.println("❌ Không tìm thấy sản phẩm trong giỏ hàng!");
            }
        }
    }

    public Cart getCartItem(int userId, int productId) {
        String query = "SELECT * FROM Cart WHERE UserID = ? AND ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("CartID"));
                cart.setQuantity(rs.getInt("Quantity"));
                cart.setAddedDate(rs.getTimestamp("AddedDate"));
                return cart;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateCartQuantity(int userId, int productId, int newQuantity) {
        String query = "UPDATE Cart SET Quantity = ? WHERE UserID = ? AND ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✔ Cập nhật số lượng sản phẩm thành công: " + newQuantity);
            } else {
                System.out.println("❌ Lỗi: Không thể cập nhật số lượng!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
