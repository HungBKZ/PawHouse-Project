package DAO;

import Model.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Utils.DBContext;

public class AccountDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public AccountDAO() {
        try {
            conn = DBContext.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🟢 Lấy danh sách tất cả tài khoản từ database
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT UserID, RoleID, Username, Email, UserStatus FROM Users";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                accounts.add(new Account(
                    rs.getInt("UserID"),
                    rs.getInt("RoleID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getBoolean("UserStatus")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accounts;
    }

    // 🟢 Tìm kiếm tài khoản theo Username
    public List<Account> searchAccountsByUsername(String username) {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT UserID, RoleID, Username, Email, UserStatus FROM Users WHERE Username LIKE ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + username + "%"); // Tìm kiếm gần đúng với LIKE
            rs = ps.executeQuery();
            while (rs.next()) {
                accounts.add(new Account(
                    rs.getInt("UserID"),
                    rs.getInt("RoleID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getBoolean("UserStatus")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accounts;
    }

    // 🟢 Cập nhật trạng thái tài khoản (Enable = 1, Disable = 0)
    public boolean updateAccountStatus(int userID, int newStatus) {
        String query = "UPDATE Users SET UserStatus = ? WHERE UserID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, newStatus);
            ps.setInt(2, userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}