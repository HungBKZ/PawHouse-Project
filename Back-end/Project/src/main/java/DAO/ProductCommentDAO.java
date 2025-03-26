package DAO;

import Model.ProductComment;
import Model.Product;
import Model.User;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductCommentDAO extends DBContext {

    public List<ProductComment> getAllComments() {
        List<ProductComment> commentList = new ArrayList<>();
        String query = "SELECT pc.*, p.ProductName, p.ProductImage, p.Price, p.Stock, p.ProductStatus as PStatus, "
                + "u.UserID, u.Username, u.Email, u.FullName, u.Phone, u.Avatar, u.UserStatus "
                + "FROM ProductComment pc "
                + "JOIN Products p ON pc.ProductID = p.ProductID "
                + "JOIN Users u ON pc.UserID = u.UserID "
                + "ORDER BY pc.Date_Comment DESC";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductComment comment = new ProductComment();
                comment.setCommentID(rs.getInt("CommentID"));
                comment.setStar(rs.getInt("Star"));
                comment.setContent(rs.getString("Content"));
                comment.setDateComment(rs.getTimestamp("Date_Comment"));
                comment.setImage(rs.getString("Image"));
                comment.setProductCommentStatus(rs.getBoolean("ProductCommentStatus"));

                // Set User details
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username")); // Giữ lại để tương thích
                user.setEmail(rs.getString("Email"));
                user.setFullName(rs.getString("FullName")); // Đảm bảo lấy FullName
                user.setPhone(rs.getString("Phone"));
                user.setAvatar(rs.getString("Avatar"));
                user.setUserStatus(rs.getInt("UserStatus")); // Đúng với kiểu int trong User.java
                comment.setUser(user);

                // Set Product details
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setProductStatus(rs.getBoolean("PStatus"));
                comment.setProduct(product);

                commentList.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }

    public boolean addComment(ProductComment comment) {
        String query = "INSERT INTO ProductComment (UserID, ProductID, Star, Content, Date_Comment, Image, ProductCommentStatus) VALUES (?, ?, ?, ?, ?, ?, 1)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, comment.getUser().getUserID());
            ps.setInt(2, comment.getProduct().getProductID());
            ps.setInt(3, comment.getStar());
            ps.setString(4, comment.getContent());
            ps.setTimestamp(5, comment.getDateComment());
            ps.setString(6, comment.getImage());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ProductComment> getCommentsByProductId(int productId) {
        List<ProductComment> comments = new ArrayList<>();
        String query = "SELECT pc.*, u.UserID, u.Username, u.FullName, u.Avatar " + // Thêm FullName vào đây để tương thích
                "FROM ProductComment pc "
                + "JOIN Users u ON pc.UserID = u.UserID "
                + "WHERE pc.ProductID = ? AND pc.ProductCommentStatus = 1 "
                + "ORDER BY pc.Date_Comment DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductComment comment = new ProductComment();
                comment.setCommentID(rs.getInt("CommentID"));
                comment.setStar(rs.getInt("Star"));
                comment.setContent(rs.getString("Content"));
                comment.setDateComment(rs.getTimestamp("Date_Comment"));
                comment.setImage(rs.getString("Image"));
                comment.setProductCommentStatus(rs.getBoolean("ProductCommentStatus"));

                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setFullName(rs.getString("FullName")); // Thêm FullName
                user.setAvatar(rs.getString("Avatar"));
                comment.setUser(user);

                Product product = new Product();
                product.setProductID(productId);
                comment.setProduct(product);

                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public boolean toggleCommentStatus(int commentId) {
        String query = "UPDATE ProductComment SET ProductCommentStatus = CASE WHEN ProductCommentStatus = 1 THEN 0 ELSE 1 END WHERE CommentID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, commentId);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean softDeleteComment(int commentId) {
        String query = "UPDATE ProductComment SET ProductCommentStatus = 0 WHERE CommentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, commentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateComment(int commentId, String content, int star, String image) {
        // Input validation based on memory requirements
        if (star < 1 || star > 5) {
            return false;
        }
        if (content == null || content.trim().isEmpty()) {
            return false;
        }
        if (image != null && !image.isEmpty()) {
            String lowerImage = image.toLowerCase();
            if (!lowerImage.endsWith(".jpg") && !lowerImage.endsWith(".jpeg") && 
                !lowerImage.endsWith(".png") && !lowerImage.endsWith(".gif") && 
                !lowerImage.endsWith(".webp")) {
                image += ".jpg"; // Fallback to jpg if no extension
            }
        }

        String query = "UPDATE ProductComment SET Content = ?, Star = ?, Image = ? WHERE CommentID = ? AND ProductCommentStatus = 1";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, content);
            ps.setInt(2, star);
            ps.setString(3, image);
            ps.setInt(4, commentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteComment(int commentId) {
        String query = "DELETE FROM ProductComment WHERE CommentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, commentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}