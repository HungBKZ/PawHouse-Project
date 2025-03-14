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
        String query = "SELECT * FROM ProductComment";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductComment comment = new ProductComment();
                comment.setCommentID(rs.getInt("CommentID"));

                // Tạo đối tượng User
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                comment.setUser(user);

                // Tạo đối tượng Product
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                comment.setProduct(product);

                comment.setStar(rs.getInt("Star"));
                comment.setContent(rs.getString("Content"));
                comment.setDateComment(rs.getDate("Date_Comment"));
                comment.setImage(rs.getString("Image"));
                comment.setProductCommentStatus(rs.getBoolean("ProductCommentStatus"));

                commentList.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }

    public boolean addComment(ProductComment comment) {
        String query = "INSERT INTO ProductComment (UserID, ProductID, Star, Content, Date_Comment, Image, ProductCommentStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, comment.getUser().getUserID());
            ps.setInt(2, comment.getProduct().getProductID());
            ps.setInt(3, comment.getStar());
            ps.setString(4, comment.getContent());
            ps.setDate(5, comment.getDateComment());
            ps.setString(6, comment.getImage());
            ps.setBoolean(7, comment.isProductCommentStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ProductComment> getCommentsByProductId(int productId) {
        List<ProductComment> comments = new ArrayList<>();
        String query = "SELECT pc.*, u.Username, u.Avatar FROM ProductComment pc "
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
                comment.setDateComment(rs.getDate("Date_Comment"));
                comment.setProductCommentStatus(rs.getBoolean("ProductCommentStatus"));

                User user = new User();
                user.setUsername(rs.getString("Username"));
                user.setAvatar(rs.getString("Avatar"));
                comment.setUser(user);

                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}
