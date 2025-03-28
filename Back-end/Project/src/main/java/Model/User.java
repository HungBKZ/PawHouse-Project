/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class User {

    private int userID;
    private Role role;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private String avatar;
    private int userStatus; // Đổi từ boolean sang int để tương ứng với BIT
    private String address;

    public User(int userID, Role role, String username, String password, String email, String fullName, String phone, String avatar, int userStatus, String address) {
        this.userID = userID;
        this.role = role;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.avatar = avatar;
        this.userStatus = userStatus;
        this.address = address;
    }

    public User(String username, String password, String email, String fullName, String phone, String address, int userStatus) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.userStatus = userStatus;
    }

    public User(int userID, String username, String fullName) {
        this.userID = userID;
        this.username = username;
        this.fullName = fullName;
    }

    public User() {
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
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

    public int getUserStatus() { // Đổi từ isUserStatus() sang getUserStatus()
        return userStatus;
    }

    public void setUserStatus(int userStatus) { // Đổi từ boolean sang int
        this.userStatus = userStatus;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public User(int userID) {
        this.userID = userID;
    }
}