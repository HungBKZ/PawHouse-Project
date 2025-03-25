package DAO;

import Model.ProductCategories;
import Utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductCategoriesDAO {

    public List<ProductCategories> getAllCategories() {
        List<ProductCategories> categoryList = new ArrayList<>();
        String query = "SELECT * FROM ProductCategories";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductCategories category = new ProductCategories(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getString("Description"),
                        rs.getString("Type")
                );
                categoryList.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryList;
    }
}