/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                product.setCategory(category);
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

    public void updateProductStock(int productId, int newStock) {
        String query = "UPDATE Products SET Stock = ? WHERE ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, newStock);
            ps.setInt(2, productId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✔ Cập nhật stock thành công: " + newStock);
            } else {
                System.out.println("❌ Lỗi: Không thể cập nhật stock!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getProductsByCategory(int categoryID) {
        List<Product> productListByCategory = new ArrayList<>();
        String query = "SELECT p.*, c.CategoryName FROM Products p "
                + "INNER JOIN ProductCategories c ON p.CategoryID = c.CategoryID "
                + "WHERE p.CategoryID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));

                // Tạo đối tượng ProductCategories và gán cho sản phẩm
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                product.setCategory(category);

                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));

                productListByCategory.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error in getProductsByCategory: " + e.getMessage());
            e.printStackTrace();
        }

        return productListByCategory;
    }
// Lấy danh sách sản phẩm sắp xếp theo giá tăng dần (từ bé đến lớn)

    public List<Product> getProductsSortedByPriceAsc() {
        List<Product> productListAsc = new ArrayList<>();
        String query = "SELECT * FROM Products ORDER BY Price ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                product.setCategory(category);
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                // Nếu cần, khởi tạo và set ProductCategories cho product
                productListAsc.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productListAsc;
    }

    // Lấy danh sách sản phẩm sắp xếp theo giá giảm dần (từ lớn đến bé)
    public List<Product> getProductsSortedByPriceDesc() {
        List<Product> productListDesc = new ArrayList<>();
        String query = "SELECT * FROM Products ORDER BY Price DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                product.setCategory(category);
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                // Nếu cần, khởi tạo và set ProductCategories cho product
                productListDesc.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productListDesc;
    }

    public List<Product> searchByName(String name) {
        List<Product> productListByName = new ArrayList<>();
        String query = "SELECT * FROM Products WHERE ProductName LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                product.setCategory(category);
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                product.setProductImage(rs.getString("ProductImage"));
                productListByName.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productListByName;
    }

    // Lấy thông tin sản phẩm theo id
    public Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT * FROM Products WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                product.setCategory(category);
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Thêm sản phẩm mới
    public boolean insertProduct(Product product) {
        boolean success = false;
        String query = "INSERT INTO Products(CategoryID, ProductName, Description, Price, Stock, ProductImage, ProductStatus) VALUES(?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, product.getCategory().getCategoryID());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getProductImage());
            ps.setBoolean(7, product.isProductStatus());
            int rows = ps.executeUpdate();
            success = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(Product product) {
        boolean success = false;
        String query = "UPDATE Products SET CategoryID = ?, ProductName = ?, Description = ?, Price = ?, Stock = ?, ProductImage = ?, ProductStatus = ? WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, product.getCategory().getCategoryID());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setString(5, product.getProductImage());
            ps.setInt(6, product.getStock());
            ps.setBoolean(7, product.isProductStatus());
            ps.setInt(8, product.getProductID());
            int rows = ps.executeUpdate();
            success = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // Cập nhật sản phẩm theo ID được truyền riêng
    public boolean updateProductById(int productId, Product product) {
        boolean success = false;
        String query = "UPDATE Products SET CategoryID = ?, ProductName = ?, Description = ?, Price = ?, Stock = ?, ProductImage = ?, ProductStatus = ? WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, product.getCategory().getCategoryID());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getProductImage());
            ps.setBoolean(7, product.isProductStatus());
            ps.setInt(8, productId);
            int rows = ps.executeUpdate();
            success = rows > 0;
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    // Xóa sản phẩm (nếu cần)
    public boolean deleteProduct(int productId) {
        boolean success = false;
        String query = "DELETE FROM Products WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, productId);
            int rows = ps.executeUpdate();
            success = rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<ProductCategories> getAllCategories() {
        List<ProductCategories> categories = new ArrayList<>();
        String query = "SELECT * FROM ProductCategories";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setType(rs.getString("Type"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Product> getProductsByType(String Type) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.* FROM Products p "
                + "JOIN ProductCategories c ON p.CategoryID = c.CategoryID "
                + "WHERE c.Type = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, Type);
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

    public List<ProductCategories> getAllCategoriesByType(String type) {
        List<ProductCategories> categories = new ArrayList<>();
        String query = "SELECT * FROM ProductCategories WHERE Type = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setType(rs.getString("Type"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

}
