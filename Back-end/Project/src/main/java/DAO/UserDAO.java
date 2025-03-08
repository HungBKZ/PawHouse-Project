/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.User;
import Model.Role;
import Utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Utils.PasswordHasher;

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
                user.setUserStatus(rs.getBoolean("UserStatus"));

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
            ps.setString(2, PasswordHasher.hashMD5(password));

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
                    user.setUserStatus(rs.getBoolean("UserStatus"));
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

    public boolean checkUserExists2(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM Users WHERE  Email = ?";

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

    public boolean registerUser(User user) throws SQLException {
        String query = "INSERT INTO Users (Username, Password, Email, FullName, Phone, UserStatus, RoleID) "
                + "VALUES (?, ?, ?, ?, ?, ?, 2)"; // RoleID 2 for regular user

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, PasswordHasher.hashMD5(user.getPassword()));
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getPhone());
            ps.setBoolean(6, user.isUserStatus());

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
        String query = "UPDATE Users SET Password = ?, ResetToken = NULL, ResetTokenExpiry = NULL "
                + "WHERE ResetToken = ? AND ResetTokenExpiry > GETDATE()";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, PasswordHasher.hashMD5(newPassword));
            ps.setString(2, token);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updatePasswordByEmail(String email, String newPassword) throws SQLException {
        String query = "UPDATE Users SET Password = ? WHERE Email = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, PasswordHasher.hashMD5(newPassword));
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public User getUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM Users WHERE Email = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);

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
                    user.setUserStatus(rs.getBoolean("UserStatus"));
                    return user;
                }
            }
        }
        return null;
    }

    public boolean createUser(User user) throws SQLException {
        String query = "INSERT INTO Users (Username, Password, Email, FullName, Phone, Avatar, UserStatus, RoleID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // For Google users, password will be empty
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAvatar());
            ps.setBoolean(7, user.isUserStatus());
            ps.setInt(8, 2); // RoleID 2 for regular users

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean saveGoogleEmail(String email, String fullName, String picture) throws SQLException {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        // Check if email exists
        String checkQuery = "SELECT Email FROM Users WHERE Email = ?";
        try (PreparedStatement checkPs = connection.prepareStatement(checkQuery)) {
            checkPs.setString(1, email);
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    return true; // Email already exists, consider this a success
                }
            }
        }

        // If email doesn't exist, insert new user with Google email
        String insertQuery = "INSERT INTO Users (Email, Username, Password, FullName,Phone,Avatar, UserStatus, RoleID) VALUES (?, ?, ?, ?, ?, ?, 1, 2)";
        try (PreparedStatement insertPs = connection.prepareStatement(insertQuery)) {
            insertPs.setString(1, email);
            insertPs.setString(2, email); // Use email as initial username
            insertPs.setString(3, PasswordHasher.hashMD5("123456")); // Default password for Google users
            insertPs.setString(4, fullName != null ? fullName : email); // Use email as fallback if name is null
            insertPs.setString(5, "0000000000"); 
            insertPs.setString(6, email);
            int rowsAffected = insertPs.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateUserProfile(User user) throws SQLException {
        String query = "UPDATE Users SET FullName = ?, Phone = ? WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setInt(3, user.getUserID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

   public Role checkRole(int userID) throws SQLException {
    String query = "SELECT r.RoleID, r.RoleName FROM Users u " +
                   "JOIN Roles r ON u.RoleID = r.RoleID " +
                   "WHERE u.UserID = ?";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, userID);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new Role(rs.getInt("RoleID"), rs.getString("RoleName"));
            }
        }
    }
    return null;
}

    public boolean updateUserPassword(int userId, String newPassword) throws SQLException {
        String query = "UPDATE Users SET Password = ? WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, PasswordHasher.hashMD5(newPassword));
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
