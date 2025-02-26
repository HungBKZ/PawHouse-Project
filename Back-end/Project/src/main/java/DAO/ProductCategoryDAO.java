/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.ProductCategories;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductCategoryDAO extends DBContext {

    public List<ProductCategories> getAll() {
        List<ProductCategories> categoryList = new ArrayList<>();
        String query = "SELECT * FROM ProductCategories";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductCategories category = new ProductCategories();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));

                categoryList.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categoryList;
    }
}
