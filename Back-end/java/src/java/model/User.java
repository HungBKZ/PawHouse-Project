package model;

public class User {
    private int userID;
    private int roleID;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private String avatar;
    private boolean status;

    public User() {
    }

    public User(int userID, int roleID, String username, String password, String email, String fullName, String phone, String avatar, boolean status) {
        this.userID = userID;
        this.roleID = roleID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.avatar = avatar;
        this.status = status;
    }

    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
