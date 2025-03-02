/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.ProductComment;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class ProductCommentDAO extends DBContext {

    public List<ProductComment> getAll() {
        List<ProductComment> commentList = new ArrayList<>();
        String query = "SELECT * FROM ProductComment";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductComment comment = new ProductComment();
                comment.setCommentID(rs.getInt("CommentID"));
                comment.setStar(rs.getInt("Star"));
                comment.setContent(rs.getString("Content"));
                comment.setDateComment(rs.getDate("Date_Comment"));
                comment.setProductCommentStatus(rs.getBoolean("ProductCommentStatus"));
                commentList.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }
}
