package Model;

public class GoogleAccount {

    private String email;
    private String name;
    private String picture;

    public GoogleAccount(String email, String name, String picture) {
        this.email = email;
        this.name = name;
        this.picture = picture;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Override
    public String toString() {
        return "GoogleAccount{"
                + "email='" + email + '\''
                + ", name='" + name + '\''
                + ", picture='" + picture + '\''
                + '}';
    }
}
