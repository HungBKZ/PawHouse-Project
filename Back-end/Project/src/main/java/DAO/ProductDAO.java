/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import Model.Product;
import Model.ProductCategories;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DBContext {

    public List<Product> getAll() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));

                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public List<Product> getProductsByCategory(int categoryID) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE CategoryID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(2, categoryID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));

                // Tạo đối tượng ProductCategories và gán cho sản phẩm
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                product.setCategory(category);

                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProdcutStatus"));

                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
// Lấy danh sách sản phẩm sắp xếp theo giá tăng dần (từ bé đến lớn)

    public List<Product> getProductsSortedByPriceAsc() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products ORDER BY Price ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                // Nếu cần, khởi tạo và set ProductCategories cho product
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy danh sách sản phẩm sắp xếp theo giá giảm dần (từ lớn đến bé)
    public List<Product> getProductsSortedByPriceDesc() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products ORDER BY Price DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                // Nếu cần, khởi tạo và set ProductCategories cho product
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
}
