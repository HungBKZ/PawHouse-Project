/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import Model.User;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public List<User> getAll() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM Users";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setFullName(rs.getString("FullName"));
                user.setPhone(rs.getString("Phone"));
                user.setAvatar(rs.getString("Avatar"));
                user.setStatus(rs.getBoolean("Status"));

                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }

    public User checkLogin(String email, String password) throws SQLException {
        String query = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setPassword(rs.getString("Password"));
                    user.setEmail(rs.getString("Email"));
                    user.setFullName(rs.getString("FullName"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAvatar(rs.getString("Avatar"));
                    user.setStatus(rs.getBoolean("Status"));
                    return user;
                }
            }
        }
        return null;
    }

    public boolean checkUserExists(String username, String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM Users WHERE Username = ? OR Email = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    public boolean registerUser(User user) throws SQLException {
        String query = "INSERT INTO Users (Username, Password, Email, FullName, Phone, Status, RoleID) " +
                      "VALUES (?, ?, ?, ?, ?, ?, 2)"; // RoleID 2 for regular user
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getPhone());
            ps.setBoolean(6, user.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    public boolean saveResetToken(String email, String token) throws SQLException {
        String query = "UPDATE Users SET ResetToken = ?, ResetTokenExpiry = DATEADD(HOUR, 24, GETDATE()) WHERE Email = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, token);
            ps.setString(2, email);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public boolean resetPassword(String token, String newPassword) throws SQLException {
        String query = "UPDATE Users SET Password = ?, ResetToken = NULL, ResetTokenExpiry = NULL " +
                      "WHERE ResetToken = ? AND ResetTokenExpiry > GETDATE()";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, newPassword);
            ps.setString(2, token);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
