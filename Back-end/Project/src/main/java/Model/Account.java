package Model;

public class Account {
    private int userID;
    private int roleID;
    private String username;
    private String email;
    private boolean userStatus;

    public Account() {}

    public Account(int userID, int roleID, String username, String email, boolean userStatus) {
        this.userID = userID;
        this.roleID = roleID;
        this.username = username;
        this.email = email;
        this.userStatus = userStatus;
    }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public int getRoleID() { return roleID; }
    public void setRoleID(int roleID) { this.roleID = roleID; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public boolean getUserStatus() { return userStatus; }
    public void setUserStatus(boolean userStatus) { this.userStatus = userStatus; }
}
