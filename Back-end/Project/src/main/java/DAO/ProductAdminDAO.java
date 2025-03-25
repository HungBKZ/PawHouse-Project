package DAO;

import Model.ProductAdmin;
import Utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductAdminDAO {

    public List<ProductAdmin> getAllProducts() {
        List<ProductAdmin> productList = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductAdmin product = new ProductAdmin(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("ProductImage"),
                        rs.getInt("ProductStatus"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<ProductAdmin> searchProductsByName(String searchTerm) {
        List<ProductAdmin> productList = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE ProductName LIKE ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductAdmin product = new ProductAdmin(
                        rs.getInt("ProductID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("ProductImage"),
                        rs.getInt("ProductStatus"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public boolean deleteProduct(int productID) {
        String query = "DELETE FROM Products WHERE ProductID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, productID);
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                return true;
            } else {
                System.out.println("Xóa thất bại! Không có sản phẩm nào với ID: " + productID);
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void addProduct(ProductAdmin product) {
        String query = "INSERT INTO Products (CategoryID, ProductName, Description, Price, Stock, ProductImage, ProductStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, product.getCategoryID());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getProductImage());
            ps.setInt(7, product.getProductStatus());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(ProductAdmin product) {
        String query = "UPDATE Products SET CategoryID = ?, ProductName = ?, Description = ?, Price = ?, Stock = ?, ProductImage = ?, ProductStatus = ? WHERE ProductID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, product.getCategoryID());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getProductImage());
            ps.setInt(7, product.getProductStatus());
            ps.setInt(8, product.getProductID());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}